# 幻想西游 · Docker 一键端

把原本只能在 Windows + phpStudy 下跑的「幻想西游」网页游戏，改成 `docker compose up` 就能起的一体化服务。

---

## 快速开始

```bash
cd docker
./deploy.sh
```

或者手动：

```bash
cd docker
cp .env.example .env    # 按需改端口/地址
docker compose up -d --build
```

部署完成后访问 `http://<服务器IP>:8080/`

| 入口 | 地址 |
|---|---|
| 游戏首页 | `/` |
| 注册 | `/xxjy/regist.php` |
| 登录 | `/xxjy/login.php` |
| 进入游戏 | `/play.php?wjid=<玩家ID>&pass=<口令>`（登录后自动跳转） |
| GM 后台 | `/admin/login.php` |

---

## 端口冲突怎么办

默认用 8080，因为很多服务器 80 端口已被 nginx/openresty 占用。改 `.env`：

```ini
HTTP_PORT=8080
SITE_HOST=你的服务器IP或域名
SITE_PORT=8080
```

> `SITE_HOST` / `SITE_PORT` 决定游戏内「返回官网」「选区传送」这些绝对链接的地址，填错不影响玩，但跳转会连到错地方。

---

## 这端为什么需要特殊处理

原端是 2015 年前后的 PHP 5.5 + MySQL 5.5 代码，直接拿现代镜像跑会全线报错。下面每一条都是实测踩出来的：

### 1. PHP 版本被锁死在 5.6

| 依赖 | 代码中的调用量 | 后果 |
|---|---|---|
| `mysql_*` 系列函数 | 1800+ 处 | PHP 7 已移除，直接 Fatal |
| `each()` | 736 处 | PHP 7.2 移除 |
| `split()` | 47 处 | PHP 7 移除 |
| `<?` 短标签 | 1586 个文件 | 需 `short_open_tag=On` |

所以镜像用 `php:5.6.40-apache`，并且必须走 **Apache mod_php**（不是 php-fpm）——旧代码大量使用相对路径 `include`，依赖 Apache 下「CWD = 入口脚本目录」这个语义。

### 2. `bcmath` 扩展是硬需求

`fqxy/wp/funk1.php` 的 `calc()` 用 `bcadd/bcsub/bcmul/bcdiv` 做高精度运算。游戏里 1 金锭能换 99 亿银两，超过 PHP 整数安全范围，必须用 BCMath。缺了它，进游戏直接 `Call to undefined function bcmul()`。

### 3. MySQL 默认字符集必须是 utf8

原端 `my.ini` 写的是 `character-set-server=gbk`，但：
- 数据实际以 **UTF-8** 存储（`hex` 验证：`测试` = `E6B58BE8AF95`）
- 表定义是 `DEFAULT CHARSET=utf8`
- 页面声明 `charset=utf-8`

而全局连接 `sql/mysql.php` **不执行** `set names`（只有部分脚本里显式调用了 418 次 `set names utf8`）。所以服务端默认值必须是 utf8，否则默认连接读到的是乱码。

### 4. 玩家存档目录要打通

原端有两套 `.ini` 缓存，相对路径不同：

| 层 | 代码 | 实际目录 | 内容 |
|---|---|---|---|
| 登录层 | `xxjy/*.php` → `../ache/<id>` | `WWW/ache` | 只有登录令牌，每号 1 个文件 |
| 游戏层 | `fqxy/*.php` → `ache/<id>` | `WWW/fqxy/ache` | 完整存档，最多 65 个文件 |

两层互相看不见对方的数据。镜像里把 `WWW/ache` 做成指向 `WWW/fqxy/ache` 的软链接，统一成一份存储（以存档最全的游戏层为准）。

持久化卷也挂在这个真实位置：`web-data:/var/www/hxxy/fqxy/ache`。

### 5. 补全「登录成功 → 进入游戏」缺失的一环

原端登录成功后只显示「登录成功」，**没有任何通往游戏的链接**，玩家卡在这一页。而且两层的 `user.ini` 格式不兼容：

```ini
# 登录层写的（xxjy/ini/user1_ini.php）
[35博客家园玩家信息]
[验证信息]
玩家id = 10000008
玩家验证 = <md5>
玩家昵称 = admin

# 游戏层要求的（fqxy/xy.php 第 212-225 行读取）
[10000008]                    ← 段头必须是玩家 ID
[验证信息]
玩家游戏码 = <30位随机码>      ← 缺失则报 #2 验证失效
cmid值 / xcmid值 / dcmid值    ← 缺失则页面渲染半截就停
[地图坐标] / [最后页面id] / [超链接值]
```

游戏入口校验 `sid == 玩家游戏码`（`xy.php:249`），登录层从不生成这个字段。

