<?php
/**
 * 跨层登录态兼容补丁
 * ---------------------------------------------------------------
 * 问题：原端有两套 user.ini 格式，互不兼容——
 *   登录层 WWW/ini/user1_ini.php 写入：
 *       [35博客家园玩家信息]
 *       [验证信息]
 *       玩家id / 玩家验证 / 玩家昵称
 *   游戏层 fqxy/xy.php 要求：
 *       [<玩家ID>]                      ← 段头必须是玩家 ID
 *       验证信息: 玩家游戏码 / cmid值 / xcmid值 / dcmid值 / 年..秒
 *       地图坐标: x / y
 *       最后页面id: 页面id / npcid
 *       超链接值
 *   游戏层校验 sid == 玩家游戏码（xy.php 第 249 行），
 *   登录层从不生成该字段，因此登录后进游戏必然提示"验证失效"。
 *
 * 做法：登录成功后，若游戏层格式不完整，则就地升级为游戏层格式，
 *      保留原口令（玩家验证）与昵称，随机生成 30 位玩家游戏码。
 * ---------------------------------------------------------------
 */

function hxxy_upgrade_user_ini($file, $wjid)
{
    if (!file_exists($file)) return false;

    $raw = @file_get_contents($file);
    if ($raw === false) return false;

    // 已经是游戏层格式（含玩家游戏码且有完整坐标段）→ 不动
    if (strpos($raw, '玩家游戏码') !== false && strpos($raw, '[地图坐标]') !== false) {
        return false;
    }

    $ini = @parse_ini_file($file, true, true);
    if (!is_array($ini)) $ini = array();

    $ver = isset($ini['验证信息']) && is_array($ini['验证信息']) ? $ini['验证信息'] : array();

    $keepVerify = isset($ver['玩家验证']) && $ver['玩家验证'] !== '' ? $ver['玩家验证'] : $wjid;

    // 30 位游戏码
    $chars = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $code = '';
    for ($i = 0; $i < 30; $i++) {
        $code .= $chars[mt_rand(0, strlen($chars) - 1)];
    }

    $out  = '[' . $wjid . ']' . "\r\n";
    $out .= '[验证信息]' . "\r\n";
    $out .= '玩家id = ' . $wjid . "\r\n";
    $out .= '玩家验证 = ' . $keepVerify . "\r\n";
    $out .= '玩家游戏码 = ' . $code . "\r\n";
    $out .= 'cmid值 = 0' . "\r\n";
    $out .= 'xcmid值 = 1' . "\r\n";
    $out .= 'dcmid值 = 1' . "\r\n";
    $out .= '年 = ' . date('Y') . "\r\n";
    $out .= '月 = ' . date('m') . "\r\n";
    $out .= '日 = ' . date('d') . "\r\n";
    $out .= '时 = ' . date('H') . "\r\n";
    $out .= '分 = ' . date('i') . "\r\n";
    $out .= '秒 = ' . date('s') . "\r\n";
    $out .= '[地图坐标]' . "\r\n";
    $out .= 'x = 1' . "\r\n";
    $out .= 'y = 1' . "\r\n";
    $out .= '[最后页面id]' . "\r\n";
    $out .= '页面id = 0' . "\r\n";
    $out .= 'npcid = 0' . "\r\n";
    $out .= '[超链接值]' . "\r\n";
    $out .= '初始 = 123' . "\r\n";

    return @file_put_contents($file, $out) !== false;
}

/**
 * 确保角色主表有记录（新注册玩家没有 all_zt 行，游戏取不到属性会崩）
 */
function hxxy_ensure_role($conn, $wjid, $name)
{
    if (!$conn) return false;
    $wjid = (int)$wjid;
    $r = @mysql_query("select wjid from all_zt where wjid=$wjid", $conn);
    if ($r && @mysql_num_rows($r) > 0) return false;

    $nm = mysql_real_escape_string($name !== '' ? $name : ('玩家' . $wjid), $conn);
    $sql = "insert into all_zt
            (wjid,username,sex,tx,peiou,peiouid,zzmz,zzid,zzfl,dj,mpp,bpmz,bpid,vip,vipjy,gsrl,bbrl,ckrl,emz,lh)
            values ($wjid,'$nm',1,'','',0,'',0,0,1,2,'',0,0,0,500,1000,2000,0,0)";
    return @mysql_query($sql, $conn) ? true : false;
}

