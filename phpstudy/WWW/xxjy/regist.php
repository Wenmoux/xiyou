<?
header("Content-type: text/html; charset=utf-8");

?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="format-detection" content="telephone=no">
<title>35博客游戏社区-注册</title>
<link rel="icon" href="../img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="../css/touchScreen/xy-gate.css">
</head>
<body>

<?php



ini_set("date.timezone","PRC");//时间效准代码
error_reporting(E_ALL & ~E_NOTICE); 
if($_POST['submit']){

	
	
//内测完后删除	
//$zczh5= $_POST['zc5'];

//if($zczh5!=""){
//内测完后删除		

$zczh1= $_POST['zc1'];	
	
if($zczh1!=""){
$zczh2= $_POST['zc2'];	
if($zczh2!=""){
$zczh3= $_POST['zc3'];	
if($zczh3!=""){

$zczh4= '12345678';
if($zczh4!=""){
$zczh6= $_POST['zc6'];	
if($zczh6!=""){
if(preg_match('/^[\w-\.]{6,12}$/', $zczh1)){	
if(preg_match('/^[\w-\.]{6,12}$/', $zczh2)){		
if(preg_match('/^[\w-\.]{6,12}$/', $zczh3)){	

if(preg_match('/^[\w-\.]{6,12}$/', $zczh4)){	
if(strlen($zczh6) <= 16){  

//连接数据库
include("../sql/mysql.php");//调用数据库连接

//$q2="zem";
//mysql_query("set names utf8");
//$sql1=mysql_query("select * from $q2 where zem='$zczh5'",$conn);
//$info1=@mysql_fetch_array($sql1);
//$zcm=$info1[zem];
//$sy=$info1[sy];


//if($zczh5==$zcm){
//if($sy==1){

//查询账号是否已占有
$q2="o_user_list";
$sql1=mysql_query("select uid from $q2 where username='$zczh1'",$conn);
$info1=@mysql_fetch_array($sql1);
$zczhpd=$info1[uid];


if($zczhpd==""){
$q2="o_user_list";
$sql1=mysql_query("select name from $q2 where name='$zczh6'",$conn);
$info1=@mysql_fetch_array($sql1);
$zczhpd1=$info1[name];
if($zczhpd1!=$zczh6){
ini_set("error_reporting","E_ALL & ~E_NOTICE");//防止报错代码	
//获取最大值
$q2="o_user_list";
$sql1=mysql_query("select MAX(uid) from $q2");
$abc=mysql_fetch_array($sql1);
$maxid=$abc[0];


if($maxid ==""){
$maxid=0;
$maxidd=$maxid+1;
} else{
$maxidd=$maxid+1;
}


$ma=md5($zczh2.ALL_PS);;
$aqm=md5($zczh4.ALL_PS);
$zczh2=md5($zczh2.ALL_PS);
$y= date('Y')*1;
$m= date('m')*1;
$d= date('d')*1;
$h= date('H')*1;
$i= date('i')*1;
$s= date('s')*1;

$q2="o_user_list";
mysql_query("set names utf8");
$sql = "insert into $q2 (uid,m_id,name,username,password,n,y,r,s,f,m,ma,aqm)  values('$maxidd','0','$zczh6','$zczh1','$zczh2','$y','$m','$d','$h','$i','$s','$ma','$aqm')";
 if (!mysql_query($sql,$conn))
 {
   die('Error: ' . mysql_error());
 }


 
 
 
 
 $mysql002=$maxidd+10000000;


//加入ini


	//路径
$path='../ache/'.$mysql002;
$dir = iconv("UTF-8", "GBK", "$path");
        if (!file_exists($dir)){
            mkdir ($dir,0777,true);
        } else {
        }

//$q2="zem";
//mysql_query("set names utf8");
//$strsql = "update $q2 set sy=2 where zem='$zczh5'";//物品id号必改值
//$result = mysql_query($strsql);

include("../url/url.php");

$xyurl="http://".$xxjyurl."/xxjy/xxjyzc.php?zh=$zczh1&&mm=$zczh3&&aqm=$zczh4";



echo "<META HTTP-EQUIV=REFRESH CONTENT='0;URL=$xyurl'>";


}else{

$zcxx="<font color=red>对不起！这个昵称太火了换一个吧</font>";
}
}else{

$zcxx="<font color=red>对不起该账号已存在了</font>";
}

//}else{
//echo "<font color=red>对不起!该注册码已被使用过了</font>"."<br>";
//
//}
//}else{
//echo "<font color=red>对不起!你的注册码不正确</font>"."<br>";
//
//}

}else{

$zcxx="<font color=red>昵称超过了最大限制</font>";
}
}else{

$zcxx="<font color=red>安全码只能为6-12位字母或数字</font>";
}

}else{

$zcxx="<font color=red>密码只能为6-12位字母或数字</font>";
}

}else{

$zcxx="<font color=red>密码只能为6-12位字母或数字</font>";
}


}else{

$zcxx="<font color=red>账号只能为6-12位字母或数字</font>";
}


}else{

$zcxx="<font color=red>昵称不能为空</font>";
}

}else{

$zcxx="<font color=red>安全码不能为空</font>";
}


}else{
$zcxx="<font color=red>密码不能为空</font>";
}

}else{

$zcxx="<font color=red>密码不能为空</font>";
}
}else{

$zcxx="<font color=red>账号不能为空</font>";
}




//内测完后删除	
//}else{
//
//$zcxx="<font color=red>对不起!注册码不能为空</font>";
//}


}else{


}

?>

<div class="wrap">

  <div class="topbar">
    <img class="logo" src="../images/logo1.jpg" alt="35博客">
  </div>

  <div class="box">

    <div class="box-hd">
      <span class="tt"><?echo $zcxx;?>35博客一站式通行证注册</span>
    </div>

    <div class="box-bd">

      <form action="<?echo "regist.php";?>" method="post">

        <div class="row">
          <label class="lb">昵称：</label>
          <input class="inp" type="text" name="zc6" placeholder="请输入昵称">
        </div>
        <span class="tip"><font color=red>（4个字符以下）</font></span>

        <div class="row">
          <label class="lb">账号：</label>
          <input class="inp" type="text" name="zc1" placeholder="请输入账号" autocomplete="username">
        </div>
        <span class="tip"><font color=red>（6-12位的字母或数字）</font></span>

        <div class="row">
          <label class="lb">密码：</label>
          <input class="inp" type="password" name="zc2" placeholder="请输入密码" autocomplete="new-password">
        </div>
        <span class="tip"><font color=red>（6-12位的字母或数字）</font></span>

        <div class="row">
          <label class="lb">确认密码：</label>
          <input class="inp" type="password" name="zc3" placeholder="请再输入一次" autocomplete="new-password">
        </div>
        <span class="tip"><font color=red>（6-12位的字母或数字）</font></span>

        <div class="row row-btn">
          <input class="btn" type="submit" name="submit" value="注 册">
        </div>
      </form>

      <div class="links">
        <a href="login.php">返回登录</a>
        <span class="sep">|</span>
        <a href="../index.php">返回官网</a>
      </div>

    </div>
  </div>

  <div class="foot">
    <p>官方群 54665469 · 服务时间 09:30-21:00</p>
  </div>

</div>


</body>
</html>
