<?php
/**
 * GM 控制台 - 数据访问层
 * ------------------------------------------------------------
 * 复用游戏自身的数据库配置（config + sql/mysql.php 已被 entrypoint 注入），
 * 因此不需要在 GM 里再写一份连接参数。
 *
 * 约定：
 *   账号表 xxjyuser.o_user_list   uid → 玩家ID = uid + 10000000
 *   角色表 xyy.all_zt             wjid, username, dj(等级), vip, sex ...
 *   货币表 xyy.all_money          wjid, wjmz, money
 *   状态表 xyy.all_user           wjid, fl(1=禁言/封禁标记), yj(原因)
 */

if (!defined('GM_ROOT')) {
    define('GM_ROOT', dirname(__DIR__));
}

/** 全局连接（单例） */
function gm_db()
{
    static $conn = null;
    if ($conn !== null) {
        return $conn;
    }

    $cfgRoot = dirname(GM_ROOT);           // WWW 根
    $appFqxy = $cfgRoot . '/fqxy';

    // 复用游戏连接参数（entrypoint 已把 host/user/pass 注入）
    $host = '127.0.0.1';
    $user = 'root';
    $pass = '';

    $cfgFile = $appFqxy . '/sql/mysql.php';
    if (is_file($cfgFile)) {
        $src = file_get_contents($cfgFile);
        if (preg_match('/\$mysqla1\s*=\s*[\'"]([^\'"]*)[\'"]/', $src, $m)) $host = $m[1];
        if (preg_match('/\$mysqla2\s*=\s*[\'"]([^\'"]*)[\'"]/', $src, $m)) $user = $m[1];
        if (preg_match('/\$mysqla3\s*=\s*[\'"]([^\'"]*)[\'"]/', $src, $m)) $pass = $m[1];
    }

    $conn = @mysql_connect($host, $user, $pass);
    if (!$conn) {
        gm_json_error('数据库连接失败', 500);
    }
    @mysql_query('set names utf8', $conn);
    return $conn;
}

/** 选库 */
function gm_use_game()
{
    @mysql_select_db('xyy', gm_db());
}

function gm_use_account()
{
    @mysql_select_db('xxjyuser', gm_db());
}

/** 安全取值（转义后拼 SQL 用） */
function gm_esc($v)
{
    return mysql_real_escape_string((string)$v, gm_db());
}

/** 查询多行 */
function gm_rows($sql)
{
    $r = @mysql_query($sql, gm_db());
    if (!$r) return array();
    $out = array();
    while ($row = @mysql_fetch_assoc($r)) {
        $out[] = $row;
    }
    return $out;
}

/** 查询单行 */
function gm_row($sql)
{
    $rows = gm_rows($sql);
    return $rows ? $rows[0] : null;
}

/** 查询单值 */
function gm_val($sql, $default = null)
{
    $row = gm_row($sql);
    if (!$row) return $default;
    $vals = array_values($row);
    return $vals[0];
}

/** 执行写操作，返回影响行数 */
function gm_exec($sql)
{
    $ok = @mysql_query($sql, gm_db());
    if (!$ok) {
        return false;
    }
    return @mysql_affected_rows(gm_db());
}

/** 统一 JSON 输出 */
function gm_json($data, $code = 200)
{
    if (!headers_sent()) {
        http_response_code($code);
        header('Content-Type: application/json; charset=utf-8');
        header('Cache-Control: no-store');
    }
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

function gm_json_error($msg, $code = 400)
{
    gm_json(array('ok' => false, 'error' => $msg), $code);
}

function gm_json_ok($data = array())
{
    $data['ok'] = true;
    gm_json($data);
}

/* ============================================================
 * 存档层：玩家真实活跃度与进度
 * ------------------------------------------------------------
 * 原端的 all_ip / all_user 两张表在正常游玩时并不写入，
 * 真正能反映玩家状态的是 fqxy/ache/<wjid>/user.ini 的修改时间
 * 与其中的 cmid值（当前页面）等字段。
 * ============================================================ */

/** 存档根目录 */
function gm_ache_root()
{
    return dirname(GM_ROOT) . '/fqxy/ache';
}

/**
 * 扫描所有玩家存档目录
 * 返回 [wjid => ['mtime'=>时间戳, 'size'=>字节, 'files'=>文件数]]
 */
function gm_ache_scan()
{
    $root = gm_ache_root();
    if (!is_dir($root)) return array();

    $out = array();
    $dh = @opendir($root);
    if (!$dh) return array();

    while (($name = readdir($dh)) !== false) {
        if (!ctype_digit($name)) continue;
        $dir = $root . '/' . $name;
        if (!is_dir($dir)) continue;

        $ini = $dir . '/user.ini';
        $mtime = is_file($ini) ? filemtime($ini) : filemtime($dir);
        $size  = 0;
        $count = 0;

        $files = @scandir($dir);
        if ($files) {
            foreach ($files as $f) {
                if ($f === '.' || $f === '..') continue;
                $p = $dir . '/' . $f;
                if (is_file($p)) {
                    $size += filesize($p);
                    $count++;
                }
            }
        }

        $out[(int)$name] = array(
            'mtime' => (int)$mtime,
            'size'  => (int)$size,
            'files' => (int)$count,
        );
    }
    closedir($dh);
    return $out;
}

/** 读取存档里的单个字段 */
function gm_ache_get($wjid, $key, $default = '')
{
    $ini = gm_ache_root() . '/' . (int)$wjid . '/user.ini';
    if (!is_file($ini)) return $default;
    $s = @file_get_contents($ini);
    if ($s === false) return $default;
    if (preg_match('/^\s*' . preg_quote($key, '/') . '\s*=\s*(.*)$/m', $s, $m)) {
        return trim($m[1]);
    }
    return $default;
}
