<?php
/**
 * CDK 兑换页 —— 玩家用
 * 入口：/cdk/?wjid=10000001&pass=xxxx
 */

header("Content-type: text/html; charset=utf-8");

$root = dirname(__DIR__);
require_once $root . "/gm/lib/db.php";
require_once $root . "/gm/lib/cdk.php";

gm_use_game();

$wjid = isset($_GET["wjid"]) ? (int)$_GET["wjid"] : 0;
$pass = isset($_GET["pass"]) ? trim((string)$_GET["pass"]) : "";

// ---- 身份校验：与游戏同一套（玩家游戏码） ----
$nick = "";
$authErr = "";

if ($wjid <= 0) {
    $authErr = "缺少角色信息，请从游戏内进入";
} else {
    $ini = $root . "/fqxy/ache/" . $wjid . "/user.ini";
    if (!is_file($ini)) {
        $ini = $root . "/ache/" . $wjid . "/user.ini";
    }

    if (!is_file($ini)) {
        $authErr = "找不到角色存档";
    } else {
        $txt = file_get_contents($ini);
        $expect = "";
        if (preg_match("/玩家游戏码[ \t]*=[ \t]*([A-Za-z0-9]+)/u", $txt, $m)) {
            $expect = $m[1];
        }
        if (preg_match("/昵称[ \t]*=[ \t]*([^\r\n]+)/u", $txt, $m2)) {
            $nick = trim($m2[1]);
        }
        if ($expect === "" || $pass === "" || $pass !== $expect) {
            $authErr = "身份校验失败，请重新登录游戏";
        }
    }
}

// ---- 处理兑换 ----
$msg = "";
$msgType = "";
$detail = array();

if ($authErr === "" && isset($_POST["code"])) {
    $code = trim((string)$_POST["code"]);
    $ip   = isset($_SERVER["REMOTE_ADDR"]) ? $_SERVER["REMOTE_ADDR"] : "";
    $r = cdk_redeem($code, $wjid, $nick, $ip);
    if ($r["ok"]) {
        $msgType = "ok";
        $msg = "兑换成功：" . $r["gift"];
        $detail = $r["content"];
    } else {
        $msgType = "err";
        $msg = $r["error"];
    }
}
?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="format-detection" content="telephone=no">
<title>兑换礼包 - 35博客游戏社区</title>
<link rel="icon" href="../img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="../css/touchScreen/xy-gate.css">
</head>
<body>

<div class="wrap">

<div class="topbar">
  <img class="logo" src="../images/logo1.jpg" alt="35博客">
</div>

<div class="box">

  <div class="box-hd">
    <span class="tt">兑换礼包</span>
  </div>

  <div class="box-bd">

<?php if ($authErr !== ""): ?>

    <div class="notice notice--err">
      <?php echo htmlspecialchars($authErr); ?>
    </div>
    <div class="links">
      <a href="../xxjy/login.php">重新登录</a>
      <span class="sep">|</span>
      <a href="../index.php">返回官网</a>
    </div>

<?php else: ?>

    <div class="who">
      <span class="who__lb">当前角色</span>
      <span class="who__nick"><?php echo htmlspecialchars($nick !== "" ? $nick : ("玩家 " . $wjid)); ?></span>
      <span class="who__id">#<?php echo $wjid; ?></span>
    </div>

    <form method="post" action="index.php?wjid=<?php echo $wjid; ?>&pass=<?php echo urlencode($pass); ?>">
      <div class="row">
        <label class="lb">兑换码：</label>
        <input class="inp" type="text" name="code"
               placeholder="请输入兑换码" autocomplete="off"
               value="<?php echo isset($_POST["code"]) ? htmlspecialchars($_POST["code"]) : ""; ?>"
               maxlength="40" required>
      </div>

      <div class="row row-btn">
        <input class="btn" type="submit" value="立 即 兑 换">
      </div>
    </form>
<?php if ($msg !== ""): ?>
    <div class="notice notice--<?php echo $msgType; ?>">
      <?php echo htmlspecialchars($msg); ?>
    </div>

    <?php if (!empty($detail)): ?>
      <div class="bag">
        <div class="bag__hd">礼包内容</div>
        <ul class="bag__list">
          <?php foreach ($detail["items"] as $it): ?>
            <li><span class="bag__n">物品 #<?php echo (int)$it["id"]; ?></span>
                <span class="bag__v">x<?php echo (int)$it["num"]; ?></span></li>
          <?php endforeach; ?>
          <?php foreach ($detail["equips"] as $eq): ?>
            <li><span class="bag__n">装备 #<?php echo (int)$eq["id"]; ?></span>
                <span class="bag__v"><?php echo (int)$eq["star"]; ?>星</span></li>
          <?php endforeach; ?>
          <?php if ($detail["money"] > 0): ?>
            <li><span class="bag__n">银两</span>
                <span class="bag__v"><?php echo number_format($detail["money"]); ?></span></li>
          <?php endif; ?>
          <?php if ($detail["gold"] > 0): ?>
            <li><span class="bag__n">元宝</span>
                <span class="bag__v"><?php echo number_format($detail["gold"]); ?></span></li>
          <?php endif; ?>
        </ul>
        <p class="bag__tip">物品已放入增值仓库，装备已进入背包</p>
      </div>
    <?php endif; ?>
<?php endif; ?>

<?php endif; ?>

    <div class="links">
      <a href="../fqxy/xyy.php?wjid=<?php echo $wjid; ?>&pass=<?php echo urlencode($pass); ?>&qy=1">返回游戏</a>
      <span class="sep">|</span>
      <a href="../xxjy/login.php">切换账号</a>
    </div>

  </div>
</div>

<div class="foot">
  <p>官方群 54665469 · 服务时间 09:30-21:00</p>
</div>

</div>

</body>
</html>