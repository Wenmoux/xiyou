<?php
/**
 * CDK 相关接口 —— 由 api.php 的 default 分支 include
 * 前提：$action / $input 已就绪，cdk.php 已加载
 */

gm_use_game();
cdk_ensure_tables();

switch ($action) {

    // ================= CDK 礼包系统 =================

    case 'cdk.gifts':
        cdk_ensure_tables();
        $rows = gm_rows("select * from gm_gift order by id desc limit 200");
        $out = array();
        foreach ($rows as $r) {
            $c = cdk_parse_content($r['content']);
            $out[] = array(
                'id'          => (int)$r['id'],
                'name'        => $r['name'],
                'remark'      => $r['remark'],
                'claim_limit' => (int)$r['claim_limit'],
                'per_player'  => (int)$r['per_player'],
                'status'      => (int)$r['status'],
                'created_at'  => $r['created_at'],
                'items'       => count($c['items']),
                'equips'      => count($c['equips']),
                'money'       => $c['money'],
                'gold'        => $c['gold'],
            );
        }
        gm_json_ok(array('rows' => $out));
        break;

    case 'cdk.giftDetail':
        $id = (int)(isset($input['id']) ? $input['id'] : 0);
        if ($id <= 0) gm_json_error('缺少ID');
        $g = gm_row("select * from gm_gift where id=$id limit 1");
        if (!$g) gm_json_error('礼包不存在');

        $c = cdk_parse_content($g['content']);

        // 补上名称，方便编辑器显示
        $idxFile = GM_ROOT . '/data/items.min.json';
        $idx = array();
        if (is_file($idxFile)) {
            $arr = json_decode(file_get_contents($idxFile), true);
            if (is_array($arr)) foreach ($arr as $x) $idx[$x['i']] = $x['n'];
        }
        $eqFile = GM_ROOT . '/data/equips.min.json';
        $eqIdx = array();
        if (is_file($eqFile)) {
            $arr2 = json_decode(file_get_contents($eqFile), true);
            if (is_array($arr2)) foreach ($arr2 as $x) $eqIdx[$x['i']] = $x['n'];
        }

        $items = array();
        foreach ($c['items'] as $it) {
            $items[] = array(
                'id'   => $it['id'],
                'name' => isset($idx[$it['id']]) ? $idx[$it['id']] : ('物品#' . $it['id']),
                'num'  => $it['num'],
            );
        }
        $equips = array();
        foreach ($c['equips'] as $eq) {
            $equips[] = array(
                'id'   => $eq['id'],
                'name' => isset($eqIdx[$eq['id']]) ? $eqIdx[$eq['id']] : ('装备#' . $eq['id']),
                'star' => $eq['star'],
            );
        }

        gm_json_ok(array(
            'id'         => (int)$g['id'],
            'name'       => $g['name'],
            'remark'     => $g['remark'],
            'per_player' => (int)$g['per_player'],
            'items'      => $items,
            'equips'     => $equips,
            'money'      => $c['money'],
            'gold'       => $c['gold'],
        ));
        break;

    case 'cdk.giftSave':
        cdk_ensure_tables();
        $id     = (int)(isset($input['id']) ? $input['id'] : 0);
        $name   = trim((string)(isset($input['name']) ? $input['name'] : ''));
        $remark = trim((string)(isset($input['remark']) ? $input['remark'] : ''));
        $per    = (int)(isset($input['per_player']) ? $input['per_player'] : 1);
        $limit  = (int)(isset($input['claim_limit']) ? $input['claim_limit'] : 1);
        $items  = isset($input['items']) ? $input['items'] : '[]';
        $equips = isset($input['equips']) ? $input['equips'] : '[]';
        $money  = (int)(isset($input['money']) ? $input['money'] : 0);
        $gold   = (int)(isset($input['gold']) ? $input['gold'] : 0);

        if ($name === '') gm_json_error('请填写礼包名称');

        $itArr = json_decode($items, true);
        $eqArr = json_decode($equips, true);
        if (!is_array($itArr)) $itArr = array();
        if (!is_array($eqArr)) $eqArr = array();

        $clean = array('items' => array(), 'equips' => array(), 'money' => max(0,$money), 'gold' => max(0,$gold));
        foreach ($itArr as $it) {
            if (isset($it['id'], $it['num']) && (int)$it['id'] > 0 && (int)$it['num'] > 0) {
                $clean['items'][] = array('id' => (int)$it['id'], 'num' => (int)$it['num']);
            }
        }
        foreach ($eqArr as $eq) {
            if (isset($eq['id']) && (int)$eq['id'] > 0) {
                $clean['equips'][] = array(
                    'id'   => (int)$eq['id'],
                    'star' => isset($eq['star']) ? max(0, min(15, (int)$eq['star'])) : 0
                );
            }
        }

        if (empty($clean['items']) && empty($clean['equips']) && $clean['money'] <= 0 && $clean['gold'] <= 0) {
            gm_json_error('礼包内容不能为空');
        }

        $json = gm_esc(json_encode($clean, JSON_UNESCAPED_UNICODE));
        $now  = date('Y-m-d H:i:s');
        $who  = gm_esc((string)(isset($_SESSION['gm_name']) ? $_SESSION['gm_name'] : 'admin'));

        if ($id > 0) {
            gm_exec("update gm_gift set name='$name', remark='$remark', content='$json', claim_limit=$limit, per_player=$per where id=$id");
        } else {
            gm_exec("insert into gm_gift (name, remark, content, claim_limit, per_player, status, creator, created_at) values ('$name', '$remark', '$json', $limit, $per, 1, '$who', '$now')");
            $id = (int)gm_val("select max(id) from gm_gift", 0);
        }
        gm_json_ok(array('id' => $id));
        break;

    case 'cdk.giftDelete':
        cdk_ensure_tables();
        $id = (int)(isset($input['id']) ? $input['id'] : 0);
        if ($id <= 0) gm_json_error('缺少ID');
        $used = (int)gm_val("select count(*) from gm_cdk where gift_id=$id", 0);
        if ($used > 0) gm_json_error("该礼包已生成 $used 个兑换码，请先删除兑换码");
        gm_exec("delete from gm_gift where id=$id");
        gm_json_ok(array('deleted' => $id));
        break;

    case 'cdk.giftToggle':
        cdk_ensure_tables();
        $id = (int)(isset($input['id']) ? $input['id'] : 0);
        if ($id <= 0) gm_json_error('缺少ID');
        gm_exec("update gm_gift set status = 1 - status where id=$id");
        $st = (int)gm_val("select status from gm_gift where id=$id", 1);
        gm_json_ok(array('status' => $st));
        break;
    // ---------- 兑换码 ----------
    case 'cdk.generate':
        $giftId = (int)(isset($input['gift_id']) ? $input['gift_id'] : 0);
        $count  = (int)(isset($input['count']) ? $input['count'] : 0);
        $prefix = trim((string)(isset($input['prefix']) ? $input['prefix'] : ''));
        $start  = trim((string)(isset($input['start_at']) ? $input['start_at'] : ''));
        $end    = trim((string)(isset($input['end_at']) ? $input['end_at'] : ''));
        $limit  = (int)(isset($input['limit_total']) ? $input['limit_total'] : 0);
        $len    = (int)(isset($input['len']) ? $input['len'] : 12);

        if ($giftId <= 0) gm_json_error('请选择礼包');
        if (!gm_row("select id from gm_gift where id=$giftId")) gm_json_error('礼包不存在');
        if ($count < 1 || $count > 5000) gm_json_error('生成数量需在 1-5000');
        if ($len < 8 || $len > 24) $len = 12;

        $re = '/^[0-9]{4}-[0-9]{2}-[0-9]{2}( [0-9]{2}:[0-9]{2}(:[0-9]{2})?)?$/';
        if ($start !== '' && !preg_match($re, $start)) gm_json_error('开始时间格式不对');
        if ($end !== '' && !preg_match($re, $end)) gm_json_error('结束时间格式不对');
        if ($start !== '' && strlen($start) === 10) $start .= ' 00:00:00';
        if ($end !== '' && strlen($end) === 10) $end .= ' 23:59:59';
        if ($start !== '' && $end !== '' && $end <= $start) gm_json_error('结束时间必须晚于开始时间');

        $batch = date('YmdHis') . substr(mt_rand(100, 999), 0, 3);
        $now   = date('Y-m-d H:i:s');
        $codes = array();
        $tries = 0;

        while (count($codes) < $count && $tries < $count * 20) {
            $tries++;
            $full = cdk_format(cdk_generate($len), $prefix, 4);
            if (isset($codes[$full])) continue;
            $norm = cdk_normalize($full);
            if (gm_val("select id from gm_cdk where code='$norm' limit 1", null) !== null) continue;
            $codes[$full] = $norm;
        }

        if (empty($codes)) gm_json_error('生成失败，请重试');

        $sSql = ($start === '') ? 'null' : "'$start'";
        $eSql = ($end === '') ? 'null' : "'$end'";
        $ins = 0;
        foreach ($codes as $display => $norm) {
            $ok = gm_exec("insert into gm_cdk (code, gift_id, batch, start_at, end_at, limit_total, used, status, created_at) values ('$norm', $giftId, '$batch', $sSql, $eSql, $limit, 0, 1, '$now')");
            if ($ok !== false) $ins++;
        }

        gm_json_ok(array(
            'batch' => $batch,
            'count' => $ins,
            'codes' => array_keys($codes),
            'gift'  => gm_val("select name from gm_gift where id=$giftId", ''),
        ));
        break;
    case 'cdk.list':
        $giftId = (int)(isset($input['gift_id']) ? $input['gift_id'] : 0);
        $batch  = trim((string)(isset($input['batch']) ? $input['batch'] : ''));
        $kw     = trim((string)(isset($input['q']) ? $input['q'] : ''));
        $page   = max(1, (int)(isset($input['page']) ? $input['page'] : 1));
        $size   = 100;

        $w = array('1=1');
        if ($giftId > 0) $w[] = "c.gift_id=$giftId";
        if ($batch !== '') $w[] = "c.batch=" . gm_esc($batch) . "";
        if ($kw !== '') $w[] = "c.code like '%" . gm_esc(cdk_normalize($kw)) . "%'";
        $where = implode(' and ', $w);

        $total = (int)gm_val("select count(*) from gm_cdk c where $where", 0);
        $off   = ($page - 1) * $size;
        $rows  = gm_rows("select c.id, c.code, c.gift_id, c.batch, c.start_at, c.end_at, c.limit_total, c.used, c.status, g.name as gift_name from gm_cdk c left join gm_gift g on g.id = c.gift_id where $where order by c.id desc limit $off, $size");

        $out = array();
        foreach ($rows as $r) {
            $out[] = array(
                'id'          => (int)$r['id'],
                'code'        => cdk_format($r['code'], '', 4),
                'gift_id'     => (int)$r['gift_id'],
                'gift_name'   => $r['gift_name'],
                'batch'       => $r['batch'],
                'start_at'    => $r['start_at'],
                'end_at'      => $r['end_at'],
                'limit_total' => (int)$r['limit_total'],
                'used'        => (int)$r['used'],
                'status'      => (int)$r['status'],
            );
        }
        gm_json_ok(array('rows' => $out, 'total' => $total, 'page' => $page));
        break;

    case 'cdk.toggle':
        $id = (int)(isset($input['id']) ? $input['id'] : 0);
        if ($id <= 0) gm_json_error('缺少ID');
        gm_exec("update gm_cdk set status = 1 - status where id=$id");
        gm_json_ok(array('status' => (int)gm_val("select status from gm_cdk where id=$id", 1)));
        break;

    case 'cdk.delete':
        $id = (int)(isset($input['id']) ? $input['id'] : 0);
        if ($id <= 0) gm_json_error('缺少ID');
        $used = (int)gm_val("select used from gm_cdk where id=$id", 0);
        gm_exec("delete from gm_cdk where id=$id");
        gm_json_ok(array('deleted' => $id, 'wasUsed' => $used));
        break;

    case 'cdk.batchDelete':
        $batch = trim((string)(isset($input['batch']) ? $input['batch'] : ''));
        if ($batch === '') gm_json_error('缺少批次号');
        $n = gm_exec("delete from gm_cdk where batch=" . gm_esc($batch) . "");
        gm_json_ok(array('deleted' => (int)$n, 'batch' => $batch));
        break;
    // ---------- 批次 / 记录 / 统计 ----------
    case 'cdk.batches':
        $rows = gm_rows("select batch, gift_id, count(*) as total, sum(used) as used, min(created_at) as created_at from gm_cdk group by batch, gift_id order by min(id) desc limit 100");
        $out = array();
        foreach ($rows as $r) {
            $out[] = array(
                'batch'      => $r['batch'],
                'gift_id'    => (int)$r['gift_id'],
                'gift_name'  => gm_val("select name from gm_gift where id=" . (int)$r['gift_id'], ''),
                'total'      => (int)$r['total'],
                'used'       => (int)$r['used'],
                'created_at' => $r['created_at'],
            );
        }
        gm_json_ok(array('rows' => $out));
        break;

    case 'cdk.logs':
        $page = max(1, (int)(isset($input['page']) ? $input['page'] : 1));
        $size = 100;
        $off  = ($page - 1) * $size;
        $total = (int)gm_val("select count(*) from gm_cdk_log", 0);
        $rows = gm_rows("select id, code, gift_id, wjid, nick, ip, created_at from gm_cdk_log order by id desc limit $off, $size");
        $out = array();
        foreach ($rows as $r) {
            $out[] = array(
                'id'         => (int)$r['id'],
                'code'       => cdk_format($r['code'], '', 4),
                'gift_name'  => gm_val("select name from gm_gift where id=" . (int)$r['gift_id'], ''),
                'wjid'       => (int)$r['wjid'],
                'nick'       => $r['nick'],
                'ip'         => $r['ip'],
                'created_at' => $r['created_at'],
            );
        }
        gm_json_ok(array('rows' => $out, 'total' => $total));
        break;

    case 'cdk.stats':
        gm_json_ok(array(
            'gifts'  => (int)gm_val("select count(*) from gm_gift", 0),
            'codes'  => (int)gm_val("select count(*) from gm_cdk", 0),
            'used'   => (int)gm_val("select ifnull(sum(used),0) from gm_cdk", 0),
            'claims' => (int)gm_val("select count(*) from gm_cdk_log", 0),
        ));
        break;

    default:
        gm_json_error('未知 CDK 操作: ' . $action, 404);
}