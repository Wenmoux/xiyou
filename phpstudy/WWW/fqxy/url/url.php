<?php

include_once (__DIR__.'/../../config/Common.php');

$urlid=1;//1为本地2为服务器

if ($urlid==1) {//本地游戏地址
$xxjyurl=config_item('host');//返回官网地址
$url=config_item('host');//游戏地址
} elseif($urlid==2){  
$xxjyurl="127.0.0.1";//返回官网地址
//$url="127.0.0.1";//1-2游戏地址
$url="127.0.0.1";//3游戏地址
}else{
$xxjyurl=config_item('host');//返回官网地址
$url=config_item('host');//游戏地址
}
?>




