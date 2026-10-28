<?php
/**
 * CDK 礼包系统 —— 核心逻辑
 * ------------------------------------------------------------
 * 被两处复用：
 *   gm/api.php        GM 后台生成 / 管理
 *   cdk/index.php     玩家兑换
 *
 * 设计要点：
 *   1. 礼包内容存成结构化 JSON，兑换时统一走 gm_give_item / gm_give_equip
 *   2. 兑换用事务 + 行锁，防止并发同一码被兑换两次
 *   3. 有效期用 DATETIME NULL 表示不限，不用魔法值
 */

defined('GM_ROOT') || define('GM_ROOT', dirname(__DIR__));

/* ------------------------------------------------------------
   建表（幂等）
   ------------------------------------------------------------ */
function cdk_ensure_tables()
{
    static $done = false;
    if ($done) return;

    // gm_db() 连接后未选库，这里必须显式切到 xyy
    gm_use_game();

    gm_exec("create table if not exists gm_gift (
        id int(11) not null auto_increment,
        name varchar(64) not null default '',
        remark varchar(255) not null default '',
        content text not null,
        claim_limit int(11) not null default 1,
        per_player int(11) not null default 1,
        status tinyint(1) not null default 1,
        creator varchar(64) not null default '',
        created_at datetime not null,
        primary key (id)
    ) engine=InnoDB default charset=utf8");

    gm_exec("create table if not exists gm_cdk (
        id int(11) not null auto_increment,
        code varchar(32) not null,
        gift_id int(11) not null default 0,
        batch varchar(32) not null default '',
        start_at datetime null,
        end_at datetime null,
        limit_total int(11) not null default 0,
        used int(11) not null default 0,
        status tinyint(1) not null default 1,
        created_at datetime not null,
        primary key (id),
        unique key uk_code (code),
        key idx_gift (gift_id),
        key idx_batch (batch)
    ) engine=InnoDB default charset=utf8");

    gm_exec("create table if not exists gm_cdk_log (
        id int(11) not null auto_increment,
        cdk_id int(11) not null default 0,
        code varchar(32) not null default '',
        gift_id int(11) not null default 0,
        wjid int(11) not null default 0,
        nick varchar(64) not null default '',
        ip varchar(46) not null default '',
        created_at datetime not null,
        primary key (id),
        key idx_cdk (cdk_id),
        key idx_wjid (wjid),
        unique key uk_cdk_player (cdk_id, wjid)
    ) engine=InnoDB default charset=utf8");

    $done = true;
}

/* ------------------------------------------------------------
   生成 CDK 码
   ------------------------------------------------------------
   字符集去掉了 0/O/1/I/L 这些易混淆的，玩家手输不容易错。
   ------------------------------------------------------------ */
function cdk_alphabet()
{
    return '23456789ABCDEFGHJKMNPQRSTUVWXYZ';
}

function cdk_generate($len = 12)
{
    $alpha = cdk_alphabet();
    $max   = strlen($alpha) - 1;
    $out   = '';
    for ($i = 0; $i < $len; $i++) {
        $out .= $alpha[mt_rand(0, $max)];
    }
    return $out;
}

/** 带前缀和分组，如 VIP-A3KP-9QRT-M2XN */
function cdk_format($raw, $prefix = '', $group = 4)
{
    $raw = strtoupper(preg_replace('/[^A-Za-z0-9]/', '', $raw));
    if ($group > 0) {
        $raw = implode('-', str_split($raw, $group));
    }
    return $prefix !== '' ? strtoupper($prefix) . '-' . $raw : $raw;
}

/** 归一化：去掉分隔符和空格，统一大写，用于查询比对 */
function cdk_normalize($code)
{
    return strtoupper(preg_replace('/[^A-Za-z0-9]/', '', (string)$code));
}

/* ------------------------------------------------------------
   礼包内容解析
   ------------------------------------------------------------
   格式（存 JSON）：
   {
     "items":  [{"id":1001,"num":5}, ...],
     "equips": [{"id":12,"star":3}, ...],
     "money":  100000,
     "gold":   50,
     "vip":    0
   }
   ------------------------------------------------------------ */
function cdk_parse_content($json)
{
    $c = json_decode((string)$json, true);
    if (!is_array($c)) $c = array();

    $out = array(
        'items'  => array(),
        'equips' => array(),
        'money'  => 0,
        'gold'   => 0,
        'vip'    => 0,
    );

    if (isset($c['items']) && is_array($c['items'])) {
        foreach ($c['items'] as $it) {
            $id  = isset($it['id'])  ? (int)$it['id']  : 0;
            $num = isset($it['num']) ? (int)$it['num'] : 0;
            if ($id > 0 && $num > 0) {
                $out['items'][] = array('id' => $id, 'num' => $num);
            }
        }
    }

    if (isset($c['equips']) && is_array($c['equips'])) {
        foreach ($c['equips'] as $eq) {
            $id   = isset($eq['id'])   ? (int)$eq['id']   : 0;
            $star = isset($eq['star']) ? (int)$eq['star'] : 0;
            if ($id > 0) {
                $out['equips'][] = array('id' => $id, 'star' => max(0, min(15, $star)));
            }
        }
    }

    $out['money'] = isset($c['money']) ? max(0, (int)$c['money']) : 0;
    $out['gold']  = isset($c['gold'])  ? max(0, (int)$c['gold'])  : 0;
    $out['vip']   = isset($c['vip'])   ? max(0, (int)$c['vip'])   : 0;

    return $out;
}