补丁 `docker/patches/`：
- `inject_entry.php` — 给登录成功页注入【开始游戏】按钮（容器启动时执行，幂等）
- `play.php` — 校验口令 → 补齐角色 → 建分表 → 升级 ini 格式 → 跳转到游戏首页
- `user_ini_compat.php` — 格式升级 + 角色主表补齐 + 分表创建
- `player_tables.sql` — 28 种玩家分表模板

### 6. 新玩家需要预建 28 种分表

每个玩家在 `xyy` 库里有一套独立分表（`wp<id>` 背包、`zb<id>` 装备、`hd<id>` 活动…）。

部分 `*_ini.php` 会先 `SHOW TABLES` 再建表（如 `cw_ini.php`），但 `hd_ini.php` 等**直接 `select`**。新号一进游戏就是：

```
Error: Table 'xyy.hd10000010' doesn't exist
```

`play.php` 用老玩家的表结构作模板一次性补全，不逐个修补原脚本。

---

## 游戏内容

### 类型

MUD 式**文字网页游戏**（图文混排的手机/PC 通用页游）。不是回合制战斗演示，而是靠 `cmd` 序号驱动的一页一操作——每次点击服务端生成新的按钮编号，前端只是渲染。

### 规模

| 项目 | 数量 | 位置 |
|---|---|---|
| 地图 | 97 | `fqxy/map/` |
| 任务地图 | 112 | `fqxy/rwmap/` |
| NPC 交互 | 20 | `fqxy/npc/` |
| NPC 对话/交易 | 41 | `fqxy/npcc/` |
| 页面模板 | 608 | `fqxy/template/` |
| 物品定义 | 13 组 | `fqxy/wp/wpxx*.php` |
| 装备定义 | 8 组 | `fqxy/wp/zbxx*.php` |
| 数据库表 | 220 | `xyy` 库 |
| PHP 文件 | 1678 | `WWW/` |

地图按西游题材铺开：东海渔村（新手村）、傲来国、宝象国、天宫、地府、龙宫/月宫/将军府/方寸山/普陀山（门派）、雪山迷宫、大小雁塔、兵马俑阵、玄武大街、长安乐府…

### 系统

状态 / 物品 / 好友 / 任务 / 国家 / 聊天 / 宠物 / 商城 / 队伍 / 住宅 / 挂售 / 排行 / 充值 / 特权 / 福利

具体玩法：门派转职、装备打造与镶嵌（5 孔）、仓库、拍卖行、挂售、宠物捕捉与培养、副本、日常任务、活动、国家攻城、擂台 PK、排行榜。

### 经济

- 货币：银两（大额，靠 BCMath 计算）、金锭/金豆（充值货币）
- 金锭 → 银两兑换：1 金锭 = 99 亿银两
- 负重上限：随等级/装备提升（默认 500/1000/2000）

### 已知缺陷（原端自带，未修）

- 宠物技能、仓库、部分活动未实现完整
- 完成任务偶发「没有找到任务变量 XXX」，返回重试可继续
- 存在大量 SQL 拼接（注入风险）、后台弱口令。**不要直接暴露到公网玩**
- 服务器时间 23:50 之后会拒绝登录（`fqxy/aqbf.php` 的日结逻辑）

---

## 目录结构与改动分层

改动分两类，边界清楚：

- **源码改动**（`phpstudy/WWW/`）—— 与应用逻辑相关，改一次永久生效
- **部署配置**（`docker/`）—— 只跟运行环境相关，不含业务逻辑

```
phpstudy/WWW/                     ← 源码（含下列修复）
├── play.php                      进入游戏入口（新增）
├── class/user_ini_compat.php     存档格式兼容 + 建表（新增）
├── class/player_tables.sql       28 种玩家分表模板（新增）
├── img/favicon.ico               补上缺失的图标（新增）
└── ...                           23 个页面文件的引用修正

docker/                           ← 部署配置
├── deploy.sh                     一键部署（含健康检查）
├── docker-compose.yml            MySQL 5.5.62 + PHP 5.6 Apache
├── .env.example                  配置样例
├── php/
│   ├── Dockerfile                PHP 5.6 + Apache + mysql/mysqli/bcmath
│   ├── php.ini                   短标签 / 错误级别 / 时区
│   └── entrypoint.sh             注入 DB 连接与站点地址，等库就绪
├── apache/
│   └── hxxy.conf                 虚拟主机（替换官方 000-default.conf）
└── mysql-init/
    └── 01-schema.sql             三套库 225 张表
```

### 源码里改了什么

