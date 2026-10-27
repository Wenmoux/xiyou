<?php
/**
 * 进入游戏（补全原端缺失的一环）
 * ---------------------------------------------------------------
 * 原端的问题：
 *   1. 登录成功页只显示"登录成功"，没有任何通往游戏的入口
 *   2. 登录层写的 user.ini 与游戏层要求的格式不兼容
 *   3. 新玩家缺少角色主表 all_zt 记录
 *   4. 新玩家缺少 28 种玩家分表（hd/zb/wp/...），部分 ini 脚本
 *      直接 select 而不会自动建表，一进游戏就 Fatal error
 * 本页负责把 1-4 全部补齐，然后跳到游戏首页。
 * 放置位置：WWW/play.php
 * ---------------------------------------------------------------
 */

header('Content-Type: text/html; charset=utf-8');

$wjid = isset($_GET['wjid']) ? preg_replace('/[^0-9]/', '', $_GET['wjid']) : '';
$pass = isset($_GET['pass']) ? $_GET['pass'] : '';

if ($wjid === '' || $pass === '') {
    exit('<meta charset="utf-8">缺少参数，请从 <a href="/xxjy/login.php">登录页</a> 重新登录。');
}

$appRoot = __DIR__;
$iniPath = $appRoot . '/fqxy/ache/' . $wjid . '/user.ini';

if (!file_exists($iniPath)) {
    exit('<meta charset="utf-8">未找到该玩家的登录缓存，请 <a href="/xxjy/login.php">重新登录</a>。');
}

require_once $appRoot . '/class/iniclass.php';
$ini = new iniFile($iniPath);
$saved = $ini->getItem('验证信息', '玩家验证');

if ((string)$saved !== (string)$pass) {
    exit('<meta charset="utf-8">登录信息已失效，请 <a href="/xxjy/login.php">重新登录</a>。');
}

require_once $appRoot . '/class/user_ini_compat.php';

// ---------- 连库 ----------
$conn = null;
$cwd = getcwd();
chdir($appRoot . '/fqxy');
include $appRoot . '/fqxy/sql/mysql.php';
chdir($cwd);
if (isset($conn) && $conn) {
    @mysql_select_db('xyy', $conn);
    @mysql_query('set names utf8', $conn);
}

// ---------- 补齐角色主表与分表 ----------
if ($conn) {
    $nick = $ini->getItem('验证信息', '玩家昵称');
    hxxy_ensure_role($conn, $wjid, $nick !== null ? $nick : '');
    hxxy_ensure_player_tables($conn, $wjid, $appRoot . '/class/player_tables.sql');
}

// ---------- 存档格式处理 ----------
// 先补游戏码（幂等，已有则原样返回，不会覆盖进度）
hxxy_ensure_game_code($iniPath, $wjid);

// 仅在格式确实缺少游戏层必需段落时才整体升级；
// 注意：升级会重建文件，因此必须在补码之后执行，
// 且对已有完整存档不触发（避免换掉游戏码导致 sid 失配）。
$rawCheck = @file_get_contents($iniPath);
$needUpgrade = ($rawCheck !== false)
    && (strpos($rawCheck, '[地图坐标]') === false
        || strpos($rawCheck, '[最后页面id]') === false);
if ($needUpgrade) {
    hxxy_upgrade_user_ini($iniPath, $wjid);
    hxxy_ensure_game_code($iniPath, $wjid);   // 升级后确保有码
}

$ini2 = new iniFile($iniPath);
$code = $ini2->getItem('验证信息', '玩家游戏码');
if (!$code) {
    exit('<meta charset="utf-8">初始化游戏存档失败，请 <a href="/xxjy/login.php">重新登录</a> 或联系管理员。');
}

$target = '/fqxy/xy.php?uid=' . urlencode($wjid) . '&sid=' . urlencode($code) . '&cmd=1';

echo '<meta charset="utf-8"><title>正在进入游戏</title>'
   . '<body style="font-family:system-ui,sans-serif;background:#141414;color:#eee;text-align:center;padding-top:70px">'
   . '<p style="font-size:18px">正在进入游戏…</p>'
   . '<p style="font-size:13px;color:#888">如未自动跳转，请点击 <a style="color:#6cf" href="'
   . htmlspecialchars($target) . '">这里</a></p>'
   . '<script>location.replace(' . json_encode($target) . ');</script>';
