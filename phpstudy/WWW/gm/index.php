<?php
require_once __DIR__ . '/lib/auth.php';
$u = gm_user();
?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#0a0a0c">
<title>幻想西游 · 管理台</title>
<link rel="icon" href="../images/favicon.ico">
<link rel="stylesheet" href="assets/gm.css">
</head>
<body data-logged="<?php echo $u ? '1' : '0'; ?>">

<div id="app" class="app" aria-busy="true">

  <!-- ============ 登录 ============ -->
  <section class="gate" id="gate" hidden>
    <div class="gate__aura" aria-hidden="true"></div>
    <form class="gate__card" id="loginForm" autocomplete="off">
      <div class="gate__mark" aria-hidden="true">
        <svg viewBox="0 0 48 48" fill="none" stroke="currentColor" stroke-width="1.5">
          <circle cx="24" cy="24" r="19" opacity=".28"/>
          <circle cx="24" cy="24" r="12" opacity=".5"/>
          <path d="M24 5v7M24 36v7M5 24h7M36 24h7" stroke-linecap="round"/>
          <circle cx="24" cy="24" r="3.5" fill="currentColor" stroke="none"/>
        </svg>
      </div>
      <h1 class="gate__title">幻想西游</h1>
      <p class="gate__sub">管理控制台</p>

      <label class="field">
        <span class="field__label">管理员账号</span>
        <input class="field__input" type="text" name="username" placeholder="请输入管理员账号" required>
      </label>
      <label class="field">
        <span class="field__label">密码</span>
        <input class="field__input" type="password" name="password" placeholder="••••••" required>
      </label>

      <button class="btn btn--primary btn--block" type="submit">
        <span>进入控制台</span>
      </button>
      <p class="gate__err" id="gateErr" role="alert"></p>
    </form>
  </section>

  <!-- ============ 主界面 ============ -->
  <div class="shell" id="shell" hidden>

    <aside class="rail">
      <div class="rail__top">
        <div class="rail__mark" aria-hidden="true">
          <svg viewBox="0 0 32 32" fill="none" stroke="currentColor" stroke-width="1.4">
            <circle cx="16" cy="16" r="12.5" opacity=".3"/>
            <circle cx="16" cy="16" r="7.5" opacity=".55"/>
            <circle cx="16" cy="16" r="2.4" fill="currentColor" stroke="none"/>
          </svg>
        </div>
        <div class="rail__id">
          <strong id="gmName">GM</strong>
          <span>在线</span>
        </div>
      </div>

      <nav class="nav" id="nav">
        <button class="nav__item is-active" data-view="overview">
          <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
            <rect x="2.5" y="2.5" width="6" height="6" rx="1.4"/>
            <rect x="11.5" y="2.5" width="6" height="6" rx="1.4"/>
            <rect x="2.5" y="11.5" width="6" height="6" rx="1.4"/>
            <rect x="11.5" y="11.5" width="6" height="6" rx="1.4"/>
          </svg>
          <span>总览</span>
        </button>
        <button class="nav__item" data-view="players">
          <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
            <circle cx="10" cy="6.6" r="3.1"/>
            <path d="M3.6 16.4c0-3.1 2.9-5 6.4-5s6.4 1.9 6.4 5" stroke-linecap="round"/>
          </svg>
          <span>玩家</span>
        </button>
        <button class="nav__item" data-view="world">
          <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
            <circle cx="10" cy="10" r="7.2"/>
            <path d="M2.8 10h14.4M10 2.8c2.1 2 3.2 4.5 3.2 7.2s-1.1 5.2-3.2 7.2c-2.1-2-3.2-4.5-3.2-7.2S7.9 4.8 10 2.8z"/>
          </svg>
          <span>世界</span>
        </button>
        <button class="nav__item" data-view="ops">
          <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
            <path d="M3 10h4l1.8-4.4 2.4 8.8L13 10h4" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <span>操作</span>
        </button>
      </nav>

      <button class="rail__out" id="logout" title="退出登录">
        <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
          <path d="M8 3.5H4.5a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1H8" stroke-linecap="round"/>
          <path d="M12.5 6.5 16 10l-3.5 3.5M16 10H7.5" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </button>
    </aside>

    <main class="stage" id="stage">

      <!-- ===== 总览 ===== -->
      <section class="view is-active" data-view="overview">
        <header class="view__head">
          <div>
            <p class="eyebrow">Overview</p>
            <h2>总览</h2>
          </div>
          <p class="view__hint">服务器实时状态</p>
        </header>

        <div class="metrics" id="metrics">
          <article class="metric metric--hero">
            <p class="metric__label">注册角色</p>
            <p class="metric__value" data-metric="players">—</p>
            <p class="metric__meta" data-metric="accounts">—</p>
          </article>
          <article class="metric">
            <p class="metric__label">今日活跃</p>
            <p class="metric__value" data-metric="activeToday">—</p>
          </article>
          <article class="metric">
            <p class="metric__label">流通银两</p>
            <p class="metric__value" data-metric="moneyTotal">—</p>
          </article>
          <article class="metric">
            <p class="metric__label">封禁</p>
            <p class="metric__value" data-metric="banned">—</p>
          </article>
        </div>

        <div class="pulse" id="pulse">
          <div class="pulse__item">
            <span class="pulse__dot"></span>
            <span class="pulse__label">服务器</span>
            <span class="pulse__val" data-pulse="server">检测中</span>
          </div>
          <div class="pulse__item">
            <span class="pulse__label">数据库</span>
            <span class="pulse__val" data-pulse="db">—</span>
          </div>
          <div class="pulse__item">
            <span class="pulse__label">存档总数</span>
            <span class="pulse__val" data-pulse="saves">—</span>
          </div>
          <div class="pulse__item">
            <span class="pulse__label">平均等级</span>
            <span class="pulse__val" data-pulse="avglv">—</span>
          </div>
        </div>

        <div class="panels">
          <article class="panel">
            <header class="panel__head">
              <h3>等级分布</h3>
            </header>
            <div class="chart" id="levelChart"></div>
          </article>
          <article class="panel">
            <header class="panel__head">
              <h3>近两周注册</h3>
            </header>
            <div class="chart chart--bars" id="regChart"></div>
          </article>
        </div>
      </section>

      <!-- ===== 玩家 ===== -->
      <section class="view" data-view="players">
        <header class="view__head">
          <div>
            <p class="eyebrow">Players</p>
            <h2>玩家管理</h2>
          </div>
          <div class="search">
            <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
              <circle cx="9" cy="9" r="5.5"/><path d="m13.2 13.2 3.3 3.3" stroke-linecap="round"/>
            </svg>
            <input id="playerSearch" type="search" placeholder="搜索昵称或玩家ID" spellcheck="false">
          </div>
        </header>

        <div class="split">
          <div class="tablewrap">
            <table class="table">
              <thead>
                <tr><th>玩家</th><th>等级</th><th class="num">银两</th><th>状态</th></tr>
              </thead>
              <tbody id="playerRows"></tbody>
            </table>
            <p class="empty" id="playerEmpty" hidden>没有匹配的玩家</p>
          </div>

          <aside class="drawer" id="drawer">
            <p class="drawer__hint">从左侧选择一名玩家</p>
          </aside>
        </div>
      </section>

      <!-- ===== 世界 ===== -->
      <section class="view" data-view="world">
        <header class="view__head">
          <div>
            <p class="eyebrow">World</p>
            <h2>世界状态</h2>
          </div>
        </header>

        <div class="panels">
          <article class="panel">
            <header class="panel__head">
              <h3>等级排行</h3>
              <button class="seg is-active" data-rank="level">等级</button>
              <button class="seg" data-rank="money">财富</button>
            </header>
            <ol class="rank" id="rankList"></ol>
          </article>
          <article class="panel">
            <header class="panel__head">
              <h3>最近登录</h3>
            </header>
            <ul class="feed" id="loginFeed"></ul>
          </article>
        </div>
      </section>

      <!-- ===== 操作 ===== -->
      <section class="view" data-view="ops">
        <header class="view__head">
          <div>
            <p class="eyebrow">Operations</p>
            <h2>系统操作</h2>
          </div>
        </header>

        <div class="panels">
          <article class="panel">
            <header class="panel__head"><h3>系统消息</h3></header>
            <p class="panel__note">
              发布后立即出现在所有玩家的游戏页面顶部，30 秒后自动过期，最多同时 5 条。
            </p>
            <form class="form" id="sysMsgForm">
              <label class="field">
                <span class="field__label">消息内容</span>
                <input class="field__input" name="text" maxlength="120"
                  placeholder="例：今晚 22:00 全服维护，请提前下线" required>
              </label>
              <div class="grid2">
                <label class="field">
                  <span class="field__label">颜色</span>
                  <select class="field__input" name="color">
                    <option value="red">红色（警示）</option>
                    <option value="blue">蓝色（常规）</option>
                    <option value="green">绿色（活动）</option>
                    <option value="black">黑色（低调）</option>
                  </select>
                </label>
                <label class="field">
                  <span class="field__label">&nbsp;</span>
                  <button class="btn btn--ghost btn--block" type="button" id="clearMsg">清空全部消息</button>
                </label>
              </div>
              <button class="btn btn--primary" type="submit">发布系统消息</button>
            </form>
          </article>

          <article class="panel">
            <header class="panel__head"><h3>官方动态</h3></header>
            <p class="panel__note">
              写入游戏内的「咨询中心」，玩家在游戏里能看到。
            </p>
            <form class="form" id="newsForm">
              <label class="field">
                <span class="field__label">标题</span>
                <input class="field__input" name="title" maxlength="30"
                  placeholder="例：感恩节活动上线" required>
              </label>
              <label class="field">
                <span class="field__label">内容</span>
                <textarea class="field__input" name="body" rows="2"
                  placeholder="活动详情…" maxlength="120"></textarea>
              </label>
              <button class="btn btn--primary" type="submit">发布动态</button>
            </form>
            <ul class="newslist" id="newsList"></ul>
          </article>

          <article class="panel">
            <header class="panel__head"><h3>系统维护</h3></header>
            <p class="panel__note">
              刷新缓存会让玩家重新从数据库载入数据，用于修复数据不同步。
            </p>
            <div class="opsgrid">
              <button class="opbtn" data-op="refreshPlayer">
                <span class="opbtn__t">刷新单个玩家</span>
                <span class="opbtn__d">按玩家ID清理其存档缓存</span>
              </button>
              <button class="opbtn" data-op="refreshPublic">
                <span class="opbtn__t">刷新公共数据</span>
                <span class="opbtn__d">清理全服公共缓存（公告/锁文件）</span>
              </button>
              <button class="opbtn" data-op="refreshRank">
                <span class="opbtn__t">重算排行榜</span>
                <span class="opbtn__d">按当前等级重新生成排行榜</span>
              </button>
            </div>
          </article>

          <article class="panel">
            <header class="panel__head"><h3>全服操作</h3></header>
            <p class="panel__note">
              对全部玩家批量执行，操作不可撤销。
            </p>
            <form class="form" id="giveAllForm">
              <div class="grid2">
                <label class="field">
                  <span class="field__label">物品</span>
                  <input class="field__input" name="wpid" placeholder="从下方物品库选择" readonly>
                </label>
                <label class="field">
                  <span class="field__label">每人数量</span>
                  <input class="field__input" name="num" type="number" value="1" min="1" max="999">
                </label>
              </div>
              <button class="btn btn--danger" type="submit">全服发放</button>
            </form>
          </article>

          <article class="panel panel--items">
            <header class="panel__head"><h3>发放物品</h3></header>

            <!-- 物品选择器 -->
            <div class="picker">
              <div class="picker__cats" id="itemCats"></div>

              <div class="picker__bar">
                <div class="search search--sm">
                  <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true">
                    <circle cx="9" cy="9" r="5.5"/><path d="m13.2 13.2 3.3 3.3" stroke-linecap="round"/>
                  </svg>
                  <input id="itemSearch" type="search" placeholder="搜索物品名称或 ID" spellcheck="false">
                </div>
                <span class="picker__count" id="itemCount"></span>
              </div>

              <div class="picker__list" id="itemList" role="listbox"></div>
            </div>

            <!-- 已选 -->
            <form class="form picker__form" id="itemForm">
              <div class="picked" id="picked">
                <p class="picked__empty">尚未选择物品</p>
              </div>
              <div class="grid2">
                <label class="field">
                  <span class="field__label">发给玩家ID</span>
                  <input class="field__input" name="wjid" placeholder="10000001" required>
                </label>
                <label class="field">
                  <span class="field__label">数量</span>
                  <input class="field__input" name="num" type="number" value="1" min="1" max="9999" required>
                </label>
              </div>
              <button class="btn btn--primary" type="submit" id="itemSubmit" disabled>请先选择物品</button>
            </form>
          </article>
        </section>

    </main>
  </div>

  <div class="toast" id="toast" role="status" aria-live="polite"></div>
</div>

<script src="assets/gm.js"></script>
</body>
</html>