/**
 * 为新玩家建立 28 种分表
 * ---------------------------------------------------------------
 * 原端多数 *_ini.php 会先 SHOW TABLES 再建表，但 hd_ini.php 等直接 select，
 * 新玩家一进游戏就报 "Table 'xyy.hd<wjid>' doesn't exist"。
 * 这里用原端老玩家的表结构作模板，一次性补齐，避免逐个修补脚本。
 * ---------------------------------------------------------------
 */
function hxxy_ensure_player_tables($conn, $wjid, $templateFile)
{
    if (!$conn || !file_exists($templateFile)) return false;
    $wjid = (int)$wjid;

    $sqlText = file_get_contents($templateFile);
    if ($sqlText === false) return false;

    // 拆分成单条 CREATE TABLE
    $chunks = preg_split('/;\s*[\r\n]+/', $sqlText);
    $created = 0;

    foreach ($chunks as $chunk) {
        $chunk = trim($chunk);
        if ($chunk === '' || strpos($chunk, 'CREATE TABLE') === false) continue;

        // 去掉注释行
        $lines = array();
        foreach (preg_split('/\r?\n/', $chunk) as $ln) {
            if (substr(ltrim($ln), 0, 2) === '--') continue;
            $lines[] = $ln;
        }
        $stmt = trim(implode("\n", $lines));
        if ($stmt === '' || stripos($stmt, 'CREATE TABLE') === false) continue;

        // 表名占位符替换
        preg_match('/CREATE TABLE\s+`([a-z]+)\{\{WJID\}\}`/i', $stmt, $m);
        if (!$m) continue;
        $tableName = $m[1] . $wjid;

        // 已存在则跳过
        $chk = @mysql_query("SHOW TABLES LIKE '" . mysql_real_escape_string($tableName, $conn) . "'", $conn);
        if ($chk && @mysql_num_rows($chk) > 0) continue;

        $sql = str_replace('{{WJID}}', $wjid, $stmt);
        if (@mysql_query($sql, $conn)) $created++;
    }
    return $created;
}

/**
 * 就地补全缺失的玩家游戏码
 * ---------------------------------------------------------------
 * 场景：存档由旧版本生成，缺少「玩家游戏码」字段。
 *       游戏入口校验 sid == 玩家游戏码，缺失时整条链路判定失效，
 *       表现为「当前验证信息失效」或创建角色后跳转中断。
 *
 * 处理：保留原有全部字段（cmid值 / 地图坐标 / 超链接表等进度），
 *       仅补上缺失的游戏码，不重建文件。
 * ---------------------------------------------------------------
 */
function hxxy_ensure_game_code($file, $wjid)
{
    if (!file_exists($file)) {
        return '';
    }

    $raw = file_get_contents($file);
    if ($raw === false) {
        return '';
    }

    // 已有游戏码则直接返回
    if (preg_match('/^玩家游戏码\s*=\s*(\S+)/m', $raw, $m)) {
        return trim($m[1]);
    }

    // 生成 30 位游戏码
    $chars = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $code = '';
    for ($i = 0; $i < 30; $i++) {
        $code .= $chars[mt_rand(0, strlen($chars) - 1)];
    }

    $nl = strpos($raw, "\r\n") !== false ? "\r\n" : "\n";

    if (preg_match('/\[验证信息\]/', $raw)) {
        // 插到 [验证信息] 段头之后
        $raw = preg_replace(
            '/(\[验证信息\]\r?\n)/',
            '$1' . '玩家游戏码 = ' . $code . $nl,
            $raw,
            1
        );
    } else {
        // 没有该段则整段补在最前面
        $raw = '[' . $wjid . ']' . $nl
             . '[验证信息]' . $nl
             . '玩家游戏码 = ' . $code . $nl
             . $raw;
    }

    file_put_contents($file, $raw);
    return $code;
}