/** 内容是否为空礼包 */
function cdk_content_is_empty($c)
{
    return empty($c['items']) && empty($c['equips'])
        && $c['money'] <= 0 && $c['gold'] <= 0 && $c['vip'] <= 0;
}

/* ------------------------------------------------------------
   发货
   ------------------------------------------------------------ */
/**
 * 发放物品到增值仓库 zzck<wjid>
 * 与 GM 后台 items.offer 保持同一套逻辑
 */
function cdk_give_item($wid, $wpId, $num)
{
    $tbl = 'zzck' . (int)$wid;
    if (!gm_val("show tables like '$tbl'")) {
        throw new Exception("玩家 {$wid} 的仓库表不存在");
    }

    $cur = gm_val("select wpsl from $tbl where wpid=" . (int)$wpId . " limit 1", null);
    if ($cur !== null) {
        gm_exec("update $tbl set wpsl = wpsl + " . (int)$num . " where wpid=" . (int)$wpId);
    } else {
        $maxId = (int)gm_val("select ifnull(max(id),0) from $tbl", 0);
        gm_exec("insert into $tbl (id, wpid, wpsl, wpfl) values ("
            . ($maxId + 1) . ", " . (int)$wpId . ", " . (int)$num . ", 4)");
    }
    return true;
}

/**
 * 发放装备到 zb<wjid>
 */
