-- MySQL dump 10.13  Distrib 5.5.47, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: xyy
-- ------------------------------------------------------
-- Server version	5.5.47

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `xyy`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `xyy` /*!40100 DEFAULT CHARACTER SET gbk */;

USE `xyy`;

--
-- Table structure for table `all_boss`
--

DROP TABLE IF EXISTS `all_boss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_boss` (
  `bossid` int(11) NOT NULL,
  `bossmz` text NOT NULL,
  `bosstime` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_boss`
--

LOCK TABLES `all_boss` WRITE;
/*!40000 ALTER TABLE `all_boss` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_boss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_bp`
--

DROP TABLE IF EXISTS `all_bp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_bp` (
  `bpid` int(11) NOT NULL,
  `bpdj` int(11) NOT NULL,
  `bpmz` text NOT NULL,
  `cbpmz` text NOT NULL,
  `cwjid` int(11) NOT NULL,
  `xbpmz` text NOT NULL,
  `xwjid` int(11) NOT NULL,
  `ccmz01` text NOT NULL,
  `ccid01` int(11) NOT NULL,
  `ccmz02` text NOT NULL,
  `ccid02` int(11) NOT NULL,
  `ccmz03` text NOT NULL,
  `ccid03` int(11) NOT NULL,
  `ccmz04` int(11) NOT NULL,
  `ccid04` int(11) NOT NULL,
  `ccmz05` text NOT NULL,
  `ccid05` int(11) NOT NULL,
  `ccmz06` text NOT NULL,
  `ccid06` int(11) NOT NULL,
  `bprsmax` int(11) NOT NULL,
  `bpjymax` int(11) NOT NULL,
  `bpyl` int(11) NOT NULL,
  `bpsw` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_bp`
--

LOCK TABLES `all_bp` WRITE;
/*!40000 ALTER TABLE `all_bp` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_bp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_cz`
--

DROP TABLE IF EXISTS `all_cz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_cz` (
  `id` int(11) NOT NULL COMMENT '排序',
  `czid` int(11) NOT NULL COMMENT '充值id',
  `czje` int(11) NOT NULL COMMENT '充值金额',
  `cztime` datetime NOT NULL COMMENT '充值时间',
  `czfl` int(11) NOT NULL COMMENT '充值方式'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_cz`
--

LOCK TABLES `all_cz` WRITE;
/*!40000 ALTER TABLE `all_cz` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_cz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_gzhoures`
--

DROP TABLE IF EXISTS `all_gzhoures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_gzhoures` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `fzid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `fzmz` text NOT NULL,
  `fzfl` int(11) NOT NULL,
  `fzgm` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_gzhoures`
--

LOCK TABLES `all_gzhoures` WRITE;
/*!40000 ALTER TABLE `all_gzhoures` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_gzhoures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_hbmoney`
--

DROP TABLE IF EXISTS `all_hbmoney`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_hbmoney` (
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `money` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_hbmoney`
--

LOCK TABLES `all_hbmoney` WRITE;
/*!40000 ALTER TABLE `all_hbmoney` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_hbmoney` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_hbmoneyjc`
--

DROP TABLE IF EXISTS `all_hbmoneyjc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_hbmoneyjc` (
  `id` int(11) NOT NULL,
  `money` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_hbmoneyjc`
--

LOCK TABLES `all_hbmoneyjc` WRITE;
/*!40000 ALTER TABLE `all_hbmoneyjc` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_hbmoneyjc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_hdph01`
--

DROP TABLE IF EXISTS `all_hdph01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_hdph01` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `vip` int(11) NOT NULL,
  `ds01` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_hdph01`
--

LOCK TABLES `all_hdph01` WRITE;
/*!40000 ALTER TABLE `all_hdph01` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_hdph01` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_hdph02`
--

DROP TABLE IF EXISTS `all_hdph02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_hdph02` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `vip` int(11) NOT NULL,
  `ds01` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_hdph02`
--

LOCK TABLES `all_hdph02` WRITE;
/*!40000 ALTER TABLE `all_hdph02` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_hdph02` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_hdph03`
--

DROP TABLE IF EXISTS `all_hdph03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_hdph03` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `vip` int(11) NOT NULL,
  `ds01` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_hdph03`
--

LOCK TABLES `all_hdph03` WRITE;
/*!40000 ALTER TABLE `all_hdph03` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_hdph03` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_houres`
--

DROP TABLE IF EXISTS `all_houres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_houres` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `fzid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `fzmz` text NOT NULL,
  `fzfl` int(11) NOT NULL,
  `fzgm` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_houres`
--

LOCK TABLES `all_houres` WRITE;
/*!40000 ALTER TABLE `all_houres` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_houres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_ip`
--

DROP TABLE IF EXISTS `all_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_ip` (
  `ip` text NOT NULL,
  `iptime` datetime NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjname` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_ip`
--

LOCK TABLES `all_ip` WRITE;
/*!40000 ALTER TABLE `all_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_jc`
--

DROP TABLE IF EXISTS `all_jc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_jc` (
  `id` int(11) NOT NULL,
  `xlid` int(11) NOT NULL,
  `jc` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_jc`
--

LOCK TABLES `all_jc` WRITE;
/*!40000 ALTER TABLE `all_jc` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_jc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_jdjc`
--

DROP TABLE IF EXISTS `all_jdjc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_jdjc` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `wjid` int(11) NOT NULL DEFAULT '0' COMMENT '玩家id',
  `vip` int(11) NOT NULL DEFAULT '0' COMMENT 'vip等级',
  `wjmz` text NOT NULL COMMENT '玩家名字',
  `jcjg` text NOT NULL COMMENT '竞猜价格',
  `cq` int(11) NOT NULL DEFAULT '0' COMMENT '出拳',
  `timex` text NOT NULL COMMENT '竞猜时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_jdjc`
--

LOCK TABLES `all_jdjc` WRITE;
/*!40000 ALTER TABLE `all_jdjc` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_jdjc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_ltbw`
--

DROP TABLE IF EXISTS `all_ltbw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_ltbw` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `wjid` int(11) NOT NULL DEFAULT '0' COMMENT '玩家id',
  `wjmz` text NOT NULL COMMENT '玩家名字',
  `zltime` datetime NOT NULL COMMENT '占领时间',
  `zlmb` int(11) NOT NULL DEFAULT '0' COMMENT '占领膜拜',
  `lthp` text NOT NULL COMMENT '擂台hp',
  `ltgj` text NOT NULL COMMENT '擂台攻击',
  `ltmg` text NOT NULL COMMENT '擂台魔攻',
  `ltfy` text NOT NULL COMMENT '擂台防御',
  `ltmp` text NOT NULL COMMENT '擂台门派'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_ltbw`
--

LOCK TABLES `all_ltbw` WRITE;
/*!40000 ALTER TABLE `all_ltbw` DISABLE KEYS */;

/*!40000 ALTER TABLE `all_ltbw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_money`
--

DROP TABLE IF EXISTS `all_money`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_money` (
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `money` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_money`
--

LOCK TABLES `all_money` WRITE;
/*!40000 ALTER TABLE `all_money` DISABLE KEYS */;

/*!40000 ALTER TABLE `all_money` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_moneyjc`
--

DROP TABLE IF EXISTS `all_moneyjc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_moneyjc` (
  `id` int(11) NOT NULL,
  `money` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_moneyjc`
--

LOCK TABLES `all_moneyjc` WRITE;
/*!40000 ALTER TABLE `all_moneyjc` DISABLE KEYS */;
INSERT INTO `all_moneyjc` VALUES (1,'980'),(2,'1000');
/*!40000 ALTER TABLE `all_moneyjc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_pay`
--

DROP TABLE IF EXISTS `all_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_pay` (
  `id` int(11) NOT NULL,
  `payid` text NOT NULL,
  `paywjid` int(11) NOT NULL,
  `price` text NOT NULL,
  `payzf` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_pay`
--

LOCK TABLES `all_pay` WRITE;
/*!40000 ALTER TABLE `all_pay` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_pay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_phb`
--

DROP TABLE IF EXISTS `all_phb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_phb` (
  `id` int(11) NOT NULL COMMENT '标识',
  `wjid` int(11) NOT NULL COMMENT '玩家id',
  `wjmz` text NOT NULL COMMENT '玩家名字',
  `vip` int(11) NOT NULL,
  `phb1` text NOT NULL COMMENT '气血榜',
  `phb2` text NOT NULL COMMENT '攻击榜',
  `phb3` text NOT NULL COMMENT '魔攻榜',
  `phb4` text NOT NULL COMMENT '防御榜',
  `phb5` text NOT NULL COMMENT '等级榜',
  `phb6` text NOT NULL COMMENT '银两榜',
  `phb7` text NOT NULL COMMENT '金豆榜',
  `phb8` text NOT NULL COMMENT '充值榜'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_phb`
--

LOCK TABLES `all_phb` WRITE;
/*!40000 ALTER TABLE `all_phb` DISABLE KEYS */;

/*!40000 ALTER TABLE `all_phb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_pm`
--

DROP TABLE IF EXISTS `all_pm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_pm` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '标识',
  `wjid` int(11) NOT NULL DEFAULT '0' COMMENT '玩家id',
  `wjmz` text NOT NULL COMMENT '玩家名字',
  `pmtime` datetime NOT NULL COMMENT '拍卖时间',
  `pmwpid` int(11) NOT NULL DEFAULT '0' COMMENT '拍卖物品id',
  `pmwpmz` text NOT NULL COMMENT '拍卖物品名字',
  `pmwpsl` int(11) NOT NULL DEFAULT '0' COMMENT '拍卖物品数量',
  `pmwpjg` text NOT NULL COMMENT '拍卖物品价格',
  `pmsjc` int(11) NOT NULL DEFAULT '0' COMMENT '拍卖时间搓',
  `pmwpfl` int(11) NOT NULL DEFAULT '0' COMMENT '拍卖物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_pm`
--

LOCK TABLES `all_pm` WRITE;
/*!40000 ALTER TABLE `all_pm` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_pm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_qd`
--

DROP TABLE IF EXISTS `all_qd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_qd` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL COMMENT '玩家id',
  `qdsj` datetime NOT NULL COMMENT '签到时间',
  `qdcs` int(11) NOT NULL COMMENT '签到次数',
  `qdy` int(11) NOT NULL COMMENT '签到月份',
  `qd1` int(11) NOT NULL COMMENT '签到1',
  `qd2` int(11) NOT NULL COMMENT '签到2',
  `qd3` int(11) NOT NULL COMMENT '签到3',
  `qd4` int(11) NOT NULL COMMENT '签到4',
  `qd5` int(11) NOT NULL COMMENT '签到5'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_qd`
--

LOCK TABLES `all_qd` WRITE;
/*!40000 ALTER TABLE `all_qd` DISABLE KEYS */;

/*!40000 ALTER TABLE `all_qd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_qggz`
--

DROP TABLE IF EXISTS `all_qggz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_qggz` (
  `id` int(11) NOT NULL,
  `qgxx` text NOT NULL,
  `qgmz` text NOT NULL,
  `wjid` int(11) NOT NULL,
  `qgjg` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_qggz`
--

LOCK TABLES `all_qggz` WRITE;
/*!40000 ALTER TABLE `all_qggz` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_qggz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_qtjc`
--

DROP TABLE IF EXISTS `all_qtjc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_qtjc` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `wjid` int(11) NOT NULL DEFAULT '0' COMMENT '玩家id',
  `vip` int(11) NOT NULL DEFAULT '0' COMMENT 'vip等级',
  `wjmz` text NOT NULL COMMENT '玩家名字',
  `jcjg` text NOT NULL COMMENT '竞猜价格',
  `cq` int(11) NOT NULL DEFAULT '0' COMMENT '出拳',
  `timex` text NOT NULL COMMENT '竞猜时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_qtjc`
--

LOCK TABLES `all_qtjc` WRITE;
/*!40000 ALTER TABLE `all_qtjc` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_qtjc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_sdk`
--

DROP TABLE IF EXISTS `all_sdk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_sdk` (
  `sdkid` int(11) NOT NULL,
  `sdk` text NOT NULL,
  `sdktime` datetime NOT NULL,
  `sdkfl` int(11) NOT NULL,
  `sdksy` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_sdk`
--

LOCK TABLES `all_sdk` WRITE;
/*!40000 ALTER TABLE `all_sdk` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_sdk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_user`
--

DROP TABLE IF EXISTS `all_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_user` (
  `wjid` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `wjname` text NOT NULL,
  `wjtime` datetime NOT NULL,
  `utime` int(11) NOT NULL,
  `fl` int(11) NOT NULL,
  `yj` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_user`
--

LOCK TABLES `all_user` WRITE;
/*!40000 ALTER TABLE `all_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_xjhb`
--

DROP TABLE IF EXISTS `all_xjhb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_xjhb` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `wjje` int(11) NOT NULL,
  `zh1` text NOT NULL,
  `zh2` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_xjhb`
--

LOCK TABLES `all_xjhb` WRITE;
/*!40000 ALTER TABLE `all_xjhb` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_xjhb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_yd01`
--

DROP TABLE IF EXISTS `all_yd01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_yd01` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `vip` int(11) NOT NULL,
  `ds01` int(11) NOT NULL,
  `ds02` int(11) NOT NULL,
  `dy01_time` datetime NOT NULL,
  `yd01` int(11) NOT NULL COMMENT '免费',
  `yd02` int(11) NOT NULL COMMENT '收费'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_yd01`
--

LOCK TABLES `all_yd01` WRITE;
/*!40000 ALTER TABLE `all_yd01` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_yd01` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_yd02`
--

DROP TABLE IF EXISTS `all_yd02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_yd02` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `vip` int(11) NOT NULL,
  `ds01` int(11) NOT NULL,
  `ds02` int(11) NOT NULL,
  `dy01_time` datetime NOT NULL,
  `yd01` int(11) NOT NULL COMMENT '免费',
  `yd02` int(11) NOT NULL COMMENT '收费'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_yd02`
--

LOCK TABLES `all_yd02` WRITE;
/*!40000 ALTER TABLE `all_yd02` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_yd02` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_yd03`
--

DROP TABLE IF EXISTS `all_yd03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_yd03` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `vip` int(11) NOT NULL,
  `ds01` int(11) NOT NULL,
  `ds02` int(11) NOT NULL,
  `dy01_time` datetime NOT NULL,
  `yd01` int(11) NOT NULL COMMENT '免费',
  `yd02` int(11) NOT NULL COMMENT '收费'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_yd03`
--

LOCK TABLES `all_yd03` WRITE;
/*!40000 ALTER TABLE `all_yd03` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_yd03` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_yd04`
--

DROP TABLE IF EXISTS `all_yd04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_yd04` (
  `id` int(11) NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjmz` text NOT NULL,
  `vip` int(11) NOT NULL,
  `ds01` int(11) NOT NULL,
  `ds02` int(11) NOT NULL,
  `dy01_time` datetime NOT NULL,
  `yd01` int(11) NOT NULL COMMENT '免费',
  `yd02` int(11) NOT NULL COMMENT '收费'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_yd04`
--

LOCK TABLES `all_yd04` WRITE;
/*!40000 ALTER TABLE `all_yd04` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_yd04` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_yl`
--

DROP TABLE IF EXISTS `all_yl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_yl` (
  `wjid` int(11) NOT NULL COMMENT '玩家id',
  `bbyl` text NOT NULL COMMENT '背包银两',
  `ckyl` text NOT NULL COMMENT '仓库银两'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_yl`
--

LOCK TABLES `all_yl` WRITE;
/*!40000 ALTER TABLE `all_yl` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_yl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_ylck`
--

DROP TABLE IF EXISTS `all_ylck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_ylck` (
  `wjid` int(11) NOT NULL DEFAULT '0' COMMENT '玩家id',
  `yl01` text NOT NULL COMMENT '银两',
  `yl02` text NOT NULL COMMENT '金豆',
  `yl03` text NOT NULL COMMENT '金带'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_ylck`
--

LOCK TABLES `all_ylck` WRITE;
/*!40000 ALTER TABLE `all_ylck` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_ylck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_zt`
--

DROP TABLE IF EXISTS `all_zt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_zt` (
  `wjid` int(11) NOT NULL COMMENT '玩家id',
  `username` text NOT NULL COMMENT '玩家名字',
  `sex` int(11) NOT NULL COMMENT '玩家性别',
  `tx` text NOT NULL COMMENT '玩家头衔',
  `peiou` text NOT NULL,
  `peiouid` int(11) NOT NULL,
  `zzmz` text NOT NULL,
  `zzid` int(11) NOT NULL,
  `zzfl` int(11) NOT NULL,
  `dj` int(11) NOT NULL COMMENT '玩家等级',
  `mpp` int(11) NOT NULL,
  `bpmz` text NOT NULL,
  `bpid` int(11) NOT NULL,
  `vip` int(11) NOT NULL,
  `vipjy` int(11) NOT NULL,
  `gsrl` int(11) NOT NULL,
  `bbrl` int(11) NOT NULL,
  `ckrl` int(11) NOT NULL,
  `emz` int(11) NOT NULL,
  `lh` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_zt`
--

LOCK TABLES `all_zt` WRITE;
/*!40000 ALTER TABLE `all_zt` DISABLE KEYS */;

/*!40000 ALTER TABLE `all_zt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckqt10000001`
--

DROP TABLE IF EXISTS `ckqt10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckqt10000001` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckqt10000001`
--

LOCK TABLES `ckqt10000001` WRITE;
/*!40000 ALTER TABLE `ckqt10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckqt10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckqt10000002`
--

DROP TABLE IF EXISTS `ckqt10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckqt10000002` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckqt10000002`
--

LOCK TABLES `ckqt10000002` WRITE;
/*!40000 ALTER TABLE `ckqt10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckqt10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckqt10000003`
--

DROP TABLE IF EXISTS `ckqt10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckqt10000003` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckqt10000003`
--

LOCK TABLES `ckqt10000003` WRITE;
/*!40000 ALTER TABLE `ckqt10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckqt10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckqt10000004`
--

DROP TABLE IF EXISTS `ckqt10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckqt10000004` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckqt10000004`
--

LOCK TABLES `ckqt10000004` WRITE;
/*!40000 ALTER TABLE `ckqt10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckqt10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckqt10000005`
--

DROP TABLE IF EXISTS `ckqt10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckqt10000005` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckqt10000005`
--

LOCK TABLES `ckqt10000005` WRITE;
/*!40000 ALTER TABLE `ckqt10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckqt10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckqt10000006`
--

DROP TABLE IF EXISTS `ckqt10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckqt10000006` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckqt10000006`
--

LOCK TABLES `ckqt10000006` WRITE;
/*!40000 ALTER TABLE `ckqt10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckqt10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckqt10000007`
--

DROP TABLE IF EXISTS `ckqt10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckqt10000007` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckqt10000007`
--

LOCK TABLES `ckqt10000007` WRITE;
/*!40000 ALTER TABLE `ckqt10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckqt10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckwp10000001`
--

DROP TABLE IF EXISTS `ckwp10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckwp10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckwp10000001`
--

LOCK TABLES `ckwp10000001` WRITE;
/*!40000 ALTER TABLE `ckwp10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckwp10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckwp10000002`
--

DROP TABLE IF EXISTS `ckwp10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckwp10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckwp10000002`
--

LOCK TABLES `ckwp10000002` WRITE;
/*!40000 ALTER TABLE `ckwp10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckwp10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckwp10000003`
--

DROP TABLE IF EXISTS `ckwp10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckwp10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckwp10000003`
--

LOCK TABLES `ckwp10000003` WRITE;
/*!40000 ALTER TABLE `ckwp10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckwp10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckwp10000004`
--

DROP TABLE IF EXISTS `ckwp10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckwp10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckwp10000004`
--

LOCK TABLES `ckwp10000004` WRITE;
/*!40000 ALTER TABLE `ckwp10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckwp10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckwp10000005`
--

DROP TABLE IF EXISTS `ckwp10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckwp10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckwp10000005`
--

LOCK TABLES `ckwp10000005` WRITE;
/*!40000 ALTER TABLE `ckwp10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckwp10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckwp10000006`
--

DROP TABLE IF EXISTS `ckwp10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckwp10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckwp10000006`
--

LOCK TABLES `ckwp10000006` WRITE;
/*!40000 ALTER TABLE `ckwp10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckwp10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckwp10000007`
--

DROP TABLE IF EXISTS `ckwp10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckwp10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckwp10000007`
--

LOCK TABLES `ckwp10000007` WRITE;
/*!40000 ALTER TABLE `ckwp10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckwp10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckzb10000001`
--

DROP TABLE IF EXISTS `ckzb10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckzb10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckzb10000001`
--

LOCK TABLES `ckzb10000001` WRITE;
/*!40000 ALTER TABLE `ckzb10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckzb10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckzb10000002`
--

DROP TABLE IF EXISTS `ckzb10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckzb10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckzb10000002`
--

LOCK TABLES `ckzb10000002` WRITE;
/*!40000 ALTER TABLE `ckzb10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckzb10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckzb10000003`
--

DROP TABLE IF EXISTS `ckzb10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckzb10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckzb10000003`
--

LOCK TABLES `ckzb10000003` WRITE;
/*!40000 ALTER TABLE `ckzb10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckzb10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckzb10000004`
--

DROP TABLE IF EXISTS `ckzb10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckzb10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckzb10000004`
--

LOCK TABLES `ckzb10000004` WRITE;
/*!40000 ALTER TABLE `ckzb10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckzb10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckzb10000005`
--

DROP TABLE IF EXISTS `ckzb10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckzb10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckzb10000005`
--

LOCK TABLES `ckzb10000005` WRITE;
/*!40000 ALTER TABLE `ckzb10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckzb10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckzb10000006`
--

DROP TABLE IF EXISTS `ckzb10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckzb10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckzb10000006`
--

LOCK TABLES `ckzb10000006` WRITE;
/*!40000 ALTER TABLE `ckzb10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckzb10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckzb10000007`
--

DROP TABLE IF EXISTS `ckzb10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckzb10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '仓库镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '仓库装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckzb10000007`
--

LOCK TABLES `ckzb10000007` WRITE;
/*!40000 ALTER TABLE `ckzb10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckzb10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cw10000001`
--

DROP TABLE IF EXISTS `cw10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cw10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw10000001`
--

LOCK TABLES `cw10000001` WRITE;
/*!40000 ALTER TABLE `cw10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cw10000002`
--

DROP TABLE IF EXISTS `cw10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cw10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw10000002`
--

LOCK TABLES `cw10000002` WRITE;
/*!40000 ALTER TABLE `cw10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cw10000003`
--

DROP TABLE IF EXISTS `cw10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cw10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw10000003`
--

LOCK TABLES `cw10000003` WRITE;
/*!40000 ALTER TABLE `cw10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cw10000004`
--

DROP TABLE IF EXISTS `cw10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cw10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw10000004`
--

LOCK TABLES `cw10000004` WRITE;
/*!40000 ALTER TABLE `cw10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cw10000005`
--

DROP TABLE IF EXISTS `cw10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cw10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw10000005`
--

LOCK TABLES `cw10000005` WRITE;
/*!40000 ALTER TABLE `cw10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cw10000006`
--

DROP TABLE IF EXISTS `cw10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cw10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw10000006`
--

LOCK TABLES `cw10000006` WRITE;
/*!40000 ALTER TABLE `cw10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cw10000007`
--

DROP TABLE IF EXISTS `cw10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cw10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cw10000007`
--

LOCK TABLES `cw10000007` WRITE;
/*!40000 ALTER TABLE `cw10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `cw10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cwzbb10000001`
--

DROP TABLE IF EXISTS `cwzbb10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cwzbb10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类',
  `cwid` text NOT NULL COMMENT '宠物ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cwzbb10000001`
--

LOCK TABLES `cwzbb10000001` WRITE;
/*!40000 ALTER TABLE `cwzbb10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `cwzbb10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cwzbb10000002`
--

DROP TABLE IF EXISTS `cwzbb10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cwzbb10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类',
  `cwid` text NOT NULL COMMENT '宠物ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cwzbb10000002`
--

LOCK TABLES `cwzbb10000002` WRITE;
/*!40000 ALTER TABLE `cwzbb10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `cwzbb10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cwzbb10000003`
--

DROP TABLE IF EXISTS `cwzbb10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cwzbb10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类',
  `cwid` text NOT NULL COMMENT '宠物ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cwzbb10000003`
--

LOCK TABLES `cwzbb10000003` WRITE;
/*!40000 ALTER TABLE `cwzbb10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `cwzbb10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cwzbb10000004`
--

DROP TABLE IF EXISTS `cwzbb10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cwzbb10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类',
  `cwid` text NOT NULL COMMENT '宠物ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cwzbb10000004`
--

LOCK TABLES `cwzbb10000004` WRITE;
/*!40000 ALTER TABLE `cwzbb10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `cwzbb10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cwzbb10000005`
--

DROP TABLE IF EXISTS `cwzbb10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cwzbb10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类',
  `cwid` text NOT NULL COMMENT '宠物ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cwzbb10000005`
--

LOCK TABLES `cwzbb10000005` WRITE;
/*!40000 ALTER TABLE `cwzbb10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `cwzbb10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cwzbb10000006`
--

DROP TABLE IF EXISTS `cwzbb10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cwzbb10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类',
  `cwid` text NOT NULL COMMENT '宠物ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cwzbb10000006`
--

LOCK TABLES `cwzbb10000006` WRITE;
/*!40000 ALTER TABLE `cwzbb10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `cwzbb10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cwzbb10000007`
--

DROP TABLE IF EXISTS `cwzbb10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cwzbb10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类',
  `cwid` text NOT NULL COMMENT '宠物ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cwzbb10000007`
--

LOCK TABLES `cwzbb10000007` WRITE;
/*!40000 ALTER TABLE `cwzbb10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `cwzbb10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dyxx10000001`
--

DROP TABLE IF EXISTS `dyxx10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dyxx10000001` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dyxx10000001`
--

LOCK TABLES `dyxx10000001` WRITE;
/*!40000 ALTER TABLE `dyxx10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `dyxx10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dyxx10000002`
--

DROP TABLE IF EXISTS `dyxx10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dyxx10000002` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dyxx10000002`
--

LOCK TABLES `dyxx10000002` WRITE;
/*!40000 ALTER TABLE `dyxx10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `dyxx10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dyxx10000003`
--

DROP TABLE IF EXISTS `dyxx10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dyxx10000003` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dyxx10000003`
--

LOCK TABLES `dyxx10000003` WRITE;
/*!40000 ALTER TABLE `dyxx10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `dyxx10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dyxx10000004`
--

DROP TABLE IF EXISTS `dyxx10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dyxx10000004` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dyxx10000004`
--

LOCK TABLES `dyxx10000004` WRITE;
/*!40000 ALTER TABLE `dyxx10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `dyxx10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dyxx10000005`
--

DROP TABLE IF EXISTS `dyxx10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dyxx10000005` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dyxx10000005`
--

LOCK TABLES `dyxx10000005` WRITE;
/*!40000 ALTER TABLE `dyxx10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `dyxx10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dyxx10000006`
--

DROP TABLE IF EXISTS `dyxx10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dyxx10000006` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dyxx10000006`
--

LOCK TABLES `dyxx10000006` WRITE;
/*!40000 ALTER TABLE `dyxx10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `dyxx10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dyxx10000007`
--

DROP TABLE IF EXISTS `dyxx10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dyxx10000007` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dyxx10000007`
--

LOCK TABLES `dyxx10000007` WRITE;
/*!40000 ALTER TABLE `dyxx10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `dyxx10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb10000001`
--

DROP TABLE IF EXISTS `fb10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb10000001`
--

LOCK TABLES `fb10000001` WRITE;
/*!40000 ALTER TABLE `fb10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `fb10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb10000002`
--

DROP TABLE IF EXISTS `fb10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb10000002`
--

LOCK TABLES `fb10000002` WRITE;
/*!40000 ALTER TABLE `fb10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `fb10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb10000003`
--

DROP TABLE IF EXISTS `fb10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb10000003`
--

LOCK TABLES `fb10000003` WRITE;
/*!40000 ALTER TABLE `fb10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `fb10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb10000004`
--

DROP TABLE IF EXISTS `fb10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb10000004`
--

LOCK TABLES `fb10000004` WRITE;
/*!40000 ALTER TABLE `fb10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `fb10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb10000005`
--

DROP TABLE IF EXISTS `fb10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb10000005`
--

LOCK TABLES `fb10000005` WRITE;
/*!40000 ALTER TABLE `fb10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `fb10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb10000006`
--

DROP TABLE IF EXISTS `fb10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb10000006`
--

LOCK TABLES `fb10000006` WRITE;
/*!40000 ALTER TABLE `fb10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `fb10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb10000007`
--

DROP TABLE IF EXISTS `fb10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb10000007`
--

LOCK TABLES `fb10000007` WRITE;
/*!40000 ALTER TABLE `fb10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `fb10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsqt10000001`
--

DROP TABLE IF EXISTS `gsqt10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsqt10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsqt10000001`
--

LOCK TABLES `gsqt10000001` WRITE;
/*!40000 ALTER TABLE `gsqt10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `gsqt10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsqt10000002`
--

DROP TABLE IF EXISTS `gsqt10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsqt10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsqt10000002`
--

LOCK TABLES `gsqt10000002` WRITE;
/*!40000 ALTER TABLE `gsqt10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `gsqt10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsqt10000003`
--

DROP TABLE IF EXISTS `gsqt10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsqt10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsqt10000003`
--

LOCK TABLES `gsqt10000003` WRITE;
/*!40000 ALTER TABLE `gsqt10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `gsqt10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsqt10000004`
--

DROP TABLE IF EXISTS `gsqt10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsqt10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsqt10000004`
--

LOCK TABLES `gsqt10000004` WRITE;
/*!40000 ALTER TABLE `gsqt10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `gsqt10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsqt10000005`
--

DROP TABLE IF EXISTS `gsqt10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsqt10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsqt10000005`
--

LOCK TABLES `gsqt10000005` WRITE;
/*!40000 ALTER TABLE `gsqt10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `gsqt10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsqt10000006`
--

DROP TABLE IF EXISTS `gsqt10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsqt10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsqt10000006`
--

LOCK TABLES `gsqt10000006` WRITE;
/*!40000 ALTER TABLE `gsqt10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `gsqt10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsqt10000007`
--

DROP TABLE IF EXISTS `gsqt10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsqt10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsqt10000007`
--

LOCK TABLES `gsqt10000007` WRITE;
/*!40000 ALTER TABLE `gsqt10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `gsqt10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gswp10000001`
--

DROP TABLE IF EXISTS `gswp10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gswp10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gswp10000001`
--

LOCK TABLES `gswp10000001` WRITE;
/*!40000 ALTER TABLE `gswp10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `gswp10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gswp10000002`
--

DROP TABLE IF EXISTS `gswp10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gswp10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gswp10000002`
--

LOCK TABLES `gswp10000002` WRITE;
/*!40000 ALTER TABLE `gswp10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `gswp10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gswp10000003`
--

DROP TABLE IF EXISTS `gswp10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gswp10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gswp10000003`
--

LOCK TABLES `gswp10000003` WRITE;
/*!40000 ALTER TABLE `gswp10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `gswp10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gswp10000004`
--

DROP TABLE IF EXISTS `gswp10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gswp10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gswp10000004`
--

LOCK TABLES `gswp10000004` WRITE;
/*!40000 ALTER TABLE `gswp10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `gswp10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gswp10000005`
--

DROP TABLE IF EXISTS `gswp10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gswp10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gswp10000005`
--

LOCK TABLES `gswp10000005` WRITE;
/*!40000 ALTER TABLE `gswp10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `gswp10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gswp10000006`
--

DROP TABLE IF EXISTS `gswp10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gswp10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gswp10000006`
--

LOCK TABLES `gswp10000006` WRITE;
/*!40000 ALTER TABLE `gswp10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `gswp10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gswp10000007`
--

DROP TABLE IF EXISTS `gswp10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gswp10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gswp10000007`
--

LOCK TABLES `gswp10000007` WRITE;
/*!40000 ALTER TABLE `gswp10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `gswp10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gszb10000001`
--

DROP TABLE IF EXISTS `gszb10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gszb10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备佩戴',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gszb10000001`
--

LOCK TABLES `gszb10000001` WRITE;
/*!40000 ALTER TABLE `gszb10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `gszb10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gszb10000002`
--

DROP TABLE IF EXISTS `gszb10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gszb10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备佩戴',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gszb10000002`
--

LOCK TABLES `gszb10000002` WRITE;
/*!40000 ALTER TABLE `gszb10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `gszb10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gszb10000003`
--

DROP TABLE IF EXISTS `gszb10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gszb10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备佩戴',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gszb10000003`
--

LOCK TABLES `gszb10000003` WRITE;
/*!40000 ALTER TABLE `gszb10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `gszb10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gszb10000004`
--

DROP TABLE IF EXISTS `gszb10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gszb10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备佩戴',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gszb10000004`
--

LOCK TABLES `gszb10000004` WRITE;
/*!40000 ALTER TABLE `gszb10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `gszb10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gszb10000005`
--

DROP TABLE IF EXISTS `gszb10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gszb10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备佩戴',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gszb10000005`
--

LOCK TABLES `gszb10000005` WRITE;
/*!40000 ALTER TABLE `gszb10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `gszb10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gszb10000006`
--

DROP TABLE IF EXISTS `gszb10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gszb10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备佩戴',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gszb10000006`
--

LOCK TABLES `gszb10000006` WRITE;
/*!40000 ALTER TABLE `gszb10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `gszb10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gszb10000007`
--

DROP TABLE IF EXISTS `gszb10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gszb10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '挂售镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '挂售装备佩戴',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gszb10000007`
--

LOCK TABLES `gszb10000007` WRITE;
/*!40000 ALTER TABLE `gszb10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `gszb10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gz01`
--

DROP TABLE IF EXISTS `gz01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gz01` (
  `zcid` int(11) NOT NULL,
  `zlgj` text NOT NULL,
  `zlgjid` int(11) NOT NULL,
  `gjjz` text NOT NULL,
  `gjjzid` int(11) NOT NULL,
  `czz` text NOT NULL,
  `czzid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gz01`
--

LOCK TABLES `gz01` WRITE;
/*!40000 ALTER TABLE `gz01` DISABLE KEYS */;
/*!40000 ALTER TABLE `gz01` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gz02`
--

DROP TABLE IF EXISTS `gz02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gz02` (
  `id` int(11) NOT NULL,
  `gjmz` text NOT NULL,
  `gjid` int(11) NOT NULL,
  `jzmz` text NOT NULL,
  `jzid` int(11) NOT NULL,
  `gjjf` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gz02`
--

LOCK TABLES `gz02` WRITE;
/*!40000 ALTER TABLE `gz02` DISABLE KEYS */;
/*!40000 ALTER TABLE `gz02` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gz03`
--

DROP TABLE IF EXISTS `gz03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gz03` (
  `id` int(11) NOT NULL,
  `gjmz` text NOT NULL,
  `gjid` int(11) NOT NULL,
  `jzmz` text NOT NULL,
  `jzid` int(11) NOT NULL,
  `gjjf` int(11) NOT NULL,
  `lq` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gz03`
--

LOCK TABLES `gz03` WRITE;
/*!40000 ALTER TABLE `gz03` DISABLE KEYS */;
/*!40000 ALTER TABLE `gz03` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gz04`
--

DROP TABLE IF EXISTS `gz04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gz04` (
  `id` int(11) NOT NULL,
  `wjname` text NOT NULL,
  `wjid` int(11) NOT NULL,
  `wjgzjf` int(11) NOT NULL,
  `wjlq` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gz04`
--

LOCK TABLES `gz04` WRITE;
/*!40000 ALTER TABLE `gz04` DISABLE KEYS */;
/*!40000 ALTER TABLE `gz04` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gz05`
--

DROP TABLE IF EXISTS `gz05`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gz05` (
  `id` int(11) NOT NULL,
  `gztime` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gz05`
--

LOCK TABLES `gz05` WRITE;
/*!40000 ALTER TABLE `gz05` DISABLE KEYS */;
/*!40000 ALTER TABLE `gz05` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hd10000001`
--

DROP TABLE IF EXISTS `hd10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hd10000001` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hd10000001`
--

LOCK TABLES `hd10000001` WRITE;
/*!40000 ALTER TABLE `hd10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `hd10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hd10000002`
--

DROP TABLE IF EXISTS `hd10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hd10000002` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hd10000002`
--

LOCK TABLES `hd10000002` WRITE;
/*!40000 ALTER TABLE `hd10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `hd10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hd10000003`
--

DROP TABLE IF EXISTS `hd10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hd10000003` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hd10000003`
--

LOCK TABLES `hd10000003` WRITE;
/*!40000 ALTER TABLE `hd10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `hd10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hd10000004`
--

DROP TABLE IF EXISTS `hd10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hd10000004` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hd10000004`
--

LOCK TABLES `hd10000004` WRITE;
/*!40000 ALTER TABLE `hd10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `hd10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hd10000005`
--

DROP TABLE IF EXISTS `hd10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hd10000005` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hd10000005`
--

LOCK TABLES `hd10000005` WRITE;
/*!40000 ALTER TABLE `hd10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `hd10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hd10000006`
--

DROP TABLE IF EXISTS `hd10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hd10000006` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hd10000006`
--

LOCK TABLES `hd10000006` WRITE;
/*!40000 ALTER TABLE `hd10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `hd10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hd10000007`
--

DROP TABLE IF EXISTS `hd10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hd10000007` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hd10000007`
--

LOCK TABLES `hd10000007` WRITE;
/*!40000 ALTER TABLE `hd10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `hd10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hy10000001`
--

DROP TABLE IF EXISTS `hy10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hy10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hy10000001`
--

LOCK TABLES `hy10000001` WRITE;
/*!40000 ALTER TABLE `hy10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `hy10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hy10000002`
--

DROP TABLE IF EXISTS `hy10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hy10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hy10000002`
--

LOCK TABLES `hy10000002` WRITE;
/*!40000 ALTER TABLE `hy10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `hy10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hy10000003`
--

DROP TABLE IF EXISTS `hy10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hy10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hy10000003`
--

LOCK TABLES `hy10000003` WRITE;
/*!40000 ALTER TABLE `hy10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `hy10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hy10000004`
--

DROP TABLE IF EXISTS `hy10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hy10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hy10000004`
--

LOCK TABLES `hy10000004` WRITE;
/*!40000 ALTER TABLE `hy10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `hy10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hy10000005`
--

DROP TABLE IF EXISTS `hy10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hy10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hy10000005`
--

LOCK TABLES `hy10000005` WRITE;
/*!40000 ALTER TABLE `hy10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `hy10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hy10000006`
--

DROP TABLE IF EXISTS `hy10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hy10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hy10000006`
--

LOCK TABLES `hy10000006` WRITE;
/*!40000 ALTER TABLE `hy10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `hy10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hy10000007`
--

DROP TABLE IF EXISTS `hy10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hy10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hy10000007`
--

LOCK TABLES `hy10000007` WRITE;
/*!40000 ALTER TABLE `hy10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `hy10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jfdj10000003`
--

DROP TABLE IF EXISTS `jfdj10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jfdj10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `jfdj` int(11) NOT NULL DEFAULT '0' COMMENT '解封等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jfdj10000003`
--

LOCK TABLES `jfdj10000003` WRITE;
/*!40000 ALTER TABLE `jfdj10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `jfdj10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jfdj10000004`
--

DROP TABLE IF EXISTS `jfdj10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jfdj10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `jfdj` int(11) NOT NULL DEFAULT '0' COMMENT '解封等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jfdj10000004`
--

LOCK TABLES `jfdj10000004` WRITE;
/*!40000 ALTER TABLE `jfdj10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `jfdj10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jfdj10000006`
--

DROP TABLE IF EXISTS `jfdj10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jfdj10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `jfdj` int(11) NOT NULL DEFAULT '0' COMMENT '解封等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jfdj10000006`
--

LOCK TABLES `jfdj10000006` WRITE;
/*!40000 ALTER TABLE `jfdj10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `jfdj10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jj10000001`
--

DROP TABLE IF EXISTS `jj10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jj10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jj10000001`
--

LOCK TABLES `jj10000001` WRITE;
/*!40000 ALTER TABLE `jj10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `jj10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jj10000002`
--

DROP TABLE IF EXISTS `jj10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jj10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jj10000002`
--

LOCK TABLES `jj10000002` WRITE;
/*!40000 ALTER TABLE `jj10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `jj10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jj10000003`
--

DROP TABLE IF EXISTS `jj10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jj10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jj10000003`
--

LOCK TABLES `jj10000003` WRITE;
/*!40000 ALTER TABLE `jj10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `jj10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jj10000004`
--

DROP TABLE IF EXISTS `jj10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jj10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jj10000004`
--

LOCK TABLES `jj10000004` WRITE;
/*!40000 ALTER TABLE `jj10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `jj10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jj10000005`
--

DROP TABLE IF EXISTS `jj10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jj10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jj10000005`
--

LOCK TABLES `jj10000005` WRITE;
/*!40000 ALTER TABLE `jj10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `jj10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jj10000006`
--

DROP TABLE IF EXISTS `jj10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jj10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jj10000006`
--

LOCK TABLES `jj10000006` WRITE;
/*!40000 ALTER TABLE `jj10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `jj10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jj10000007`
--

DROP TABLE IF EXISTS `jj10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jj10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jj10000007`
--

LOCK TABLES `jj10000007` WRITE;
/*!40000 ALTER TABLE `jj10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `jj10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnn10000001`
--

DROP TABLE IF EXISTS `jnn10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnn10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jnn10000001`
--

LOCK TABLES `jnn10000001` WRITE;
/*!40000 ALTER TABLE `jnn10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `jnn10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnn10000002`
--

DROP TABLE IF EXISTS `jnn10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnn10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jnn10000002`
--

LOCK TABLES `jnn10000002` WRITE;
/*!40000 ALTER TABLE `jnn10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `jnn10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnn10000003`
--

DROP TABLE IF EXISTS `jnn10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnn10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jnn10000003`
--

LOCK TABLES `jnn10000003` WRITE;
/*!40000 ALTER TABLE `jnn10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `jnn10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnn10000004`
--

DROP TABLE IF EXISTS `jnn10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnn10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jnn10000004`
--

LOCK TABLES `jnn10000004` WRITE;
/*!40000 ALTER TABLE `jnn10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `jnn10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnn10000005`
--

DROP TABLE IF EXISTS `jnn10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnn10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jnn10000005`
--

LOCK TABLES `jnn10000005` WRITE;
/*!40000 ALTER TABLE `jnn10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `jnn10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnn10000006`
--

DROP TABLE IF EXISTS `jnn10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnn10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jnn10000006`
--

LOCK TABLES `jnn10000006` WRITE;
/*!40000 ALTER TABLE `jnn10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `jnn10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jnn10000007`
--

DROP TABLE IF EXISTS `jnn10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jnn10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jnn10000007`
--

LOCK TABLES `jnn10000007` WRITE;
/*!40000 ALTER TABLE `jnn10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `jnn10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `o_user_list`
--

DROP TABLE IF EXISTS `o_user_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `o_user_list` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `sqid` text NOT NULL,
  `m_id` varchar(5) NOT NULL,
  `password` varchar(64) NOT NULL,
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `o_user_list`
--

LOCK TABLES `o_user_list` WRITE;
/*!40000 ALTER TABLE `o_user_list` DISABLE KEYS */;

/*!40000 ALTER TABLE `o_user_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt10000001`
--

DROP TABLE IF EXISTS `qt10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt10000001` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt10000001`
--

LOCK TABLES `qt10000001` WRITE;
/*!40000 ALTER TABLE `qt10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt10000002`
--

DROP TABLE IF EXISTS `qt10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt10000002` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt10000002`
--

LOCK TABLES `qt10000002` WRITE;
/*!40000 ALTER TABLE `qt10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt10000003`
--

DROP TABLE IF EXISTS `qt10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt10000003` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt10000003`
--

LOCK TABLES `qt10000003` WRITE;
/*!40000 ALTER TABLE `qt10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt10000004`
--

DROP TABLE IF EXISTS `qt10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt10000004` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt10000004`
--

LOCK TABLES `qt10000004` WRITE;
/*!40000 ALTER TABLE `qt10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt10000005`
--

DROP TABLE IF EXISTS `qt10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt10000005` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt10000005`
--

LOCK TABLES `qt10000005` WRITE;
/*!40000 ALTER TABLE `qt10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt10000006`
--

DROP TABLE IF EXISTS `qt10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt10000006` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt10000006`
--

LOCK TABLES `qt10000006` WRITE;
/*!40000 ALTER TABLE `qt10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt10000007`
--

DROP TABLE IF EXISTS `qt10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt10000007` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt10000007`
--

LOCK TABLES `qt10000007` WRITE;
/*!40000 ALTER TABLE `qt10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sw10000001`
--

DROP TABLE IF EXISTS `sw10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sw10000001` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sw10000001`
--

LOCK TABLES `sw10000001` WRITE;
/*!40000 ALTER TABLE `sw10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `sw10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sw10000002`
--

DROP TABLE IF EXISTS `sw10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sw10000002` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sw10000002`
--

LOCK TABLES `sw10000002` WRITE;
/*!40000 ALTER TABLE `sw10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `sw10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sw10000003`
--

DROP TABLE IF EXISTS `sw10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sw10000003` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sw10000003`
--

LOCK TABLES `sw10000003` WRITE;
/*!40000 ALTER TABLE `sw10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `sw10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sw10000004`
--

DROP TABLE IF EXISTS `sw10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sw10000004` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sw10000004`
--

LOCK TABLES `sw10000004` WRITE;
/*!40000 ALTER TABLE `sw10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `sw10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sw10000005`
--

DROP TABLE IF EXISTS `sw10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sw10000005` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sw10000005`
--

LOCK TABLES `sw10000005` WRITE;
/*!40000 ALTER TABLE `sw10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `sw10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sw10000006`
--

DROP TABLE IF EXISTS `sw10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sw10000006` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sw10000006`
--

LOCK TABLES `sw10000006` WRITE;
/*!40000 ALTER TABLE `sw10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `sw10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sw10000007`
--

DROP TABLE IF EXISTS `sw10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sw10000007` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sw10000007`
--

LOCK TABLES `sw10000007` WRITE;
/*!40000 ALTER TABLE `sw10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `sw10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tx10000001`
--

DROP TABLE IF EXISTS `tx10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx10000001` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tx10000001`
--

LOCK TABLES `tx10000001` WRITE;
/*!40000 ALTER TABLE `tx10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `tx10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tx10000002`
--

DROP TABLE IF EXISTS `tx10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx10000002` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tx10000002`
--

LOCK TABLES `tx10000002` WRITE;
/*!40000 ALTER TABLE `tx10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `tx10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tx10000003`
--

DROP TABLE IF EXISTS `tx10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx10000003` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tx10000003`
--

LOCK TABLES `tx10000003` WRITE;
/*!40000 ALTER TABLE `tx10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `tx10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tx10000004`
--

DROP TABLE IF EXISTS `tx10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx10000004` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tx10000004`
--

LOCK TABLES `tx10000004` WRITE;
/*!40000 ALTER TABLE `tx10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `tx10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tx10000005`
--

DROP TABLE IF EXISTS `tx10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx10000005` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tx10000005`
--

LOCK TABLES `tx10000005` WRITE;
/*!40000 ALTER TABLE `tx10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `tx10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tx10000006`
--

DROP TABLE IF EXISTS `tx10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx10000006` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tx10000006`
--

LOCK TABLES `tx10000006` WRITE;
/*!40000 ALTER TABLE `tx10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `tx10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tx10000007`
--

DROP TABLE IF EXISTS `tx10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx10000007` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tx10000007`
--

LOCK TABLES `tx10000007` WRITE;
/*!40000 ALTER TABLE `tx10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `tx10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp10000001`
--

DROP TABLE IF EXISTS `wp10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp10000001`
--

LOCK TABLES `wp10000001` WRITE;
/*!40000 ALTER TABLE `wp10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp10000002`
--

DROP TABLE IF EXISTS `wp10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp10000002`
--

LOCK TABLES `wp10000002` WRITE;
/*!40000 ALTER TABLE `wp10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp10000003`
--

DROP TABLE IF EXISTS `wp10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp10000003`
--

LOCK TABLES `wp10000003` WRITE;
/*!40000 ALTER TABLE `wp10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp10000004`
--

DROP TABLE IF EXISTS `wp10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp10000004`
--

LOCK TABLES `wp10000004` WRITE;
/*!40000 ALTER TABLE `wp10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp10000005`
--

DROP TABLE IF EXISTS `wp10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp10000005`
--

LOCK TABLES `wp10000005` WRITE;
/*!40000 ALTER TABLE `wp10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp10000006`
--

DROP TABLE IF EXISTS `wp10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp10000006`
--

LOCK TABLES `wp10000006` WRITE;
/*!40000 ALTER TABLE `wp10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp10000007`
--

DROP TABLE IF EXISTS `wp10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp10000007`
--

LOCK TABLES `wp10000007` WRITE;
/*!40000 ALTER TABLE `wp10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpp10000001`
--

DROP TABLE IF EXISTS `wpp10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpp10000001` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpp10000001`
--

LOCK TABLES `wpp10000001` WRITE;
/*!40000 ALTER TABLE `wpp10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `wpp10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpp10000002`
--

DROP TABLE IF EXISTS `wpp10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpp10000002` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpp10000002`
--

LOCK TABLES `wpp10000002` WRITE;
/*!40000 ALTER TABLE `wpp10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `wpp10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpp10000003`
--

DROP TABLE IF EXISTS `wpp10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpp10000003` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpp10000003`
--

LOCK TABLES `wpp10000003` WRITE;
/*!40000 ALTER TABLE `wpp10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `wpp10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpp10000004`
--

DROP TABLE IF EXISTS `wpp10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpp10000004` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpp10000004`
--

LOCK TABLES `wpp10000004` WRITE;
/*!40000 ALTER TABLE `wpp10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `wpp10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpp10000005`
--

DROP TABLE IF EXISTS `wpp10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpp10000005` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpp10000005`
--

LOCK TABLES `wpp10000005` WRITE;
/*!40000 ALTER TABLE `wpp10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `wpp10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpp10000006`
--

DROP TABLE IF EXISTS `wpp10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpp10000006` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpp10000006`
--

LOCK TABLES `wpp10000006` WRITE;
/*!40000 ALTER TABLE `wpp10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `wpp10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wpp10000007`
--

DROP TABLE IF EXISTS `wpp10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpp10000007` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wpp10000007`
--

LOCK TABLES `wpp10000007` WRITE;
/*!40000 ALTER TABLE `wpp10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `wpp10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xl10000001`
--

DROP TABLE IF EXISTS `xl10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xl10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xlid` int(11) NOT NULL DEFAULT '0' COMMENT '修炼id',
  `xldj` int(11) NOT NULL DEFAULT '0' COMMENT '修炼等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xl10000001`
--

LOCK TABLES `xl10000001` WRITE;
/*!40000 ALTER TABLE `xl10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `xl10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xl10000003`
--

DROP TABLE IF EXISTS `xl10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xl10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xlid` int(11) NOT NULL DEFAULT '0' COMMENT '修炼id',
  `xldj` int(11) NOT NULL DEFAULT '0' COMMENT '修炼等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xl10000003`
--

LOCK TABLES `xl10000003` WRITE;
/*!40000 ALTER TABLE `xl10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `xl10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xl10000004`
--

DROP TABLE IF EXISTS `xl10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xl10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xlid` int(11) NOT NULL DEFAULT '0' COMMENT '修炼id',
  `xldj` int(11) NOT NULL DEFAULT '0' COMMENT '修炼等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xl10000004`
--

LOCK TABLES `xl10000004` WRITE;
/*!40000 ALTER TABLE `xl10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `xl10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xl10000006`
--

DROP TABLE IF EXISTS `xl10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xl10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xlid` int(11) NOT NULL DEFAULT '0' COMMENT '修炼id',
  `xldj` int(11) NOT NULL DEFAULT '0' COMMENT '修炼等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xl10000006`
--

LOCK TABLES `xl10000006` WRITE;
/*!40000 ALTER TABLE `xl10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `xl10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xp10000001`
--

DROP TABLE IF EXISTS `xp10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xp10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xpid` int(11) NOT NULL DEFAULT '0' COMMENT '星盘id',
  `xpkq` int(11) NOT NULL DEFAULT '0' COMMENT '星盘开启'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xp10000001`
--

LOCK TABLES `xp10000001` WRITE;
/*!40000 ALTER TABLE `xp10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `xp10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xp10000003`
--

DROP TABLE IF EXISTS `xp10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xp10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xpid` int(11) NOT NULL DEFAULT '0' COMMENT '星盘id',
  `xpkq` int(11) NOT NULL DEFAULT '0' COMMENT '星盘开启'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xp10000003`
--

LOCK TABLES `xp10000003` WRITE;
/*!40000 ALTER TABLE `xp10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `xp10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xp10000004`
--

DROP TABLE IF EXISTS `xp10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xp10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xpid` int(11) NOT NULL DEFAULT '0' COMMENT '星盘id',
  `xpkq` int(11) NOT NULL DEFAULT '0' COMMENT '星盘开启'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xp10000004`
--

LOCK TABLES `xp10000004` WRITE;
/*!40000 ALTER TABLE `xp10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `xp10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xp10000006`
--

DROP TABLE IF EXISTS `xp10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xp10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xpid` int(11) NOT NULL DEFAULT '0' COMMENT '星盘id',
  `xpkq` int(11) NOT NULL DEFAULT '0' COMMENT '星盘开启'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xp10000006`
--

LOCK TABLES `xp10000006` WRITE;
/*!40000 ALTER TABLE `xp10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `xp10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xtbl`
--

DROP TABLE IF EXISTS `xtbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xtbl` (
  `id` int(11) NOT NULL,
  `bl1` int(11) NOT NULL,
  `bl2` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xtbl`
--

LOCK TABLES `xtbl` WRITE;
/*!40000 ALTER TABLE `xtbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `xtbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yxrw10000001`
--

DROP TABLE IF EXISTS `yxrw10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yxrw10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yxrw10000001`
--

LOCK TABLES `yxrw10000001` WRITE;
/*!40000 ALTER TABLE `yxrw10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `yxrw10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yxrw10000002`
--

DROP TABLE IF EXISTS `yxrw10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yxrw10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yxrw10000002`
--

LOCK TABLES `yxrw10000002` WRITE;
/*!40000 ALTER TABLE `yxrw10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `yxrw10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yxrw10000003`
--

DROP TABLE IF EXISTS `yxrw10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yxrw10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yxrw10000003`
--

LOCK TABLES `yxrw10000003` WRITE;
/*!40000 ALTER TABLE `yxrw10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `yxrw10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yxrw10000004`
--

DROP TABLE IF EXISTS `yxrw10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yxrw10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yxrw10000004`
--

LOCK TABLES `yxrw10000004` WRITE;
/*!40000 ALTER TABLE `yxrw10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `yxrw10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yxrw10000005`
--

DROP TABLE IF EXISTS `yxrw10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yxrw10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yxrw10000005`
--

LOCK TABLES `yxrw10000005` WRITE;
/*!40000 ALTER TABLE `yxrw10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `yxrw10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yxrw10000006`
--

DROP TABLE IF EXISTS `yxrw10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yxrw10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yxrw10000006`
--

LOCK TABLES `yxrw10000006` WRITE;
/*!40000 ALTER TABLE `yxrw10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `yxrw10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yxrw10000007`
--

DROP TABLE IF EXISTS `yxrw10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yxrw10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yxrw10000007`
--

LOCK TABLES `yxrw10000007` WRITE;
/*!40000 ALTER TABLE `yxrw10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `yxrw10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zb10000001`
--

DROP TABLE IF EXISTS `zb10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zb10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zb10000001`
--

LOCK TABLES `zb10000001` WRITE;
/*!40000 ALTER TABLE `zb10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `zb10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zb10000002`
--

DROP TABLE IF EXISTS `zb10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zb10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zb10000002`
--

LOCK TABLES `zb10000002` WRITE;
/*!40000 ALTER TABLE `zb10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `zb10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zb10000003`
--

DROP TABLE IF EXISTS `zb10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zb10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zb10000003`
--

LOCK TABLES `zb10000003` WRITE;
/*!40000 ALTER TABLE `zb10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `zb10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zb10000004`
--

DROP TABLE IF EXISTS `zb10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zb10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zb10000004`
--

LOCK TABLES `zb10000004` WRITE;
/*!40000 ALTER TABLE `zb10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `zb10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zb10000005`
--

DROP TABLE IF EXISTS `zb10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zb10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zb10000005`
--

LOCK TABLES `zb10000005` WRITE;
/*!40000 ALTER TABLE `zb10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `zb10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zb10000006`
--

DROP TABLE IF EXISTS `zb10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zb10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zb10000006`
--

LOCK TABLES `zb10000006` WRITE;
/*!40000 ALTER TABLE `zb10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `zb10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zb10000007`
--

DROP TABLE IF EXISTS `zb10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zb10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbpd` int(11) NOT NULL DEFAULT '0' COMMENT '装备佩戴'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zb10000007`
--

LOCK TABLES `zb10000007` WRITE;
/*!40000 ALTER TABLE `zb10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `zb10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbb10000001`
--

DROP TABLE IF EXISTS `zbb10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbb10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbb10000001`
--

LOCK TABLES `zbb10000001` WRITE;
/*!40000 ALTER TABLE `zbb10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `zbb10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbb10000002`
--

DROP TABLE IF EXISTS `zbb10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbb10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbb10000002`
--

LOCK TABLES `zbb10000002` WRITE;
/*!40000 ALTER TABLE `zbb10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `zbb10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbb10000003`
--

DROP TABLE IF EXISTS `zbb10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbb10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbb10000003`
--

LOCK TABLES `zbb10000003` WRITE;
/*!40000 ALTER TABLE `zbb10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `zbb10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbb10000004`
--

DROP TABLE IF EXISTS `zbb10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbb10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbb10000004`
--

LOCK TABLES `zbb10000004` WRITE;
/*!40000 ALTER TABLE `zbb10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `zbb10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbb10000005`
--

DROP TABLE IF EXISTS `zbb10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbb10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbb10000005`
--

LOCK TABLES `zbb10000005` WRITE;
/*!40000 ALTER TABLE `zbb10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `zbb10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbb10000006`
--

DROP TABLE IF EXISTS `zbb10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbb10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbb10000006`
--

LOCK TABLES `zbb10000006` WRITE;
/*!40000 ALTER TABLE `zbb10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `zbb10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbb10000007`
--

DROP TABLE IF EXISTS `zbb10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbb10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zbid` int(11) NOT NULL DEFAULT '0' COMMENT '装备ID',
  `zbxj` int(11) NOT NULL DEFAULT '0' COMMENT '装备星级',
  `zbk1` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔1',
  `zbxq1` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌1',
  `zbk2` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔2',
  `zbxq2` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌2',
  `zbk3` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔3',
  `zbxq3` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌3',
  `zbk4` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔4',
  `zbxq4` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌4',
  `zbk5` int(11) NOT NULL DEFAULT '0' COMMENT '装备孔5',
  `zbxq5` int(11) NOT NULL DEFAULT '0' COMMENT '镶嵌5',
  `zbfl` int(11) NOT NULL DEFAULT '0' COMMENT '装备分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbb10000007`
--

LOCK TABLES `zbb10000007` WRITE;
/*!40000 ALTER TABLE `zbb10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `zbb10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zf10000001`
--

DROP TABLE IF EXISTS `zf10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zf10000001` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zf10000001`
--

LOCK TABLES `zf10000001` WRITE;
/*!40000 ALTER TABLE `zf10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `zf10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zf10000002`
--

DROP TABLE IF EXISTS `zf10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zf10000002` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zf10000002`
--

LOCK TABLES `zf10000002` WRITE;
/*!40000 ALTER TABLE `zf10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `zf10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zf10000003`
--

DROP TABLE IF EXISTS `zf10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zf10000003` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zf10000003`
--

LOCK TABLES `zf10000003` WRITE;
/*!40000 ALTER TABLE `zf10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `zf10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zf10000004`
--

DROP TABLE IF EXISTS `zf10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zf10000004` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zf10000004`
--

LOCK TABLES `zf10000004` WRITE;
/*!40000 ALTER TABLE `zf10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `zf10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zf10000005`
--

DROP TABLE IF EXISTS `zf10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zf10000005` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zf10000005`
--

LOCK TABLES `zf10000005` WRITE;
/*!40000 ALTER TABLE `zf10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `zf10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zf10000006`
--

DROP TABLE IF EXISTS `zf10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zf10000006` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zf10000006`
--

LOCK TABLES `zf10000006` WRITE;
/*!40000 ALTER TABLE `zf10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `zf10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zf10000007`
--

DROP TABLE IF EXISTS `zf10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zf10000007` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zf10000007`
--

LOCK TABLES `zf10000007` WRITE;
/*!40000 ALTER TABLE `zf10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `zf10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zgvip10000003`
--

DROP TABLE IF EXISTS `zgvip10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zgvip10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zgviptime` datetime NOT NULL COMMENT '尊贵vip时间',
  `xs` int(11) NOT NULL DEFAULT '0' COMMENT '显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zgvip10000003`
--

LOCK TABLES `zgvip10000003` WRITE;
/*!40000 ALTER TABLE `zgvip10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `zgvip10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zgvip10000006`
--

DROP TABLE IF EXISTS `zgvip10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zgvip10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zgviptime` datetime NOT NULL COMMENT '尊贵vip时间',
  `xs` int(11) NOT NULL DEFAULT '0' COMMENT '显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zgvip10000006`
--

LOCK TABLES `zgvip10000006` WRITE;
/*!40000 ALTER TABLE `zgvip10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `zgvip10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zzck10000001`
--

DROP TABLE IF EXISTS `zzck10000001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zzck10000001` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zzck10000001`
--

LOCK TABLES `zzck10000001` WRITE;
/*!40000 ALTER TABLE `zzck10000001` DISABLE KEYS */;
/*!40000 ALTER TABLE `zzck10000001` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zzck10000002`
--

DROP TABLE IF EXISTS `zzck10000002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zzck10000002` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zzck10000002`
--

LOCK TABLES `zzck10000002` WRITE;
/*!40000 ALTER TABLE `zzck10000002` DISABLE KEYS */;
/*!40000 ALTER TABLE `zzck10000002` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zzck10000003`
--

DROP TABLE IF EXISTS `zzck10000003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zzck10000003` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zzck10000003`
--

LOCK TABLES `zzck10000003` WRITE;
/*!40000 ALTER TABLE `zzck10000003` DISABLE KEYS */;
/*!40000 ALTER TABLE `zzck10000003` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zzck10000004`
--

DROP TABLE IF EXISTS `zzck10000004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zzck10000004` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zzck10000004`
--

LOCK TABLES `zzck10000004` WRITE;
/*!40000 ALTER TABLE `zzck10000004` DISABLE KEYS */;
/*!40000 ALTER TABLE `zzck10000004` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zzck10000005`
--

DROP TABLE IF EXISTS `zzck10000005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zzck10000005` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zzck10000005`
--

LOCK TABLES `zzck10000005` WRITE;
/*!40000 ALTER TABLE `zzck10000005` DISABLE KEYS */;
/*!40000 ALTER TABLE `zzck10000005` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zzck10000006`
--

DROP TABLE IF EXISTS `zzck10000006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zzck10000006` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zzck10000006`
--

LOCK TABLES `zzck10000006` WRITE;
/*!40000 ALTER TABLE `zzck10000006` DISABLE KEYS */;
/*!40000 ALTER TABLE `zzck10000006` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zzck10000007`
--

DROP TABLE IF EXISTS `zzck10000007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zzck10000007` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zzck10000007`
--

LOCK TABLES `zzck10000007` WRITE;
/*!40000 ALTER TABLE `zzck10000007` DISABLE KEYS */;
/*!40000 ALTER TABLE `zzck10000007` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'xyy'
--

--
-- Dumping routines for database 'xyy'
--

--
-- Current Database: `xxjyuser`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `xxjyuser` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `xxjyuser`;

--
-- Table structure for table `gmuser`
--

DROP TABLE IF EXISTS `gmuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gmuser` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(64) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gmuser`
--

LOCK TABLES `gmuser` WRITE;
/*!40000 ALTER TABLE `gmuser` DISABLE KEYS */;
INSERT INTO `gmuser` VALUES (1,'管理员','admin','a411eb68bae78b0059a34cd6c2939df6');

/*!40000 ALTER TABLE `gmuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `o_user_list`
--

DROP TABLE IF EXISTS `o_user_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `o_user_list` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` varchar(5) NOT NULL,
  `name` text NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(64) NOT NULL,
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `ma` text NOT NULL,
  `aqm` text NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `o_user_list`
--

LOCK TABLES `o_user_list` WRITE;
/*!40000 ALTER TABLE `o_user_list` DISABLE KEYS */;

/*!40000 ALTER TABLE `o_user_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zem`
--

DROP TABLE IF EXISTS `zem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zem` (
  `id` int(11) NOT NULL,
  `zem` text NOT NULL,
  `sy` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zem`
--

LOCK TABLES `zem` WRITE;
/*!40000 ALTER TABLE `zem` DISABLE KEYS */;
/*!40000 ALTER TABLE `zem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'xxjyuser'
--

--
-- Dumping routines for database 'xxjyuser'
--

--
-- Current Database: `wuzhi_data`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wuzhi_data` /*!40100 DEFAULT CHARACTER SET gbk */;

USE `wuzhi_data`;

--
-- Table structure for table `w_servers`
--

DROP TABLE IF EXISTS `w_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `w_servers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sname` varchar(10) DEFAULT NULL,
  `url` varchar(32) DEFAULT NULL,
  `status` int(2) DEFAULT '1',
  `wzkey` varchar(120) DEFAULT NULL COMMENT '访问关键码',
  `type` int(1) DEFAULT '2' COMMENT '1、通用的2、私有的',
  `username` varchar(20) DEFAULT NULL COMMENT '如果是私有的，这个人的账号是',
  `point` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=480 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `w_servers`
--

LOCK TABLES `w_servers` WRITE;
/*!40000 ALTER TABLE `w_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `w_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `w_users`
--

DROP TABLE IF EXISTS `w_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `w_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `regtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8443 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `w_users`
--

LOCK TABLES `w_users` WRITE;
/*!40000 ALTER TABLE `w_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `w_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'wuzhi_data'
--

--
-- Dumping routines for database 'wuzhi_data'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-26  0:41:11
