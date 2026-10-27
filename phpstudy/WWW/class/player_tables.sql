-- ============================================================
-- 新玩家分表模板（28 种）
-- 表名中的 {{WJID}} 由 play.php 替换为玩家 ID 后执行
-- 来源：以原端已有玩家 10000006 的表结构为准
-- ============================================================

-- ckqt
CREATE TABLE `ckqt{{WJID}}` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ckwp
CREATE TABLE `ckwp{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '仓库物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ckzb
CREATE TABLE `ckzb{{WJID}}` (
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

-- cw
CREATE TABLE `cw{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `cwid` int(11) NOT NULL DEFAULT '0' COMMENT '宠物id',
  `cwmz` text NOT NULL COMMENT '宠物名字',
  `cwdj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `cwxj` int(11) NOT NULL DEFAULT '0' COMMENT '宠物星级',
  `cwby` int(11) NOT NULL DEFAULT '0' COMMENT '宠物变异',
  `cwxb` int(11) NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `cwcz` int(11) NOT NULL DEFAULT '0' COMMENT '宠物出战'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- cwzbb
CREATE TABLE `cwzbb{{WJID}}` (
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

-- dyxx
CREATE TABLE `dyxx{{WJID}}` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '丹药ID',
  `sycs` int(11) NOT NULL DEFAULT '0' COMMENT '丹药使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- fb
CREATE TABLE `fb{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `fb` datetime NOT NULL COMMENT '副本时间',
  `wc` int(11) NOT NULL DEFAULT '0' COMMENT '副本完成',
  `cs` int(11) NOT NULL DEFAULT '0' COMMENT '副本次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- gsqt
CREATE TABLE `gsqt{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售其他数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- gswp
CREATE TABLE `gswp{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品id',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '挂售物品数量',
  `gsjg` text NOT NULL COMMENT '挂售价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- gszb
CREATE TABLE `gszb{{WJID}}` (
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

-- hd
CREATE TABLE `hd{{WJID}}` (
  `hdid` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hdtime` datetime NOT NULL COMMENT '活动时间',
  `hdcs` int(11) NOT NULL DEFAULT '0' COMMENT '活动次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- hy
CREATE TABLE `hy{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `hyid` int(11) NOT NULL DEFAULT '0' COMMENT '好友id',
  `hymz` text NOT NULL COMMENT '好友名字',
  `hyfl` int(11) NOT NULL DEFAULT '0' COMMENT '好友分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- jfdj
CREATE TABLE `jfdj{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `jfdj` int(11) NOT NULL DEFAULT '0' COMMENT '解封等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- jj
CREATE TABLE `jj{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jjid` int(11) NOT NULL DEFAULT '0' COMMENT '家具ID',
  `jjdj` int(11) NOT NULL DEFAULT '0' COMMENT '家具等级',
  `jjbf` int(11) NOT NULL DEFAULT '0' COMMENT '家具摆放'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- jnn
CREATE TABLE `jnn{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `jnid` int(11) NOT NULL DEFAULT '0' COMMENT '技能id',
  `jndj` int(11) NOT NULL DEFAULT '0' COMMENT '技能等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- qt
CREATE TABLE `qt{{WJID}}` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '其他ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '其他数量'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- sw
CREATE TABLE `sw{{WJID}}` (
  `swid` int(11) NOT NULL DEFAULT '0' COMMENT '声望ID',
  `swzz` int(11) NOT NULL DEFAULT '0' COMMENT '声望值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- tx
CREATE TABLE `tx{{WJID}}` (
  `txid` int(11) NOT NULL DEFAULT '0' COMMENT '头衔ID',
  `txxs` int(11) NOT NULL DEFAULT '0' COMMENT '头衔显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- wp
CREATE TABLE `wp{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- wpp
CREATE TABLE `wpp{{WJID}}` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒',
  `wpcs` int(11) NOT NULL DEFAULT '0' COMMENT '物品使用次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- xl
CREATE TABLE `xl{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xlid` int(11) NOT NULL DEFAULT '0' COMMENT '修炼id',
  `xldj` int(11) NOT NULL DEFAULT '0' COMMENT '修炼等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- xp
CREATE TABLE `xp{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号id',
  `xpid` int(11) NOT NULL DEFAULT '0' COMMENT '星盘id',
  `xpkq` int(11) NOT NULL DEFAULT '0' COMMENT '星盘开启'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- yxrw
CREATE TABLE `yxrw{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `rwid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `rwbl` int(11) NOT NULL DEFAULT '0' COMMENT '任务变量',
  `rwmz` text NOT NULL COMMENT '任务名字',
  `yisg` int(11) NOT NULL DEFAULT '0' COMMENT '已杀怪',
  `ysg` int(11) NOT NULL DEFAULT '0' COMMENT '要杀怪',
  `rwfl` int(11) NOT NULL DEFAULT '0' COMMENT '任务分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- zb
CREATE TABLE `zb{{WJID}}` (
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

-- zbb
CREATE TABLE `zbb{{WJID}}` (
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

-- zf
CREATE TABLE `zf{{WJID}}` (
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '祝福id',
  `n` int(11) NOT NULL DEFAULT '0' COMMENT '年',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT '月',
  `r` int(11) NOT NULL DEFAULT '0' COMMENT '日',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT '时',
  `f` int(11) NOT NULL DEFAULT '0' COMMENT '分',
  `m` int(11) NOT NULL DEFAULT '0' COMMENT '秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- zgvip
CREATE TABLE `zgvip{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `zgviptime` datetime NOT NULL COMMENT '尊贵vip时间',
  `xs` int(11) NOT NULL DEFAULT '0' COMMENT '显示'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- zzck
CREATE TABLE `zzck{{WJID}}` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '编号ID',
  `wpid` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `wpsl` int(11) NOT NULL DEFAULT '0' COMMENT '物品数量',
  `wpfl` int(11) NOT NULL DEFAULT '0' COMMENT '物品分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
