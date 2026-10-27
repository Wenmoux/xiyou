<?php
/* ==================================================================
 * 家园总站验证（单机 / 多区两种模式）
 * ------------------------------------------------------------------
 * 原端设计：
 *   游戏入口把 (uid|pass|游戏地址|区) POST 给“家园总站”，
 *   总站校验后再回调 fqxy/sql/yxCurl.php 通知结果。
 *
 * 独立部署的问题：
 *   config.php 的 host 指向本机时，这条请求变成“自己请求自己”，
 *   Apache 的 worker 在等自己返回，请求挂到超时才释放，
 *   前端表现为 502 Bad Gateway。
 *
 * 本版处理：
 *   默认单机模式——不做跨站请求，本地比对口令后直接进游戏。
 *   确有多区总站互联时，放一个 config/remote_auth.flag 即可恢复原逻辑。
 * ================================================================== */

ini_set("error_reporting", "E_ALL & ~E_NOTICE");
date_default_timezone_set("PRC");

include("./url/url.php");   // 取 $xxjyurl（家园地址）与 $url（本游戏地址）

$remoteAuthFlag = dirname(dirname(__DIR__)) . '/config/remote_auth.flag';
$isSingleMode   = !file_exists($remoteAuthFlag);

if ($isSingleMode) {

    // ---------------- 单机模式：本地校验后直接进游戏 ----------------
    $ok = false;

    if ($wjid !== '' && $password !== '' && (int)$wjid > 10000000) {
        include("../class/iniclass.php");        // ini 操作类
        include("../ini/user_ini.php");          // 载入 ache/<wjid>/user.ini

        $savedPass = isset($hf) && $hf == 2 ? $iniFile->getItem('验证信息', '玩家验证') : '';
        if ($savedPass !== '' && $savedPass !== null && $savedPass == $password) {
            $ok = true;
        }
    }

    if ($ok) {
        $gameCode = $iniFile->getItem('验证信息', '玩家游戏码');
        $gameCmd  = $iniFile->getItem('验证信息', 'cmid值');
        if ($gameCmd === null || $gameCmd === '') {
            $gameCmd = 1;
        }

        $target = '/fqxy/xy.php?uid=' . urlencode($wjid)
                . '&sid=' . urlencode($gameCode)
                . '&cmd=' . urlencode($gameCmd);

        echo '<meta charset="utf-8"><title>进入游戏</title>';
        echo '<div style="font-family:system-ui,sans-serif;text-align:center;'
           . 'padding-top:70px;color:#eee;background:#141414;min-height:100vh">';
        echo '<p style="font-size:18px">正在进入游戏…</p>';
        echo '<p style="font-size:13px;color:#888">如未跳转请点 '
           . '<a style="color:#6cf" href="' . htmlspecialchars($target) . '">这里</a></p>';
        echo '<script>location.replace(' . json_encode($target) . ');</script>';
        echo '</div>';
    } else {
        echo '<meta charset="utf-8">';
        echo '<p style="text-align:center;padding-top:60px;font-family:sans-serif">'
           . '登录信息已失效，请从 <a href="/xxjy/login.php">登录页</a> 重新进入。</p>';
    }

} else {

    // ---------------- 多区模式：原逻辑，向外部总站验证 ----------------
    $post_data = $wjid . '|' . $password . '|' . $url . '|' . $qy;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'http://' . $xxjyurl . '/sql/xxjyCurl.php');
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
    // 兜底超时：总站不可达时不能让本机 worker 挂死
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 3);
    curl_setopt($ch, CURLOPT_TIMEOUT, 5);
    $response = curl_exec($ch);
    curl_close($ch);
}
?>