function cdk_give_equip($wid, $zbId, $star)
{
    $tbl = 'zb' . (int)$wid;
    if (!gm_val("show tables like '$tbl'")) {
        throw new Exception("玩家 {$wid} 的装备表不存在");
    }

    $newId = (int)gm_val("select ifnull(max(id),0) from $tbl", 0) + 1;
    gm_exec("insert into $tbl
        (id, zbid, zbxj, zbk1, zbxq1, zbk2, zbxq2, zbk3, zbxq3, zbk4, zbxq4, zbk5, zbxq5, zbpd)
        values ($newId, " . (int)$zbId . ", " . (int)$star . ", 0,0, 0,0, 0,0, 0,0, 0,0, 0)");
    return $newId;
}

/** 清物品缓存，让游戏重读 ini */
function cdk_clear_cache($wid)
{
    if (function_exists('gm_clear_item_cache')) {
        gm_clear_item_cache($wid);
        return;
    }
    $dir = gm_ache_root() . '/' . (int)$wid;
    foreach (array('zzck.ini', 'wp.ini', 'wpp.ini', 'zb.ini') as $f) {
        $p = $dir . '/' . $f;
        if (is_file($p)) @unlink($p);
    }
}

/* ------------------------------------------------------------
   兑换
   ------------------------------------------------------------
   防并发：整个过程在事务里，先用 select ... for update 锁住该行，
   再校验、写记录、加物品。同一码被同时点两次也不会重复发。
   ------------------------------------------------------------ */
function cdk_redeem($code, $wid, $nick, $ip)
{
    cdk_ensure_tables();

    $code = cdk_normalize($code);
    if ($code === '') {
        return array('ok' => false, 'error' => '请输入兑换码');
    }
    if (strlen($code) < 6) {
        return array('ok' => false, 'error' => '兑换码格式不正确');
    }

    $wid = (int)$wid;
    if ($wid <= 0) {
        return array('ok' => false, 'error' => '未获取到角色，请重新登录');
    }

    gm_use_game();
    $link = gm_db();
    gm_exec("start transaction");

    try {
        // 锁住这一行，后续并发请求会在此等待
        $cdk = gm_row(
            "select * from gm_cdk where code='" . gm_esc($code) . "' limit 1 for update"
        );

        if (!$cdk) {
            throw new Exception('兑换码不存在');
        }

        if ((int)$cdk['status'] !== 1) {
            throw new Exception('该兑换码已停用');
        }

        // 有效期
        $now = date('Y-m-d H:i:s');
        if (!empty($cdk['start_at']) && $now < $cdk['start_at']) {
            throw new Exception('兑换尚未开始，开始时间 ' . $cdk['start_at']);
        }
        if (!empty($cdk['end_at']) && $now > $cdk['end_at']) {
            throw new Exception('兑换码已过期');
        }

        // 总量限制
        $limitTotal = (int)$cdk['limit_total'];
        if ($limitTotal > 0 && (int)$cdk['used'] >= $limitTotal) {
            throw new Exception('该兑换码已被领完');
        }

        // 同一玩家重复领取
        $dup = gm_val(
            "select id from gm_cdk_log where cdk_id=" . (int)$cdk['id']
            . " and wjid=$wid limit 1",
            null
        );
        if ($dup !== null) {
            throw new Exception('你已经兑换过这个码了');
        }

        $gift = gm_row("select * from gm_gift where id=" . (int)$cdk['gift_id'] . " limit 1");
        if (!$gift) {
            throw new Exception('礼包不存在或已被删除');
        }
        if ((int)$gift['status'] !== 1) {
            throw new Exception('该礼包已下架');
        }

        $per = (int)$gift['per_player'];
        if ($per > 0) {
            $cnt = (int)gm_val(
                "select count(*) from gm_cdk_log where gift_id=" . (int)$gift['id']
                . " and wjid=$wid",
                0
            );
            if ($cnt >= $per) {
                throw new Exception("该礼包每人限领 {$per} 次");
            }
        }

        // ---- 发货 ----
        $content = cdk_parse_content($gift['content']);
        if (cdk_content_is_empty($content)) {
            throw new Exception('礼包内容为空，请联系客服');
        }

        foreach ($content['items'] as $it) {
            cdk_give_item($wid, $it['id'], $it['num']);
        }
        foreach ($content['equips'] as $eq) {
            cdk_give_equip($wid, $eq['id'], $eq['star']);
        }
        if ($content['money'] > 0) {
            cdk_add_money($wid, $content['money']);
        }
        if ($content['gold'] > 0) {
            cdk_add_gold($wid, $content['gold']);
        }
        if ($content['vip'] > 0) {
            cdk_set_vip($wid, $content['vip']);
        }

        // 记录 + 计数
        gm_exec("insert into gm_cdk_log
            (cdk_id, code, gift_id, wjid, nick, ip, created_at)
            values (" . (int)$cdk['id'] . ", '" . gm_esc($code) . "', "
            . (int)$gift['id'] . ", $wid, '" . gm_esc($nick) . "', '"
            . gm_esc($ip) . "', '$now')");

        gm_exec("update gm_cdk set used = used + 1 where id=" . (int)$cdk['id']);

        gm_exec("commit");

        cdk_clear_cache($wid);

        return array(
            'ok'      => true,
            'gift'    => $gift['name'],
            'content' => $content,
        );

    } catch (Exception $ex) {
        gm_exec("rollback");
        return array('ok' => false, 'error' => $ex->getMessage());
    }
}

/* ------------------------------------------------------------
   附加发放：银两 / 元宝 / VIP
   ------------------------------------------------------------ */
function cdk_add_money($wid, $amt)
{
    $wid = (int)$wid;
    $amt = (int)$amt;
    if ($amt <= 0) return;

    $exists = (int)gm_val("select count(*) from all_money where wjid=$wid", 0);
    if ($exists > 0) {
        gm_exec("update all_money set money = money + $amt where wjid=$wid");
    } else {
        $name = gm_esc((string)gm_val("select username from all_zt where wjid=$wid", ''));
        gm_exec("insert into all_money (wjid, money, wjmz) values ($wid, $amt, '$name')");
    }
}

function cdk_add_gold($wid, $amt)
{
    $wid = (int)$wid;
    $amt = (int)$amt;
    if ($amt <= 0) return;

    // 元宝在玩家存档 ini 的 [充值信息] 里，DB 无对应列，
    // 这里只做记录，实际到账由 cdk_apply_gold_ini 处理
    cdk_apply_gold_ini($wid, $amt);
}

/**
 * 元宝走 ini：定位 ache/<wjid>/user.ini 的 [充值信息][元宝]
 */
function cdk_apply_gold_ini($wid, $amt)
{
    $dir = gm_ache_root() . '/' . (int)$wid;
    if (!is_dir($dir)) return false;

    $found = false;
    $files = glob($dir . '/*.ini');
    if (!is_array($files)) return false;

    foreach ($files as $f) {
        $txt = @file_get_contents($f);
        if ($txt === false) continue;
        if (strpos($txt, '元宝') === false) continue;

        // 只改第一个含「元宝」的配置节
        $new = preg_replace_callback(
            '/(元宝\s*=\s*)(-?[0-9]+)/u',
            function ($m) use ($amt) {
                return $m[1] . ((int)$m[2] + $amt);
            },
            $txt,
            1
        );
        if ($new !== null && $new !== $txt) {
            @file_put_contents($f, $new);
            $found = true;
            break;
        }
    }
    return $found;
}

function cdk_set_vip($wid, $vip)
{
    $wid = (int)$wid;
    $vip = (int)$vip;
    if ($vip <= 0) return;
    gm_exec("update all_zt set vip=$vip where wjid=$wid");
}