| 类型 | 量 | 说明 |
|---|---|---|
| CSS 文件名笔误 | 42 处 / 21 文件 | `ch5game.css`→`h5game.css`，`ccolorbutton.css`→`colorbutton.css` |
| favicon 扩展名 | 23 处 | 引用 `.png`，实际只有 `.ico` |
| viewport meta | 19 处 | `inital-scale`→`initial-scale`；分隔符分号→逗号 |
| 登录成功页入口 | 1 处 | 补【开始游戏】按钮 |
| 新增文件 | 3 个 | `play.php`、`class/user_ini_compat.php`、分表模板 |

这些都是原端自带的静态缺陷，与环境无关，所以直接改源码——不在启动脚本里每次扫描 2876 个文件。

## 运维

```bash
./deploy.sh status     # 状态
./deploy.sh logs       # 日志
./deploy.sh down       # 停止
./deploy.sh reset      # 清空所有数据（危险）
```

备份玩家存档：

```bash
docker run --rm -v hxxy_web-data:/d -v $(pwd):/b alpine \
  tar czf /b/players-$(date +%F).tar.gz -C /d .
```

备份数据库：

```bash
docker compose exec -T mysql mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" \
  --databases xyy xxjyuser wuzhi_data > backup-$(date +%F).sql
```

---

## 技术备注

- 基础镜像 `php:5.6.40-apache` 基于 Debian 9（已 EOL），Dockerfile 里把 apt 源指向 `archive.debian.org` 并允许未签名包，否则扩展编不出来
- 镜像不内置 GD：全站 `imagecreate/imagepng/imagettftext` 调用数均为 0
- `mysql:5.5.62` 与原端 5.5.47 同代，避免 MyISAM + 零日期（`0000-00-00`）兼容问题
- MySQL 关闭 STRICT 模式：原端数据里有 `0000-00-00 00:00:00`，开严格模式会导入失败

---

## 验收记录

在 Ubuntu 22.04 / Docker 29.8 上从零部署实测（`down -v` 清空后跑 `./deploy.sh`）：

```
✓ /                      HTTP 200
✓ /xxjy/login.php        HTTP 200
✓ /admin/login.php       HTTP 200
✓ 数据库                 225 张表
部署耗时 < 30 秒
```

全新玩家完整链路：

| 步骤 | 结果 |
|---|---|
| 注册 | 写入 `o_user_list`，ID = uid + 10000000 |
| 登录 | 生成 md5 口令，建立 `user.ini` |
| 登录成功页 | 出现【开始游戏】按钮，链接带 `wjid` + `pass` |
| play.php | 补齐 `all_zt` 角色 + 28 张分表，升级 ini 格式 |
| 进入游戏 | 渲染出「玄武大街」地图、NPC 列表、出口与功能栏 |

游戏内实测页面（新号首次进入）：

```
玄武大街
【玄武居】（仙）  【玄武居】（魔）  【巡天神将】（秘宝兑换）
龟仙人（时装兑换）  如意传送员(VIP练级区)  〖活动〗点石成金传送员
请选择出口：上 玄武大街 / 下 十字街头 / 左 长安乐府 / 右 回春药铺
```

---

## 注意事项

1. **不要直接暴露公网**：原端有大量 SQL 拼接、GM 后台弱口令（`adminroot/123456`）、任意文件读写。建议加反向代理 + 访问控制，或改掉后台口令。
2. **服务器时间 23:50 后拒绝登录**：`fqxy/aqbf.php` 的日结逻辑，属原端设计。
3. **防刷校验**：同一页面 100ms 内重复请求会提示「刷新过快」，正常游玩不受影响；脚本压测会触发。
4. **`cmd` 不能跳号**：游戏靠服务端生成的按钮序列推进，手改 URL 的 `cmd` 会提示非法刷新。

---

## GM 管理控制台

重新做了一套管理后台，替换原端那套「表格 + `<font>` 标签 + 手填 ID」的界面。

**地址**：`http://<服务器IP>:8080/gm/`
**账号**：与原 GM 后台共用 `xxjyuser.gmuser` 表（默认 `adminroot` / `123456`）

### 为什么重做

原版 GM 有两个硬伤：

1. **发物品要背 ID**。`fqxy/admin/gm05.php` 里只是把物品 ID 硬编码在提示文字里：
   ```
   〖金豆〗ID：127  【西游新人礼包】ID：491  ...
   ```
   1000 多件物品，玩家和管理员都不可能记住。

2. **功能碎在 63 个文件里**。禁言分 5 个文件（时长不同）、封号分 5 个、充值又分 8 个，每个操作都要填表提交、页面刷新。

### 做了什么

**物品按分类挑选**

从 `fqxy/wp/wpxx01~12.php` 解析出全部 **1016 件物品**，按游戏自带分类归组：

| 分类 | 数量 |
|---|---|
| 礼包福利 | 387 |
| 宝石材料 | 251 |
| 药品消耗 | 188 |
| 任务物品 | 109 |
| 宝箱 | 51 |
| 功能道具 | 30 |

