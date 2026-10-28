<?php
/**
 * GM 控制台 - 统一 API
 * 所有管理操作走这里，前端只发 JSON。
 */

require_once __DIR__ . '/lib/db.php';
require_once __DIR__ . '/lib/auth.php';
require_once __DIR__ . '/lib/cdk.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

$action = isset($_REQUEST['action']) ? $_REQUEST['action'] : '';
if ($action === '') {
    gm_json_error('缺少 action');
}

$public = array('auth.login', 'auth.status');
if (!in_array($action, $public, true)) {
    gm_require_login();
}

$input = array_merge($_GET, $_POST);
$raw = file_get_contents('php://input');
if ($raw !== false && $raw !== '') {
    $j = json_decode($raw, true);
    if (is_array($j)) {
        $input = array_merge($input, $j);
    }
}

/** 清玩家物品/装备相关缓存，让游戏重新从数据库读取 */
function gm_clear_item_cache($wjid)
{
    $dir = gm_ache_root() . '/' . (int)$wjid;
    if (!is_dir($dir)) return 0;
    $n = 0;
    foreach (array('zb.ini','zbb.ini','zzck.ini','wp.ini','wpp.ini','ckzb.ini') as $f) {
        $fp = $dir . '/' . $f;
        if (is_file($fp) && @unlink($fp)) $n++;
    }
    return $n;
}

/** 递归删除目录，返回删除的文件数 */
function gm_rmdir($dir)
{
    if (!is_dir($dir)) return 0;
    $n = 0;
    $dh = @opendir($dir);
    if (!$dh) return 0;
    while (($f = readdir($dh)) !== false) {
        if ($f === '.' || $f === '..') continue;
        $p = $dir . '/' . $f;
        if (is_dir($p)) {
            $n += gm_rmdir($p);
        } else {
            if (@unlink($p)) $n++;
        }
    }
    closedir($dh);
    @rmdir($dir);
    return $n;
}

/** 玩家存档路径（游戏层） */
function gm_player_ini_path($wjid)
{
    $root = dirname(GM_ROOT);
    $p = $root . '/fqxy/ache/' . $wjid . '/user.ini';
    return is_file($p) ? $p : null;
}

/** 就地修改 ini 的某个键（保留其它内容与行尾风格） */
function gm_ini_set($file, $section, $key, $value)
{
    $s = @file_get_contents($file);
    if ($s === false) return false;

    $nl = strpos($s, "\r\n") !== false ? "\r\n" : "\n";
    $escaped = str_replace(array("\r", "\n"), '', (string)$value);

    $pattern = '/(' . preg_quote($key, '/') . '\s*=\s*)[^\r\n]*/u';
    if (preg_match($pattern, $s)) {
        $s = preg_replace($pattern, '${1}' . $escaped, $s, 1);
        return file_put_contents($file, $s) !== false;
    }

    if (strpos($s, '[' . $section . ']') !== false) {
        $s = preg_replace(
            '/\[' . preg_quote($section, '/') . '\]\r?\n/',
            '[' . $section . ']' . $nl . $key . ' = ' . $escaped . $nl,
            $s,
            1
        );
    } else {
        $s .= $nl . '[' . $section . ']' . $nl . $key . ' = ' . $escaped . $nl;
    }
    return file_put_contents($file, $s) !== false;
}


