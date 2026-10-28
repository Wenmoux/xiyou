<?
header("Content-type: text/html; charset=utf-8");

?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="format-detection" content="telephone=no">
<title>35博客游戏社区-登录</title>
<link rel="icon" href="../img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="../css/touchScreen/xy-gate.css">
</head>
<body>

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

<div class="wrap">

  <div class="topbar">
    <img class="logo" src="../images/logo1.jpg" alt="35博客">
  </div>

  <div class="box">

    <div class="box-hd">
      <span class="tt"><?echo $zcxx;?>请输入你的账号和密码</span>
    </div>

    <div class="box-bd">

      <form action="login.php" method="POST">

        <div class="row">
          <label class="lb">账号：</label>
          <input class="inp" type="text" name="username" placeholder="请输入你的账号" autocomplete="username">
        </div>

        <div class="row">
          <label class="lb">密码：</label>
          <input class="inp" type="password" name="password" placeholder="请输入你的密码" autocomplete="current-password">
        </div>

        <div class="row row-btn">
          <input class="btn" type="submit" name="submit" value="登 录">
        </div>
      </form>

      <div class="links">
        <a href="regist.php">注册账号</a>
        <span class="sep">|</span>
        <a href="xxjyxg.php">修改密码</a>
        <span class="sep">|</span>
        <a href="xxjywj.php">忘记密码</a>
      </div>

    </div>
  </div>

  <div class="foot">
    <p>官方群 54665469 · 服务时间 09:30-21:00</p>
  </div>

</div>


</body>
</html>
