<?php
/**
 * GM 控制台 - 认证
 * ------------------------------------------------------------
 * 账号来源：xxjyuser.gmuser（与原 admin/login.php 同一张表）
 * 密码算法：md5(明文 + 'ALL_PS')，兼容原端存量账号
 *
 * 用独立 session，不改动游戏的 ini 登录态，
 * 两边互不干扰：游戏掉线不影响 GM，反之亦然。
 */

require_once __DIR__ . '/db.php';

define('GM_SESSION_KEY', 'gm_console_uid');
define('GM_SESSION_NAME', 'gm_console_name');

function gm_session_start()
{
    if (session_status() === PHP_SESSION_ACTIVE) {
        return;
    }
    session_name('HXXYGM');
    session_set_cookie_params(7200, '/');
    @session_start();
}

/** 校验账号密码 */
function gm_login($username, $password)
{
    $username = trim((string)$username);
    $password = (string)$password;
    if ($username === '' || $password === '') {
        return array('ok' => false, 'error' => '请输入账号和密码');
    }

    gm_use_account();
    $u = gm_esc($username);
    $row = gm_row("select uid,name,username,password from gmuser where username='$u' limit 1");
    if (!$row) {
        return array('ok' => false, 'error' => '账号不存在');
    }

    // 兼容两种存量：md5(pass + ALL_PS) 与明文
    $expect = md5($password . 'ALL_PS');
    $stored = $row['password'];
    $ok = ($stored === $expect) || ($stored === $password) || ($stored === md5($password));
    if (!$ok) {
        return array('ok' => false, 'error' => '密码错误');
    }

    gm_session_start();
    $_SESSION[GM_SESSION_KEY]  = (int)$row['uid'];
    $_SESSION[GM_SESSION_NAME] = $row['name'] !== '' ? $row['name'] : $row['username'];
    @session_regenerate_id(true);

    return array(
        'ok'   => true,
        'name' => $_SESSION[GM_SESSION_NAME],
    );
}

/** 当前登录者，未登录返回 null */
function gm_user()
{
    gm_session_start();
    if (empty($_SESSION[GM_SESSION_KEY])) {
        return null;
    }
    return array(
        'uid'  => (int)$_SESSION[GM_SESSION_KEY],
        'name' => isset($_SESSION[GM_SESSION_NAME]) ? $_SESSION[GM_SESSION_NAME] : 'GM',
    );
}

/** 未登录则中断请求 */
function gm_require_login()
{
    $u = gm_user();
    if (!$u) {
        gm_json(array('ok' => false, 'error' => '未登录', 'needLogin' => true), 401);
    }
    return $u;
}

function gm_logout()
{
    gm_session_start();
    $_SESSION = array();
    @session_destroy();
}