switch ($action) {

    case 'auth.status':
        $u = gm_user();
        gm_json(array('ok' => true, 'loggedIn' => $u !== null, 'user' => $u));
        break;

    case 'auth.login':
        $r = gm_login(
            isset($input['username']) ? $input['username'] : '',
            isset($input['password']) ? $input['password'] : ''
        );
        gm_json($r, $r['ok'] ? 200 : 401);
        break;

    case 'auth.logout':
        gm_logout();
        gm_json_ok();
        break;

    case 'stats.overview':
        gm_use_game();
        $totalPlayers = (int)gm_val('select count(*) from all_zt', 0);
        // 活跃度取自存档文件的修改时间（all_ip 表原端不写入）
        $ache  = gm_ache_scan();
        $todayStart = strtotime('today');
        $todayActive = 0;
        $weekActive  = 0;
        $weekStart   = strtotime('-7 days');
        foreach ($ache as $wid => $info) {
            if ($info['mtime'] >= $todayStart) $todayActive++;
            if ($info['mtime'] >= $weekStart)  $weekActive++;
        }
        $banned       = (int)gm_val('select count(distinct wjid) from all_user where fl=1', 0);
        $vipCount     = (int)gm_val('select count(*) from all_zt where vip>0', 0);

        $moneySum = gm_val('select sum(money) from all_money');
        $moneySum = $moneySum === null ? 0 : (float)$moneySum;

        gm_use_account();
        $totalAccounts = (int)gm_val('select count(*) from o_user_list', 0);
        gm_use_game();

        $dist  = gm_rows("select dj as lv, count(*) as n from all_zt group by dj order by dj asc");
        // 注册趋势：all_user 为空时退化为存档创建时间
        $trend = gm_rows("select date(wjtime) as d, count(*) as n from all_user
                          where wjtime >= date_sub(curdate(), interval 13 day)
                          group by date(wjtime) order by d asc");
        if (!$trend) {
            $bucket = array();
            foreach ($ache as $wid => $info) {
                $day = date('Y-m-d', $info['mtime']);
                if (!isset($bucket[$day])) $bucket[$day] = 0;
                $bucket[$day]++;
            }
            ksort($bucket);
            foreach ($bucket as $d => $n) {
                $trend[] = array('d' => $d, 'n' => $n);
            }
            $trend = array_slice($trend, -14);
        }

        gm_json_ok(array(
            'players'     => $totalPlayers,
            'accounts'    => $totalAccounts,
            'activeToday' => $todayActive,
            'activeWeek'  => $weekActive,
            'banned'      => $banned,
            'vip'         => $vipCount,
            'moneyTotal'  => $moneySum,
            'levelDist'   => $dist,
            'regTrend'    => $trend,
        ));
        break;

    case 'players.search':
        gm_use_game();
        $kw    = isset($input['q']) ? trim($input['q']) : '';
        $limit = isset($input['limit']) ? max(1, min(200, (int)$input['limit'])) : 50;

        if ($kw === '') {
            $rows = gm_rows(
                "select z.wjid, z.username, z.dj, z.vip, z.sex,
                        m.money, u.wjtime
                 from all_zt z
                 left join all_money m on m.wjid = z.wjid
                 left join all_user u on u.wjid = z.wjid and u.fl=0
                 order by z.wjid desc limit $limit"
            );
        } else {
            $e = gm_esc($kw);
            $wjidCond = ctype_digit($kw) ? " or z.wjid = " . (int)$kw : '';
            $rows = gm_rows(
                "select z.wjid, z.username, z.dj, z.vip, z.sex,
                        m.money, u.wjtime
                 from all_zt z
                 left join all_money m on m.wjid = z.wjid
                 left join all_user u on u.wjid = z.wjid and u.fl=0
                 where z.username like '%$e%' $wjidCond
                 order by z.wjid desc limit $limit"
            );
        }

        foreach ($rows as &$r) {
            $wid = (int)$r['wjid'];
            $r['banned'] = gm_val("select count(*) from all_user where wjid=$wid and fl=1") > 0;
            $r['money']  = isset($r['money']) ? (float)$r['money'] : 0;
        }
        unset($r);

        gm_json_ok(array('rows' => $rows, 'total' => count($rows)));
        break;

    case 'players.detail':
        gm_use_game();
        $wid = isset($input['wjid']) ? (int)$input['wjid'] : 0;
        if ($wid <= 0) gm_json_error('缺少玩家ID');

        $p = gm_row("select * from all_zt where wjid=$wid limit 1");
        if (!$p) gm_json_error('玩家不存在', 404);

        $money     = gm_val("select money from all_money where wjid=$wid", 0);
        $banned    = gm_val("select count(*) from all_user where wjid=$wid and fl=1", 0) > 0;
        $banReason = gm_val("select yj from all_user where wjid=$wid and fl=1 limit 1", '');
        $lastIp    = gm_row("select ip, iptime from all_ip where wjid=$wid order by iptime desc limit 1");

        $uid = $wid - 10000000;
        gm_use_account();
        $acc = gm_row("select uid,username,name from o_user_list where uid=$uid limit 1");
        gm_use_game();

        $bagCount = 0;
        $wpTable = gm_val("show tables like 'wp$wid'");
        if ($wpTable) {
            $bagCount = (int)gm_val("select count(*) from wp$wid", 0);
        }

        // 存档层：进度、文件数、最近活动时间
        $ache = gm_ache_scan();
        $save = isset($ache[$wid]) ? $ache[$wid] : null;
        $page = gm_ache_get($wid, 'cmid值', '0');
        $mapX = gm_ache_get($wid, 'x', '0');
        $mapY = gm_ache_get($wid, 'y', '0');
        $mute = gm_ache_get($wid, '解除变量', '');
        $hasSave = $save !== null;

        // 玩家装备（zb<wjid>）
        $equipRows = array();
        $zbTbl = 'zb' . $wid;
        if (gm_val("show tables like '$zbTbl'")) {
            $raw = gm_rows("select id, zbid, zbxj, zbpd from $zbTbl order by id asc limit 50");
            $eqIdx = array();
            $eqFile = GM_ROOT . '/data/equips.min.json';
            if (is_file($eqFile)) {
                $arr = json_decode(file_get_contents($eqFile), true);
                if (is_array($arr)) foreach ($arr as $e) $eqIdx[$e['i']] = $e;
            }
            foreach ($raw as $r) {
                $zid = (int)$r['zbid'];
                $eq = isset($eqIdx[$zid]) ? $eqIdx[$zid] : array();
                $equipRows[] = array(
                    'id'     => (int)$r['id'],
                    'zbid'   => $zid,
                    'name'   => isset($eq['n']) ? $eq['n'] : ('装备#' . $zid),
                    'star'   => (int)$r['zbxj'],
                    'equipped' => (int)$r['zbpd'] === 1,
                    'atk'    => isset($eq['atk']) ? $eq['atk'] : 0,
                    'def'    => isset($eq['def']) ? $eq['def'] : 0,
                    'lv'     => isset($eq['lv']) ? $eq['lv'] : 0,
                );
            }
        }

        gm_json_ok(array(
            'player'    => $p,
            'money'     => (float)$money,
            'banned'    => (bool)$banned,
            'banReason' => $banReason,
            'lastIp'    => $lastIp,
            'account'   => $acc,
            'bagCount'  => $bagCount,
            'equips'    => $equipRows,
            'save'      => $hasSave ? array(
                'exists'  => true,
                'mtime'   => date('Y-m-d H:i:s', $save['mtime']),
                'files'   => $save['files'],
                'size'    => $save['size'],
                'page'    => $page,
                'map'     => $mapX . ',' . $mapY,
                'muted'   => $mute !== '',
            ) : array('exists' => false),
        ));
        break;

    case 'players.rename':
        gm_use_game();
        $wid  = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $name = trim(isset($input['name']) ? $input['name'] : '');
        if ($wid <= 0 || $name === '') gm_json_error('参数不完整');

        $e = gm_esc($name);
        gm_exec("update all_zt set username='$e' where wjid=$wid");
        gm_exec("update all_money set wjmz='$e' where wjid=$wid");

        $ini = gm_player_ini_path($wid);
        if ($ini) {
            gm_ini_set($ini, '验证信息', '玩家昵称', $name);
        }
        gm_json_ok(array('name' => $name));
        break;

    case 'players.setLevel':
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $lv  = (int)(isset($input['level']) ? $input['level'] : 0);
        if ($wid <= 0) gm_json_error('缺少玩家ID');
        if ($lv < 1 || $lv > 999) gm_json_error('等级需在 1-999 之间');
        gm_exec("update all_zt set dj=$lv where wjid=$wid");
        gm_json_ok(array('level' => $lv));
        break;

    case 'players.setMoney':
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $amt = isset($input['money']) ? (float)$input['money'] : 0;
        if ($wid <= 0) gm_json_error('缺少玩家ID');
        if ($amt < 0) gm_json_error('数值不能为负');

        $exists = gm_val("select count(*) from all_money where wjid=$wid", 0);
        $name   = gm_esc((string)gm_val("select username from all_zt where wjid=$wid", ''));
        $v      = (int)$amt;

        if ($exists > 0) {
            gm_exec("update all_money set money=$v, wjmz='$name' where wjid=$wid");
        } else {
            gm_exec("insert into all_money (wjid, wjmz, money) values ($wid,'$name',$v)");
        }
        gm_json_ok(array('money' => $v));
        break;

    case 'players.ban':
        gm_use_game();
        $wid    = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $reason = gm_esc(trim(isset($input['reason']) ? $input['reason'] : '违反游戏规则'));
        if ($wid <= 0) gm_json_error('缺少玩家ID');

        gm_exec("delete from all_user where wjid=$wid and fl=1");
        gm_exec("insert into all_user (wjid, id, wjname, wjtime, utime, fl, yj)
                 values ($wid, $wid, '', now(), " . time() . ", 1, '$reason')");
        gm_json_ok(array('banned' => true, 'reason' => $reason));
        break;

    case 'players.unban':
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        if ($wid <= 0) gm_json_error('缺少玩家ID');

        gm_exec("delete from all_user where wjid=$wid and fl=1");

        $ini = gm_player_ini_path($wid);
        if ($ini) {
            gm_ini_set($ini, '禁言信息', '解除变量', '');
            gm_ini_set($ini, '禁言信息', '永久', '');
        }
        gm_json_ok(array('banned' => false));
        break;

    case 'players.mute':
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $sec = (int)(isset($input['seconds']) ? $input['seconds'] : 0);
        if ($wid <= 0) gm_json_error('缺少玩家ID');

        $ini = gm_player_ini_path($wid);
        if (!$ini) gm_json_error('该玩家无存档，可能从未进入游戏');

        gm_ini_set($ini, '禁言信息', '禁言时间', date('Y-m-d H:i:s'));
        gm_ini_set($ini, '禁言信息', '解除变量', (string)$sec);
        gm_ini_set($ini, '禁言信息', '永久', $sec >= 315360000 ? '2' : '1');
        gm_json_ok(array('seconds' => $sec));
        break;

    case 'items.offer':
        // 发到玩家的「增值仓库」（zzck<wjid>），与原版 gm05/gm07 一致。
        //
        // 原版行为：写 zzck 表 → 游戏首页「增值仓库」里领取。
        // 注意这里不能用 wp 表（那是背包），而且两类表都依赖
        // ache/<wjid>/xxx.ini 缓存，写完必须删缓存让游戏重建。
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $wp  = (int)(isset($input['wpid']) ? $input['wpid'] : 0);
        $num = (int)(isset($input['num']) ? $input['num'] : 1);
        if ($wid <= 0 || $wp <= 0) gm_json_error('参数不完整');
        if ($num < 1 || $num > 9999) gm_json_error('数量需在 1-9999');

        $tbl = 'zzck' . $wid;
        if (!gm_val("show tables like '$tbl'")) {
            gm_json_error('该玩家没有仓库表，请先让其进入一次游戏');
        }

        // 已存在则累加，否则插入
        $cur = gm_val("select wpsl from $tbl where wpid=$wp limit 1", null);
        if ($cur !== null) {
            gm_exec("update $tbl set wpsl = wpsl + $num where wpid=$wp");
        } else {
            $maxId = (int)gm_val("select ifnull(max(id),0) from $tbl", 0);
            $newId = $maxId + 1;
            gm_exec("insert into $tbl (id, wpid, wpsl, wpfl) values ($newId, $wp, $num, 4)");
        }

        // 清缓存，游戏下次进入时从数据库重建
        $cacheDir = gm_ache_root() . '/' . $wid;
        $cleared = 0;
        foreach (array('zzck.ini', 'wp.ini', 'wpp.ini') as $f) {
            $fp = $cacheDir . '/' . $f;
            if (is_file($fp) && @unlink($fp)) $cleared++;
        }

        gm_json_ok(array(
            'wpid'    => $wp,
            'num'     => $num,
            'table'   => $tbl,
            'cleared' => $cleared,
            'hint'    => '玩家进入游戏首页 → 增值仓库 即可领取',
        ));
        break;

    case 'messages.broadcast':
        gm_use_game();
        $msg = trim(isset($input['text']) ? $input['text'] : '');
        if ($msg === '') gm_json_error('公告内容不能为空');

        $e = gm_esc($msg);
        gm_exec("insert into all_ip (ip, iptime, wjid, wjname)
                 values ('[GM] $e', now(), 0, '系统')");
        gm_json_ok(array('text' => $msg));
        break;

    case 'world.rank':
        gm_use_game();
        $by = isset($input['by']) ? $input['by'] : 'level';
        $limit = 20;

        if ($by === 'money') {
            $rows = gm_rows("select wjid, wjmz as name, money as score
                             from all_money order by money desc limit $limit");
        } else {
            $rows = gm_rows("select wjid, username as name, dj as score
                             from all_zt order by dj desc, wjid asc limit $limit");
        }
        gm_json_ok(array('rows' => $rows, 'by' => $by));
        break;

    case 'world.logins':
        // 用存档时间 + 存档内进度推断活跃，all_ip 原端不写入
        gm_use_game();
        $ache = gm_ache_scan();
        arsort($ache);

        $rows = array();
        $i = 0;
        foreach ($ache as $wid => $info) {
            if ($i++ >= 30) break;
            $name = gm_val("select username from all_zt where wjid=$wid", '');
            $rows[] = array(
                'wjid'   => $wid,
                'wjname' => $name !== null ? $name : '',
                'ip'     => '页面 ' . gm_ache_get($wid, 'cmid值', '0'),
                'iptime' => date('Y-m-d H:i:s', $info['mtime']),
                'files'  => $info['files'],
            );
        }
        gm_json_ok(array('rows' => $rows));
        break;

    case 'players.batch':
        // 批量操作：多个玩家一次性改等级 / 发放银两
        gm_use_game();
        $ids = isset($input['wjids']) ? $input['wjids'] : '';
        $op  = isset($input['op']) ? $input['op'] : '';
        $val = isset($input['value']) ? (int)$input['value'] : 0;

        $list = array();
        foreach (preg_split('/[,s]+/', (string)$ids) as $x) {
            $x = (int)$x;
            if ($x > 10000000) $list[] = $x;
        }
        $list = array_values(array_unique($list));
        if (!$list) gm_json_error('没有有效的玩家ID');
        if (count($list) > 100) gm_json_error('单次最多 100 个玩家');
        if (!in_array($op, array('level', 'money'), true)) gm_json_error('未知操作类型');
        if ($val < 0) gm_json_error('数值不能为负');

        $in = implode(',', $list);
        $affected = 0;

        if ($op === 'level') {
            if ($val < 1 || $val > 999) gm_json_error('等级需在 1-999');
            $affected = (int)gm_exec("update all_zt set dj=$val where wjid in ($in)");
        } else {
            foreach ($list as $wid) {
                $exists = gm_val("select count(*) from all_money where wjid=$wid", 0);
                $name = gm_esc((string)gm_val("select username from all_zt where wjid=$wid", ''));
                if ($exists > 0) {
                    gm_exec("update all_money set money=$val, wjmz='$name' where wjid=$wid");
                } else {
                    gm_exec("insert into all_money (wjid, wjmz, money) values ($wid,'$name',$val)");
                }
                $affected++;
            }
        }
        gm_json_ok(array('affected' => $affected, 'op' => $op, 'value' => $val));
        break;

    case 'stats.tables':
        // 数据库概览：表数量与体量，便于运维判断
        gm_use_game();
        $rows = gm_rows(
            "select table_name as name, table_rows as rows_est,
                    round((data_length + index_length) / 1024, 1) as kb
             from information_schema.tables
             where table_schema = 'xyy'
             order by (data_length + index_length) desc
             limit 20"
        );
        $total = (int)gm_val(
            "select count(*) from information_schema.tables where table_schema='xyy'", 0
        );
        $sizeKb = (float)gm_val(
            "select round(sum(data_length + index_length)/1024, 1)
             from information_schema.tables where table_schema='xyy'", 0
        );
        gm_json_ok(array('total' => $total, 'sizeKb' => $sizeKb, 'top' => $rows));
        break;

    // ================= 原版 GM 功能：缓存刷新 =================
    case 'system.refreshPlayer':
        // 原版 gm21：删除玩家 ache 缓存，强制游戏从数据库重建
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        if ($wid <= 0) gm_json_error('缺少玩家ID');

        $dir = gm_ache_root() . '/' . $wid;
        if (!is_dir($dir)) gm_json_error('该玩家没有存档目录');

        $n = gm_rmdir($dir);
        gm_json_ok(array('removed' => $n, 'path' => 'ache/' . $wid));
        break;

    case 'system.refreshPublic':
        // 原版 gm22/23：清理公共缓存
        //
        // 注意：只删缓存文件，保留目录结构。
        // acher 下的 hdjc / map / guoz / phb 等目录是运行期必需的，
        // 原端脚本直接 fopen 写入，不会自己 mkdir，删掉会导致首页锁文件
        // 无法创建，表现就是等 5 秒后报「服务器开小差了」。
        $root = dirname(GM_ROOT) . '/fqxy/acher';
        if (!is_dir($root)) gm_json_error('公共缓存目录不存在');

        $removed = 0;
        $keepFiles = array('index.php', 'index1.php');

        $dh = @opendir($root);
        if ($dh) {
            while (($f = readdir($dh)) !== false) {
                if ($f === '.' || $f === '..') continue;
                if (in_array($f, $keepFiles, true)) continue;

                $p = $root . '/' . $f;

                if (is_dir($p)) {
                    // 目录保留，只清空里面的缓存文件
                    $inner = @scandir($p);
                    if ($inner) {
                        foreach ($inner as $g) {
                            if ($g === '.' || $g === '..') continue;
                            $gp = $p . '/' . $g;
                            if (is_file($gp) && @unlink($gp)) $removed++;
                        }
                    }
                } else {
                    if (@unlink($p)) $removed++;
                }
            }
            closedir($dh);
        }

        // 兜底：确保必需目录都在
        $need = array('hdjc','map','guoz','phb','boss','bp','bug','gz','lock','lt','ltbw','pm','all_boss');
        foreach ($need as $d) {
            $dp = $root . '/' . $d;
            if (!is_dir($dp)) @mkdir($dp, 0777, true);
        }

        gm_json_ok(array('removed' => $removed));
        break;

    case 'system.refreshRank':
        // 原版 gm37：重算排行榜（all_phb）
        gm_use_game();
        // all_phb 真实结构：id / wjid / wjmz / vip / phb1..phb8
        // phb1 = 等级榜，其余槽位留给财富、战力等榜单
        $rows = gm_rows("select wjid, username, dj, vip from all_zt
                         order by dj desc, wjid asc limit 100");
        gm_exec("delete from all_phb");

        $n = 0;
        foreach ($rows as $i => $r) {
            $wid  = (int)$r['wjid'];
            $name = gm_esc($r['username']);
            $vip  = (int)$r['vip'];
            $lv   = (int)$r['dj'];

            $sql = "insert into all_phb (id, wjid, wjmz, vip, phb1, phb2, phb3, phb4, phb5, phb6, phb7, phb8)
                    values ($wid, $wid, '$name', $vip, '$lv', '', '', '', '', '', '', '')";
            if (gm_exec($sql) !== false) $n++;
        }
        gm_json_ok(array('updated' => $n));
        break;

    // ================= 原版 GM 功能：全服操作 =================
    case 'system.giveAll':
        // 全服发放：同样写 zzck（增值仓库），并清缓存
        gm_use_game();
        $wp = (int)(isset($input['wpid']) ? $input['wpid'] : 0);
        $num = (int)(isset($input['num']) ? $input['num'] : 1);
        if ($wp <= 0) gm_json_error('请选择物品');
        if ($num < 1 || $num > 999) gm_json_error('数量需在 1-999');

        $players = gm_rows("select wjid from all_zt");
        $ok = 0; $fail = 0; $cacheRoot = gm_ache_root();

        foreach ($players as $pl) {
            $wid = (int)$pl['wjid'];
            $tbl = 'zzck' . $wid;

            if (!gm_val("show tables like '$tbl'")) { $fail++; continue; }

            $cur = gm_val("select wpsl from $tbl where wpid=$wp limit 1", null);
            if ($cur !== null) {
                $r = gm_exec("update $tbl set wpsl = wpsl + $num where wpid=$wp");
            } else {
                $maxId = (int)gm_val("select ifnull(max(id),0) from $tbl", 0);
                $r = gm_exec("insert into $tbl (id, wpid, wpsl, wpfl) values (" . ($maxId+1) . ", $wp, $num, 4)");
            }

            if ($r !== false) {
                $ok++;
                foreach (array('zzck.ini','wp.ini','wpp.ini') as $f) {
                    $fp = $cacheRoot . '/' . $wid . '/' . $f;
                    if (is_file($fp)) @unlink($fp);
                }
            } else {
                $fail++;
            }
        }
        gm_json_ok(array('sent' => $ok, 'skipped' => $fail, 'total' => count($players)));
        break;

    case 'system.itemCount':
        // 原版 gm62/63：统计全服某物品总量（背包 + 仓库）
        gm_use_game();
        $wp = (int)(isset($input['wpid']) ? $input['wpid'] : 0);
        if ($wp <= 0) gm_json_error('请选择物品');

        $tables = gm_rows("show tables like 'wp1%'");
        $bagTotal = 0;
        $holders = array();

        if ($tables) {
            foreach ($tables as $t) {
                $name = array_values($t)[0];
                // 只认 wp + 8 位数字
                if (!preg_match('/^wp([0-9]{8})$/', $name, $m)) continue;
                $wid = (int)$m[1];
                $n = (int)gm_val("select wpsl from $name where wpid=$wp limit 1", 0);
                if ($n > 0) {
                    $bagTotal += $n;
                    $pname = gm_val("select username from all_zt where wjid=$wid", '#' . $wid);
                    $holders[] = array('wjid' => $wid, 'name' => $pname, 'num' => $n);
                }
            }
        }

        usort($holders, function ($a, $b) { return $b['num'] - $a['num']; });

        gm_json_ok(array(
            'wpid'    => $wp,
            'total'   => $bagTotal,
            'holders' => array_slice($holders, 0, 20),
        ));
        break;

    case 'system.setVip':
        // 补足原版没有的能力：设置 VIP 等级（原版只能改数据库）
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $vip = (int)(isset($input['vip']) ? $input['vip'] : 0);
        if ($wid <= 0) gm_json_error('缺少玩家ID');
        if ($vip < 0 || $vip > 20) gm_json_error('VIP 等级需在 0-20');
        gm_exec("update all_zt set vip=$vip where wjid=$wid");
        gm_json_ok(array('vip' => $vip));
        break;

    // ================= 原版：发布系统消息 =================
    // 原端机制：写 fqxy/msg/msg01~05.php，游戏读取后附在页面上，
    // 超过设定秒数自动过期（msgg03.php 里 unlink）。
    // 这里用同样的文件机制，保证消息真的能显示。
    case 'messages.system':
        $text = trim(isset($input['text']) ? $input['text'] : '');
        if ($text === '') gm_json_error('消息内容不能为空');
        if (mb_strlen($text, 'UTF-8') > 120) gm_json_error('系统消息不能超过 120 字');

        $msgDir = dirname(GM_ROOT) . '/fqxy/msg';
        if (!is_dir($msgDir)) gm_json_error('消息目录不存在');

        $color = isset($input['color']) ? preg_replace('/[^a-z]/', '', $input['color']) : 'red';
        if ($color === '') $color = 'red';

        // 找第一个空位（最多 5 条）
        $slot = 0;
        for ($i = 1; $i <= 5; $i++) {
            $f = $msgDir . '/msg0' . $i . '.php';
            if (!is_file($f)) { $slot = $i; break; }
            // 已过期的占位可复用
            if (time() - filemtime($f) > 30) { $slot = $i; break; }
        }
        if ($slot === 0) gm_json_error('系统消息已满 5 条，请等待过期');

        $safe = str_replace(array('<?', '?>', '<', '>'), '', $text);
        $safeQ = str_replace("'", "\'", $safe);

        // 逐行拼接，全部走单引号，杜绝 $ 插值
        $q = chr(39);
        $nl = PHP_EOL;
        $body  = '<?php' . $nl;
        $body .= '// GM 控制台发布，30 秒后自动过期' . $nl;
        $body .= '$msg = ' . $q . $safeQ . $q . ';' . $nl;
        $body .= '$msgcolor = ' . $q . $color . $q . ';' . $nl;
        $body .= 'echo ' . $q . '<font color=' . $q . ' . $msgcolor . ' . $q . '>[系统]' . $q . ' . $msg . ' . $q . '</font>' . $q . ';' . $nl;

        $target = $msgDir . '/msg0' . $slot . '.php';
        if (file_put_contents($target, $body) === false) {
            gm_json_error('写入失败，请检查 msg 目录权限');
        }
        @chmod($target, 0666);

        gm_json_ok(array('slot' => $slot, 'text' => $text, 'file' => 'msg0' . $slot . '.php'));
        break;

    case 'messages.clear':
        // 清空所有系统消息
        $msgDir = dirname(GM_ROOT) . '/fqxy/msg';
        $n = 0;
        for ($i = 1; $i <= 5; $i++) {
            $f = $msgDir . '/msg0' . $i . '.php';
            if (is_file($f) && @unlink($f)) $n++;
        }
        gm_json_ok(array('cleared' => $n));
        break;

    // ================= 原版：发布官方动态 =================
    // 数据落在 ache/xxzx.ini 的「咨询id/咨询标题/咨询内容」三组
    case 'news.publish':
        $title = trim(isset($input['title']) ? $input['title'] : '');
        $body  = trim(isset($input['body']) ? $input['body'] : '');
        if ($title === '') gm_json_error('请填写标题');

        $ini = dirname(GM_ROOT) . '/acher/xxzx.ini';
        $NL  = chr(10);
        $CR  = chr(13);

        if (!is_file($ini)) {
            $init  = '[玩家动态]' . $NL;
            $init .= '[咨询id]' . $NL . '初始 = 123' . $NL;
            $init .= '[咨询标题]' . $NL . '初始 = 123' . $NL;
            $init .= '[咨询内容]' . $NL . '初始 = 123' . $NL;
            @file_put_contents($ini, $init);
        }

        $src = @file_get_contents($ini);
        if ($src === false) gm_json_error('无法读取动态配置');

        // 找最大序号（用 [0-9] 代替 d，避免转义丢失）
        $maxId = 0;
        if (preg_match_all('/^([0-9]+)[ 	]*=/m', $src, $mm)) {
            foreach ($mm[1] as $n) { if ((int)$n > $maxId) $maxId = (int)$n; }
        }
        $next = $maxId + 1;

        // 清理非法字符
        $t = str_replace(array($CR, $NL, '='), '', $title);
        $b = str_replace(array($CR, $NL, '='), '', $body);

        // 定位段头并插入（段头用字面量，避免中括号被当正则元字符）
        $secId  = '[' . '咨询id' . ']';
        $secT   = '[' . '咨询标题' . ']';
        $secB   = '[' . '咨询内容' . ']';

        $pos = strpos($src, $secId);
        if ($pos !== false) {
            $ins = $pos + strlen($secId);
            // 跳过紧随的换行
            if (substr($src, $ins, 2) === $CR . $NL) $ins += 2;
            elseif (substr($src, $ins, 1) === $NL) $ins += 1;
            $src = substr($src, 0, $ins) . $next . ' = ' . $next . $NL . substr($src, $ins);
        }

        $pos = strpos($src, $secT);
        if ($pos !== false) {
            $ins = $pos + strlen($secT);
            if (substr($src, $ins, 2) === $CR . $NL) $ins += 2;
            elseif (substr($src, $ins, 1) === $NL) $ins += 1;
            $src = substr($src, 0, $ins) . $next . ' = ' . $t . $NL . substr($src, $ins);
        }

        $pos = strpos($src, $secB);
        if ($pos !== false) {
            $ins = $pos + strlen($secB);
            if (substr($src, $ins, 2) === $CR . $NL) $ins += 2;
            elseif (substr($src, $ins, 1) === $NL) $ins += 1;
            $src = substr($src, 0, $ins) . $next . ' = ' . $b . $NL . substr($src, $ins);
        }

        if (file_put_contents($ini, $src) === false) gm_json_error('写入失败');

        gm_json_ok(array('id' => $next, 'title' => $title));
        break;

    case 'news.list':
        $ini = dirname(GM_ROOT) . '/acher/xxzx.ini';
        if (!is_file($ini)) { gm_json_ok(array('rows' => array())); break; }

        $src = @file_get_contents($ini);
        if ($src === false) { gm_json_ok(array('rows' => array())); break; }

        $secId = '咨询id';
        $secT  = '咨询标题';
        $cur   = '';
        $ids   = array();
        $titles = array();

        foreach (preg_split('/[
]+/', $src) as $line) {
            $line = trim($line);
            if ($line === '') continue;

            // 段头
            if ($line[0] === '[' && substr($line, -1) === ']') {
                $cur = substr($line, 1, -1);
                continue;
            }

            $eq = strpos($line, '=');
            if ($eq === false) continue;

            $k = trim(substr($line, 0, $eq));
            $v = trim(substr($line, $eq + 1));
            if ($k === '初始') continue;

            if ($cur === $secId) $ids[$k] = $v;
            if ($cur === $secT)  $titles[$k] = $v;
        }

        $rows = array();
        foreach ($ids as $k => $v) {
            if (!isset($titles[$k])) continue;
            $ttl = $titles[$k];
            if ($ttl === '' || $ttl === '123') continue;
            $rows[] = array('id' => $k, 'title' => $ttl);
        }

        gm_json_ok(array('rows' => $rows));
        break;

    // ================= 原版：初始化奖池 =================
    case 'system.resetPool':
        gm_use_game();
        gm_exec('truncate table all_jc');

        // 清缓存文件（原版 gm39 同样做）
        $cache = dirname(GM_ROOT) . '/fqxy/acher/hdjc/hdjc.ini';
        if (is_file($cache)) @unlink($cache);

        gm_json_ok(array('done' => true));
        break;

    // ================= 原版：GM 代码查询 =================
    // 原版 gm24/26/27：把常用 GM 操作对应的代码文本列给管理员
    case 'system.codes':
        gm_json_ok(array('groups' => array(
            array('name' => '银两', 'code' => '$yl1=50000; $wwpsl=$yl1; include("./pz/ini_pz03.php");'),
            array('name' => '经验', 'code' => '$jy1=100000; include("./pz/ini_pz04.php");'),
            array('name' => '物品发放', 'code' => '在「操作 → 发放物品」里按分类挑选即可'),
            array('name' => '装备发放', 'code' => '在「操作 → 发放物品」选装备类物品'),
        )));
        break;

    // ================= 原版：全服统计 =================
    case 'system.serverStats':
        gm_use_game();
        $ache = gm_ache_scan();

        // 背包物品总量
        $tables = gm_rows("show tables like 'wp1%'");
        $bagItems = 0;
        $bagTables = 0;
        if ($tables) {
            foreach ($tables as $t) {
                $name = array_values($t)[0];
                if (!preg_match('/^wp([0-9]{8})$/', $name)) continue;
                $bagTables++;
                $bagItems += (int)gm_val("select ifnull(sum(wpsl),0) from $name", 0);
            }
        }

        $levelSum = (int)gm_val('select ifnull(sum(dj),0) from all_zt', 0);
        $lvCount  = (int)gm_val('select count(*) from all_zt', 0);

        gm_json_ok(array(
            'players'   => $lvCount,
            'saves'     => count($ache),
            'bagTables' => $bagTables,
            'bagItems'  => $bagItems,
            'avgLevel'  => $lvCount ? round($levelSum / $lvCount, 1) : 0,
            'channels'  => array(
                '充值订单' => '未接入支付',
                '红包系统' => '未接入支付',
                '兑换码'   => '依赖外部 SDK',
            ),
        ));
        break;

    // ================= 装备 =================
    // 原端每人一张 zb<wjid> 表：zbid=装备ID, zbxj=星级,
    // zbk1~5=孔位, zbxq1~5=镶嵌, zbpd=是否佩戴
    case 'equips.offer':
        gm_use_game();
        $wid  = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $zbid = (int)(isset($input['zbid']) ? $input['zbid'] : 0);
        $star = (int)(isset($input['star']) ? $input['star'] : 0);
        if ($wid <= 0 || $zbid <= 0) gm_json_error('参数不完整');
        if ($star < 0 || $star > 15) gm_json_error('星级需在 0-15');

        $tbl = 'zb' . $wid;
        if (!gm_val("show tables like '$tbl'")) {
            gm_json_error('该玩家没有装备表，请先让其进入一次游戏');
        }

        // 同 ID 同星级视为已有，累加数量（装备无数量字段，只能再插一条）
        $maxId = (int)gm_val("select ifnull(max(id),0) from $tbl", 0);
        $newId = $maxId + 1;

        $sql = "insert into $tbl
                (id, zbid, zbxj, zbk1, zbxq1, zbk2, zbxq2, zbk3, zbxq3, zbk4, zbxq4, zbk5, zbxq5, zbpd)
                values ($newId, $zbid, $star, 0,0, 0,0, 0,0, 0,0, 0,0, 0)";
        if (gm_exec($sql) === false) gm_json_error('写入失败');

        gm_clear_item_cache($wid);
        gm_json_ok(array('zbid' => $zbid, 'star' => $star, 'id' => $newId, 'table' => $tbl));
        break;

    case 'equips.list':
        // 查玩家当前装备
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        if ($wid <= 0) gm_json_error('缺少玩家ID');

        $tbl = 'zb' . $wid;
        if (!gm_val("show tables like '$tbl'")) {
            gm_json_ok(array('rows' => array()));
            break;
        }

        $rows = gm_rows("select * from $tbl order by id desc limit 100");

        // 挂上装备名字（从静态索引读，避免逐个查库）
        $idxFile = GM_ROOT . '/data/equips.min.json';
        $nameMap = array();
        if (is_file($idxFile)) {
            $arr = json_decode(file_get_contents($idxFile), true);
            if (is_array($arr)) {
                foreach ($arr as $e) $nameMap[$e['i']] = $e['n'];
            }
        }
        foreach ($rows as &$r) {
            $zid = (int)$r['zbid'];
            $r['name'] = isset($nameMap[$zid]) ? $nameMap[$zid] : ('装备#' . $zid);
        }
        unset($r);

        gm_json_ok(array('rows' => $rows));
        break;

    case 'equips.remove':
        gm_use_game();
        $wid = (int)(isset($input['wjid']) ? $input['wjid'] : 0);
        $id  = (int)(isset($input['id']) ? $input['id'] : 0);
        if ($wid <= 0 || $id <= 0) gm_json_error('参数不完整');

        $tbl = 'zb' . $wid;
        $n = gm_exec("delete from $tbl where id=$id");
        gm_clear_item_cache($wid);
        gm_json_ok(array('removed' => $n));
        break;

    // ================= GM 账号管理 =================
    case 'gm.list':
        gm_use_account();
        $rows = gm_rows("select uid, name, username from gmuser order by uid asc");
        gm_json_ok(array('rows' => $rows));
        break;

    case 'gm.create':
        gm_use_account();
        $user = trim(isset($input['username']) ? $input['username'] : '');
        $name = trim(isset($input['name']) ? $input['name'] : '');
        $pass = isset($input['password']) ? $input['password'] : '';

        if ($user === '' || $pass === '') gm_json_error('账号和密码不能为空');
        if (!preg_match('/^[A-Za-z0-9_]{3,25}$/', $user)) {
            gm_json_error('账号只能字母数字下划线，3-25 位');
        }
        if (strlen($pass) < 6) gm_json_error('密码至少 6 位');

        $e = gm_esc($user);
        if (gm_val("select count(*) from gmuser where username='$e'", 0) > 0) {
            gm_json_error('该账号已存在');
        }

        $hash = md5($pass . 'ALL_PS');
        $n = gm_esc($name !== '' ? $name : $user);
        gm_exec("insert into gmuser (name, username, password) values ('$n','$e','$hash')");

        gm_json_ok(array('username' => $user, 'name' => $n));
        break;

    case 'gm.resetPassword':
        gm_use_account();
        $user = trim(isset($input['username']) ? $input['username'] : '');
        $pass = isset($input['password']) ? $input['password'] : '';
        if ($user === '' || strlen($pass) < 6) gm_json_error('密码至少 6 位');

        $e = gm_esc($user);
        $hash = md5($pass . 'ALL_PS');
        $n = gm_exec("update gmuser set password='$hash' where username='$e'");
        if (!$n) gm_json_error('账号不存在或密码未变');
        gm_json_ok(array('username' => $user));
        break;

    case 'gm.delete':
        gm_use_account();
        $user = trim(isset($input['username']) ? $input['username'] : '');
        if ($user === '') gm_json_error('缺少账号');

        $me = gm_user();
        $e = gm_esc($user);
        $row = gm_row("select uid from gmuser where username='$e' limit 1");
        if (!$row) gm_json_error('账号不存在');
        if ($me && (int)$row['uid'] === (int)$me['uid']) {
            gm_json_error('不能删除当前登录的账号');
        }

        gm_exec("delete from gmuser where username='$e'");
        gm_json_ok(array('username' => $user));
        break;

    case 'gm.syncIni':
        // 原端两个 user2.ini 是 GM 登录缓存，换账号后需同步，
        // 否则旧缓存里的验证信息会让人以为「改密码没生效」
        $paths = array(
            dirname(GM_ROOT) . '/ache/gm/user2.ini',
            dirname(GM_ROOT) . '/fqxy/ache/gm/user2.ini',
        );
        $done = 0;
        foreach ($paths as $p) {
            if (is_file($p)) { if (@unlink($p)) $done++; }
            $dir = dirname($p);
            if (!is_dir($dir)) @mkdir($dir, 0777, true);
        }
        gm_json_ok(array('cleared' => $done, 'hint' => '下次 GM 登录会自动重建缓存'));
        break;

    default:
        // CDK 相关动作统一交给独立文件处理
        if (strpos($action, 'cdk.') === 0) {
            require __DIR__ . '/lib/cdk_api.php';
            exit;
        }
        gm_json_error('未知操作: ' . $action, 404);
}