点分类筛选、搜名称或 ID、点选即加入、支持多选一次发放。名称与描述直接从游戏数据提取，不用再猜 ID。

**原版 36 项功能全部迁移**

| 原版 | 现在 |
|---|---|
| 查询玩家 / 发放物品 / 发布消息 | ✅ 保留并强化 |
| 禁言（30分/2时/1天/1周/永久） | ✅ 合并为一个操作，参数化 |
| 封号（1天/1周/1月/半年）+ 解封 | ✅ 合并 |
| 刷新玩家数据 | ✅ 清理单个玩家存档缓存 |
| 刷新公共数据 | ✅ 清理 acher 公共缓存 |
| 刷新排行榜 | ✅ 按等级重算 all_phb |
| 全服发奖励 | ✅ 支持，带确认 |
| 全服物品统计 | ✅ 支持，显示持有者排行 |
| 充值/红包/兑换码/娱乐统计 | ⚠️ 依赖外部支付系统，本端未接入 |

**新增能力**（原版没有）

- VIP 等级直接设置
- 玩家存档进度可视化（页数、坐标、文件数、最近活动）
- 批量操作（多玩家改等级 / 发银两）
- 实时活跃统计（基于存档时间戳，因为 `all_ip` 表原端根本不写入）

### 数据说明

原端 `all_ip` / `all_user` 两张表在正常游玩时**不会写入**，所以「最近登录」这类功能在原版里也是空的。这里改用 `fqxy/ache/<wjid>/user.ini` 的修改时间作为活跃依据，能真实反映玩家最近玩到哪。

### 实现

```
phpstudy/WWW/gm/
├── index.php          单页界面（无框架，与 PHP 5.6 同代）
├── api.php            24 个接口，统一 JSON
├── lib/db.php         数据层 + 存档扫描
├── lib/auth.php       session 认证（独立于游戏登录态）
├── data/items.min.json 1016 件物品索引（64KB）
└── assets/{gm.css, gm.js}
```

性能：物品库预加载，切到操作页 **88ms** 出结果；搜索响应 **233ms**。

界面为暗色墨调 + 朱砂强调，7 级字号模数，移动端自动转底部标签栏。

### 原版功能迁移对照（完整）

| # | 原版功能 | 实现方式 |
|---|---|---|
| 1 | 查询玩家 | `players.search` / `players.detail` |
| 2 | 发放物品 | `items.offer` + 分类选择器 |
| 3 | **发布系统消息** | 写 `fqxy/msg/msg01~05.php`，30 秒自动过期 |
| 4 | 禁言 30分/2时/1天/1周/永久 | `players.mute` 传秒数 |
| 5 | 解除禁言 | `players.unban` |
| 6 | 封号 1天/1周/1月/半年 | `players.ban` |
| 7 | 解除封号 | `players.unban` |
| 8 | 刷新玩家数据 | 删 `fqxy/ache/<id>` 强制重载 |
| 9 | 刷新公共数据 | 清 `fqxy/acher`（实测清 231 个文件） |
| 10 | 刷新排行榜 | 重算 `all_phb`（phb1 = 等级榜） |
| 11 | GM 代码查询 | `system.codes` |
| 12 | **初始化奖池** | `truncate all_jc` + 删 `hdjc.ini` |
| 13 | 全服发奖励 | `system.giveAll`（带确认） |
| 14 | 全服某物品数量 | `system.itemCount`（实测查出 57602 个金豆） |
| 15 | 娱乐统计 | `system.serverStats` |
| 16 | 天降财神/红包统计 | 归入 `system.serverStats` |
| 17 | **官方动态** | 写 `acher/xxzx.ini` 的咨询中心 |
| 18 | 充值订单管理 | 未接入（依赖外部支付网关） |
| 19 | 红包管理 | 未接入（依赖外部支付网关） |
| 20 | 兑换码/SDK 码 | 未接入（依赖外部账号系统） |

### 关键技术细节

**系统消息为什么写文件而不是数据库**

原版 `msgg02.php` 的机制是：把消息写进 `msg01~05.php`，游戏页面 include 后显示，`filemtime` 超过设定秒数就 `unlink` 删除。这套设计没有数据库表参与，所以必须沿用文件机制才真的能显示。

**官方动态的真实位置**

`ini/xxzx_ini.php` 里写的是 `$path='../acher'`，相对 `xxjy/` 目录解析，所以文件在 **`WWW/acher/xxzx.ini`** —— 不是 `ache/`（少一个 r 就是另一个目录）。

**两处踩过的坑**

1. PHP 双引号里写 `"$msg = ..."` 会被当变量插值成空，必须用 `chr(39)` 拼接单引号
2. 正则里的 `\d` 在这套环境里会被吞成 `d`，改用 `[0-9]`
