<?
header("Content-type: text/html; charset=utf-8");

?>
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
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#0a0806">
<title>35博客 · 通行证注册</title>
<link rel="icon" href="../img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="../css/touchScreen/xy-gate.css">
</head>
<body class="gate">

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
    <h1 class="gate__title">开 启 西 游</h1>
    <p class="gate__sub">35博客一站式通行证注册</p>
  </header>

  <section class="gate__card">
    <div class="gate__hint">
      <span class="gate__rule"></span>
      <span>填写通行证信息</span>
      <span class="gate__rule"></span>
    </div>

    <form class="gate__form" action="<?echo "regist.php";?>" method="post" autocomplete="off">

      <label class="field">
        <span class="field__label">昵称</span>
        <input class="field__input" type="text" name="zc6"
               placeholder="江湖上的名号，四字以内" required>
        <span class="field__line" aria-hidden="true"></span>
        <span class="field__note">四字以内</span>
      </label>

      <label class="field">
        <span class="field__label">账号</span>
        <input class="field__input" type="text" name="zc1"
               placeholder="六至十二位字母或数字" required autocomplete="username">
        <span class="field__line" aria-hidden="true"></span>
        <span class="field__note">6–12 位字母或数字</span>
      </label>

      <div class="field-row">
        <label class="field">
          <span class="field__label">密码</span>
          <input class="field__input" type="password" name="zc2"
                 placeholder="设置密码" required autocomplete="new-password">
          <span class="field__line" aria-hidden="true"></span>
          <span class="field__note">6–12 位字母或数字</span>
        </label>

        <label class="field">
          <span class="field__label">确认密码</span>
          <input class="field__input" type="password" name="zc3"
                 placeholder="再输一次" required autocomplete="new-password">
          <span class="field__line" aria-hidden="true"></span>
          <span class="field__note">与上方一致</span>
        </label>
      </div>

      <button class="gate__btn" type="submit" name="submit" value="注册">
        <span>立 即 注 册</span>
      </button>

      <p class="gate__msg" role="alert"><?echo $zcxx;?></p>
    </form>

    <nav class="gate__nav">
      <a href="login.php">已有通行证</a>
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
(function () {
  /* 输入框聚焦效果 */
  document.querySelectorAll('.field__input').forEach(function (inp) {
    inp.addEventListener('focus', function () {
      inp.parentNode.classList.add('is-focus');
    });
    inp.addEventListener('blur', function () {
      inp.parentNode.classList.remove('is-focus');
    });
  });

  /* 两次密码一致性预检（不拦截提交，只做提示） */
  var p1 = document.querySelector('input[name=zc2]');
  var p2 = document.querySelector('input[name=zc3]');
  if (p1 && p2) {
    p2.addEventListener('input', function () {
      var ok = p2.value === '' || p2.value === p1.value;
      p2.parentNode.classList.toggle('is-error', !ok);
    });
  }
})();
</script>

</body>
</html>
