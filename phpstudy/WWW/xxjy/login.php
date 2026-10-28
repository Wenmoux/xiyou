<?
header("Content-type: text/html; charset=utf-8");
?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#0a0806">
<title>35博客 · 通行证</title>
<link rel="icon" href="../img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="../css/touchScreen/xy-gate.css">
</head>
<body class="gate">
<?php

$user=0;
error_reporting(E_ALL & ~E_NOTICE); 
if(isset($_POST['submit'])) {
$username= $_POST['username'];

//连接数据库
include("../sql/mysql.php");//调用数据库连接

mysql_query("set names utf8");
$sql=mysql_query("select uid,password,name from o_user_list where username='$username'",$conn);
$info1=@mysql_fetch_array($sql);
$pass1=$info1[password];
$uid=$info1[uid];
$pass=md5($_POST['password'].'ALL_PS');
$name=$info1[name];
//$ps = $us ? md5($_POST['password'].'ALL_PS' ) == $row['password'] : 'FALSE';



if($pass!=""||$pass1!=""){

}else{
$pass=1;
}

if($pass==$pass1){


//玩家ini
$wjid=$uid+10000000;






	//写入本地ini缓存
include("../class/iniclass.php");//调用iniclass文件	
		
//调用user.ini是否存在
include("../ini/user1_ini.php");		







//成功登录游戏
//拼接网址


include("../url/url.php");

$xyurl="http://".$xxjyurl."/xxjy/xxjyindex.php?wjid=$wjid&&pass=$pass1";



echo "<META HTTP-EQUIV=REFRESH CONTENT='0;URL=$xyurl'>";



}else{

$user=1;


}

}

if($user==1){

$zcxx="<font color=red>用户名或密码错误</font>"."<br>";
}else{

}

?>


<div class="gate__glow" aria-hidden="true"></div>
<div class="gate__grain" aria-hidden="true"></div>

<main class="gate__main">

  <header class="gate__brand">
    <div class="gate__seal" aria-hidden="true">
      <svg viewBox="0 0 64 64" fill="none">
        <circle cx="32" cy="32" r="27" stroke="currentColor" stroke-width="1.1" opacity=".35"/>
        <circle cx="32" cy="32" r="18" stroke="currentColor" stroke-width=".9" opacity=".55"/>
        <path d="M32 6v9M32 49v9M6 32h9M49 32h9" stroke="currentColor" stroke-width="1.4" stroke-linecap="round"/>
        <circle cx="32" cy="32" r="4.5" fill="currentColor"/>
      </svg>
    </div>
    <h1 class="gate__title">幻想西游</h1>
    <p class="gate__sub">35博客一站式通行证</p>
  </header>

  <section class="gate__card">
    <div class="gate__hint">
      <span class="gate__rule"></span>
      <span>请输入你的账号和密码</span>
      <span class="gate__rule"></span>
    </div>

    <form class="gate__form" action="login.php" method="POST" autocomplete="off">

      <label class="field">
        <span class="field__label">账号</span>
        <input class="field__input" type="text" name="username"
               placeholder="请输入你的账号" required autocomplete="username">
        <span class="field__line" aria-hidden="true"></span>
      </label>

      <label class="field">
        <span class="field__label">密码</span>
        <input class="field__input" type="password" name="password"
               placeholder="请输入你的密码" required autocomplete="current-password">
        <span class="field__line" aria-hidden="true"></span>
      </label>

      <button class="gate__btn" type="submit" name="submit" value="登录">
        <span>登 录</span>
      </button>

      <p class="gate__msg" role="alert"><?echo $zcxx;?></p>
    </form>

    <nav class="gate__nav">
      <a href="regist.php">注册通行证</a>
      <span class="gate__dot">·</span>
      <a href="../index.php">返回官网</a>
    </nav>
  </section>

  <footer class="gate__foot">
    <span>官方群 54665469</span>
    <span class="gate__dot">·</span>
    <span>服务时间 09:30 - 21:00</span>
  </footer>

</main>

<script>
/* 输入聚焦时点亮对应的下划线 */
(function () {
  document.querySelectorAll('.field__input').forEach(function (inp) {
    inp.addEventListener('focus', function () {
      inp.parentNode.classList.add('is-focus');
    });
    inp.addEventListener('blur', function () {
      inp.parentNode.classList.remove('is-focus');
    });
  });
})();
</script>

</body>
</html>
