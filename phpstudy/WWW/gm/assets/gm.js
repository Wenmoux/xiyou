/* ============================================================
   幻想西游 · 管理台 交互层
   ------------------------------------------------------------
   无框架依赖，保持与 PHP 5.6 后端同代的轻量实现。
   结构：api → store → render → events
   ============================================================ */
(function () {
  'use strict';

  var API = 'api.php';

  /* ---------- 小工具 ---------- */
  function $(sel, root) { return (root || document).querySelector(sel); }
  function $$(sel, root) {
    return Array.prototype.slice.call((root || document).querySelectorAll(sel));
  }

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text != null) n.textContent = text;
    return n;
  }

  var fmt = {
    num: function (v) {
      var n = Number(v) || 0;
      return n.toLocaleString('en-US');
    },
    /* 大额银两压缩显示：1.2亿 */
    money: function (v) {
      var n = Number(v) || 0;
      if (n >= 1e8) return (n / 1e8).toFixed(2).replace(/\.?0+$/, '') + '亿';
      if (n >= 1e4) return (n / 1e4).toFixed(1).replace(/\.0$/, '') + '万';
      return n.toLocaleString('en-US');
    },
    time: function (s) {
      if (!s) return '—';
      return String(s).replace(/^\d{4}-/, '').slice(0, 14);
    }
  };

  var toastTimer = null;
  function toast(msg, isErr) {
    var t = $('#toast');
    t.textContent = msg;
    t.className = 'toast is-on' + (isErr ? ' toast--err' : '');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function () {
      t.className = 'toast' + (isErr ? ' toast--err' : '');
    }, 2600);
  }

  /* ---------- 请求 ---------- */
  function api(action, data, opts) {
    opts = opts || {};
    var body = new FormData();
    body.append('action', action);
    Object.keys(data || {}).forEach(function (k) {
      body.append(k, data[k]);
    });

    // 超时保护：请求悬挂时主动断开，避免界面永远停在加载态
    var ms = opts.timeout || 20000;
    var ctl = (typeof AbortController !== 'undefined') ? new AbortController() : null;
    var timer = null;
    var timedOut = false;
    if (ctl) {
      timer = setTimeout(function () {
        timedOut = true;
        ctl.abort();
      }, ms);
    }

    return fetch(API, {
      method: 'POST',
      body: body,
      credentials: 'same-origin',
      headers: { 'X-Requested-With': 'fetch' },
      signal: ctl ? ctl.signal : undefined
    }).then(function (r) {
      if (timer) clearTimeout(timer);
      return r.json().catch(function () {
        throw new Error('返回格式异常');
      }).then(function (j) {
        if (!r.ok || j.ok === false) {
          if (j && j.needLogin) {
            // 会话失效：清掉残留状态并回到登录页，避免卡在半截界面
            showGate();
            var gErr = document.querySelector('#gateErr');
            if (gErr) gErr.textContent = '登录已过期，请重新登录';
          }
          throw new Error((j && j.error) || ('HTTP ' + r.status));
        }
        return j;
      });
    }).catch(function (ex) {
      if (timer) clearTimeout(timer);
      if (timedOut || (ex && ex.name === 'AbortError')) {
        throw new Error('请求超时，请稍后重试');
      }
      throw ex;
    });
  }

  /* 按钮忙碌态 */
  function busy(btn, on) {
    if (!btn) return;
    btn.classList.toggle('is-busy', !!on);
    btn.disabled = !!on;
  }

  /* ============================================================
     视图切换
     ============================================================ */
  var currentView = 'overview';

  function switchView(name) {
    if (name === currentView) return;
    currentView = name;

    $$('.nav__item').forEach(function (b) {
      b.classList.toggle('is-active', b.dataset.view === name);
    });
    $$('.view').forEach(function (v) {
      v.classList.toggle('is-active', v.dataset.view === name);
    });

    if (name === 'overview') loadOverview();
    if (name === 'players') loadPlayers();
    if (name === 'world') loadWorld();
    if (name === 'ops') { loadItemPicker(); loadEquipPicker(); loadNews(); loadGmAccounts(); }
  }

  /* ============================================================
     登录
     ============================================================ */
  // 这些状态在多个函数间共享，提前声明避免提升陷阱
  var booted = false;
  var playersLoaded = false;

  function showGate() {
    $('#gate').hidden = false;
    $('#shell').hidden = true;
    document.body.dataset.logged = '0';
    booted = false;   // 允许重新登录后重新绑定
    playersLoaded = false;
    var inp = $('#loginForm [name=username]');
    if (inp) setTimeout(function () { inp.focus(); }, 120);
  }

  function showShell(user) {
    $('#gate').hidden = true;
    $('#shell').hidden = false;
    document.body.dataset.logged = '1';
    if (user && user.name) $('#gmName').textContent = user.name;
    boot();
  }

  function bindLogin() {
    var form = $('#loginForm');
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      var btn = $('button[type=submit]', form);
      var err = $('#gateErr');
      err.textContent = '';
      busy(btn, true);

      api('auth.login', {
        username: form.username.value.trim(),
        password: form.password.value
      }).then(function (j) {
        busy(btn, false);
        showShell(j);
      }).catch(function (ex) {
        busy(btn, false);
        err.textContent = ex.message;
        form.password.value = '';
        form.password.focus();
      });
    });
  }

  function bindLogout() {
    $('#logout').addEventListener('click', function () {
      api('auth.logout', {}).catch(function () {}).then(showGate);
    });
  }

  /* ============================================================
     总览
     ============================================================ */
  var overviewLoaded = false;

  function loadOverview() {
    if (overviewLoaded) return;
    overviewLoaded = true;

    api('stats.overview').then(function (j) {
      setMetric('players', fmt.num(j.players));
      setMetric('accounts', fmt.num(j.accounts) + ' 个账号');
      setMetric('activeToday', fmt.num(j.activeToday));
      var actMeta = $('[data-metric="activeToday"]');
      if (actMeta && actMeta.nextElementSibling) {
        actMeta.nextElementSibling.textContent = '本周 ' + fmt.num(j.activeWeek || 0);
      }
      setMetric('moneyTotal', fmt.money(j.moneyTotal));
      setMetric('banned', fmt.num(j.banned));

      renderLevelChart(j.levelDist || []);
      renderRegChart(j.regTrend || []);
      renderPulse(j);
    }).catch(function (ex) {
      overviewLoaded = false;
      toast('统计数据加载失败：' + ex.message, true);
    });
  }

  function renderPulse(j) {
    function set(key, val) {
      var n = $('[data-pulse="' + key + '"]');
      if (n) n.textContent = val;
    }
    set('server', '运行中');
    set('db', '已连接');
    set('saves', fmt.num(j.players) + ' 份');

    // 平均等级：从分布算
    var dist = j.levelDist || [];
    var sum = 0, cnt = 0;
    dist.forEach(function (r) {
      var n = Number(r.n) || 0;
      sum += (Number(r.lv) || 0) * n;
      cnt += n;
    });
    set('avglv', cnt ? 'Lv ' + (sum / cnt).toFixed(1) : '—');
  }

  function setMetric(key, val) {
    var n = $('[data-metric="' + key + '"]');
    if (!n) return;
    // 数字滚动：从 0 到目标值
    if (/^[\d,]+$/.test(val)) {
      countUp(n, parseInt(val.replace(/,/g, ''), 10));
    } else {
      n.textContent = val;
    }
  }

  function countUp(node, target) {
    var start = 0, dur = 620, t0 = performance.now();
    function step(t) {
      var p = Math.min(1, (t - t0) / dur);
      var eased = 1 - Math.pow(1 - p, 3);
      node.textContent = Math.round(start + (target - start) * eased).toLocaleString('en-US');
      if (p < 1) requestAnimationFrame(step);
    }
    requestAnimationFrame(step);
  }

  function renderLevelChart(rows) {
    var box = $('#levelChart');
    box.innerHTML = '';
    if (!rows.length) {
      box.appendChild(el('p', 'empty', '暂无数据'));
      return;
    }

    var max = 0;
    var total = 0;
    rows.forEach(function (r) {
      var n = Number(r.n) || 0;
      max = Math.max(max, n);
      total += n;
    });

    rows.forEach(function (r, i) {
      var n = Number(r.n) || 0;
      // 最小 3% 可视宽度，避免稀疏数据出现"空条"
      var pct = max ? Math.max(3, (n / max) * 100) : 3;

      var bar = el('div', 'bar');
      bar.appendChild(el('span', 'bar__key', 'Lv ' + r.lv));

      var track = el('div', 'bar__track');
      var fill = el('div', 'bar__fill');
      fill.style.width = pct + '%';
      fill.style.animationDelay = (i * 32) + 'ms';
      track.appendChild(fill);
      bar.appendChild(track);

      // 数值 + 占比
      var share = total ? Math.round((n / total) * 100) : 0;
      var val = el('span', 'bar__val', fmt.num(n));
      val.title = share + '% 的角色在此等级';
      bar.appendChild(val);
      box.appendChild(bar);
    });
  }

  function renderRegChart(rows) {
    var box = $('#regChart');
    box.innerHTML = '';
    if (!rows.length) {
      box.appendChild(el('p', 'empty', '暂无数据'));
      return;
    }

    var max = 0;
    rows.forEach(function (r) { max = Math.max(max, Number(r.n) || 0); });

    rows.forEach(function (r, i) {
      var n = Number(r.n) || 0;
      var pct = max ? Math.max(4, (n / max) * 100) : 4;

      var col = el('div', 'col');
      var fill = el('div', 'col__fill');
      fill.style.height = pct + '%';
      fill.style.animationDelay = (i * 28) + 'ms';

      var tip = el('span', 'col__tip', String(r.d).slice(5) + ' · ' + n);
      col.appendChild(tip);
      col.appendChild(fill);
      box.appendChild(col);
    });
  }

  /* ============================================================
     玩家
     ============================================================ */
  var selectedWjid = null;
  var searchTimer = null;

  function loadPlayers(keyword) {
    var tbody = $('#playerRows');
    if (!playersLoaded) {
      tbody.innerHTML = '';
      for (var i = 0; i < 6; i++) {
        var tr = el('tr');
        var td = el('td');
        td.colSpan = 4;
        var s = el('div', 'skel skel--row');
        td.appendChild(s);
        tr.appendChild(td);
        tbody.appendChild(tr);
      }
    }

    api('players.search', { q: keyword || '', limit: 60 }).then(function (j) {
      playersLoaded = true;
      renderPlayers(j.rows || []);
    }).catch(function (ex) {
      playersLoaded = false;
      // 失败时必须清掉骨架屏，否则界面永远停在加载态
      tbody.innerHTML = '';
      var tdErr = el('td');
      tdErr.colSpan = 4;
      tdErr.appendChild(el('p', 'empty', ex.message || '加载失败'));
      var trErr = el('tr');
      trErr.appendChild(tdErr);
      tbody.appendChild(trErr);
      toast('玩家列表加载失败：' + ex.message, true);
    });
  }

  function renderPlayers(rows) {
    var tbody = $('#playerRows');
    var empty = $('#playerEmpty');
    tbody.innerHTML = '';

    if (!rows.length) {
      empty.hidden = false;
      return;
    }
    empty.hidden = true;

    rows.forEach(function (p) {
      var tr = el('tr');
      tr.dataset.wjid = p.wjid;
      if (String(p.wjid) === String(selectedWjid)) tr.classList.add('is-selected');

      // 玩家
      var td1 = el('td');
      var wrap = el('div', 'pname');
      var av = el('span', 'pname__avatar', (p.username || '?').slice(0, 1));
      var idb = el('span', 'pname__id');
      idb.appendChild(el('span', 'pname__nick', p.username || '（未命名）'));
      idb.appendChild(el('span', 'pname__wid', '#' + p.wjid));
      wrap.appendChild(av);
      wrap.appendChild(idb);
      td1.appendChild(wrap);

      // 等级
      var td2 = el('td', null, 'Lv ' + (p.dj || 1));

      // 银两
      var td3 = el('td', 'num', fmt.money(p.money));

      // 状态
      var td4 = el('td');
      if (p.banned) {
        td4.appendChild(el('span', 'pill pill--ban', '已封禁'));
      } else if (Number(p.vip) > 0) {
        td4.appendChild(el('span', 'pill pill--vip', 'VIP'));
      } else {
        td4.appendChild(el('span', 'pill pill--ok', '正常'));
      }

      tr.appendChild(td1);
      tr.appendChild(td2);
      tr.appendChild(td3);
      tr.appendChild(td4);
      tbody.appendChild(tr);
    });
  }

  /* ---------- 抽屉 ---------- */
  function openPlayer(wjid) {
    selectedWjid = wjid;
    $$('#playerRows tr').forEach(function (tr) {
      tr.classList.toggle('is-selected', String(tr.dataset.wjid) === String(wjid));
    });

    var d = $('#drawer');
    d.innerHTML = '';
    for (var i = 0; i < 5; i++) {
      d.appendChild(el('div', 'skel skel--row'));
    }

    api('players.detail', { wjid: wjid }).then(function (j) {
      renderDrawer(j);
    }).catch(function (ex) {
      d.innerHTML = '';
      d.appendChild(el('p', 'drawer__hint', ex.message));
    });
  }

  function renderDrawer(j) {
    var p = j.player || {};
    var d = $('#drawer');
    d.innerHTML = '';

    // 头部
    var head = el('div', 'drawer__head');
    head.appendChild(el('span', 'drawer__avatar', (p.username || '?').slice(0, 1)));
    var meta = el('div', 'drawer__meta');
    meta.appendChild(el('strong', null, p.username || '（未命名）'));
    meta.appendChild(el('span', null, '#' + p.wjid));
    head.appendChild(meta);
    d.appendChild(head);

    // 档案
    var dl = el('dl', 'kv');
    function kv(k, v) {
      dl.appendChild(el('dt', null, k));
      dl.appendChild(el('dd', null, v == null || v === '' ? '—' : String(v)));
    }
    kv('等级', 'Lv ' + (p.dj || 1));
    kv('银两', fmt.money(j.money));
    kv('性别', String(p.sex) === '1' ? '男' : (String(p.sex) === '2' ? '女' : '未设置'));
    kv('VIP', Number(p.vip) > 0 ? ('Lv ' + p.vip) : '否');
    kv('负重', (p.gsrl || 0) + ' / ' + (p.bbrl || 0) + ' / ' + (p.ckrl || 0));
    kv('背包', (j.bagCount || 0) + ' 格');
    kv('账号', j.account ? (j.account.username || '—') : '—');

    // 存档进度（真实游玩痕迹）
    var sv = j.save || {};
    if (sv.exists) {
      kv('存档', sv.files + ' 个文件 / ' + (sv.size ? Math.round(sv.size / 1024) + 'KB' : '—'));
      kv('当前页面', '#' + sv.page);
      kv('坐标', sv.map);
      kv('最近活动', sv.mtime);
      if (sv.muted) kv('禁言', '是');
    } else {
      kv('存档', '尚未进入游戏');
    }
    if (j.banned) kv('封禁原因', j.banReason || '—');
    d.appendChild(dl);

    // 装备列表（可删除）
    var eqs = j.equips || [];
    if (eqs.length) {
      var eqBox = el('div', 'eqbox');
      var eqHead = el('div', 'eqbox__head');
      eqHead.appendChild(el('span', 'eqbox__t', '装备 ' + eqs.length + ' 件'));
      eqBox.appendChild(eqHead);

      var eqUl = el('ul', 'eqlist');
      eqs.forEach(function (q) {
        var li = el('li');

        var nm = el('span', 'eqlist__n');
        nm.appendChild(document.createTextNode(q.name));
        var tag = el('span', 'eqlist__id', '#' + q.zbid);
        nm.appendChild(tag);
        if (q.star > 0) nm.appendChild(el('span', 'eqlist__star', '★' + q.star));
        if (q.equipped) nm.appendChild(el('span', 'eqlist__on', '佩戴中'));
        li.appendChild(nm);

        var meta = el('span', 'eqlist__meta');
        if (q.atk) meta.appendChild(el('span', null, '攻' + q.atk));
        if (q.def) meta.appendChild(el('span', null, '防' + q.def));
        meta.appendChild(el('span', null, 'Lv' + q.lv));
        li.appendChild(meta);

        var del = el('button', 'iconbtn iconbtn--danger', '×');
        del.type = 'button';
        del.title = '删除这件装备';
        del.addEventListener('click', function () {
          if (!confirm('删除「' + q.name + '」#' + q.zbid + '？')) return;
          api('equips.remove', { wjid: p.wjid, id: q.id }).then(function () {
            toast('已删除');
            openPlayer(p.wjid);
          }).catch(function (ex) { toast(ex.message, true); });
        });
        li.appendChild(del);

        eqUl.appendChild(li);
      });
      eqBox.appendChild(eqUl);
      d.appendChild(eqBox);
    } else {
      var hint = el('p', 'eqbox__empty', '暂无装备');
      d.appendChild(hint);
    }

    // 操作按钮
    var acts = el('div', 'drawer__actions');

    var bBan = el('button', 'btn btn--sm ' + (j.banned ? 'btn--ghost' : 'btn--danger'),
      j.banned ? '解除封禁' : '封禁');
    bBan.addEventListener('click', function () {
      busy(bBan, true);
      var req = j.banned
        ? api('players.unban', { wjid: p.wjid })
        : api('players.ban', { wjid: p.wjid, reason: '违反游戏规则' });

      req.then(function () {
        busy(bBan, false);
        toast(j.banned ? '已解除封禁' : '已封禁该玩家');
        openPlayer(p.wjid);
        loadPlayers($('#playerSearch').value.trim());
      }).catch(function (ex) {
        busy(bBan, false);
        toast(ex.message, true);
      });
    });
    acts.appendChild(bBan);

    var bMute = el('button', 'btn btn--sm btn--ghost', '禁言 1 小时');
    bMute.addEventListener('click', function () {
      busy(bMute, true);
      api('players.mute', { wjid: p.wjid, seconds: 3600 }).then(function () {
        busy(bMute, false);
        toast('已禁言 1 小时');
      }).catch(function (ex) {
        busy(bMute, false);
        toast(ex.message, true);
      });
    });
    acts.appendChild(bMute);
    d.appendChild(acts);

    // 快捷修改
    var form = el('form', 'drawer__form');

    var f1 = el('label', 'field');
    f1.appendChild(el('span', 'field__label', '改名'));
    var i1 = el('input', 'field__input');
    i1.name = 'name';
    i1.value = p.username || '';
    i1.maxLength = 12;
    f1.appendChild(i1);
    form.appendChild(f1);

    var g2 = el('div', 'grid2');

    var f2 = el('label', 'field');
    f2.appendChild(el('span', 'field__label', '等级'));
    var i2 = el('input', 'field__input');
    i2.name = 'level';
    i2.type = 'number';
    i2.min = 1;
    i2.max = 999;
    i2.value = p.dj || 1;
    f2.appendChild(i2);
    g2.appendChild(f2);

    var f3 = el('label', 'field');
    f3.appendChild(el('span', 'field__label', '银两'));
    var i3 = el('input', 'field__input');
    i3.name = 'money';
    i3.type = 'number';
    i3.min = 0;
    i3.value = Math.round(Number(j.money) || 0);
    f3.appendChild(i3);
    g2.appendChild(f3);

    form.appendChild(g2);

    var save = el('button', 'btn btn--primary btn--sm btn--block', '保存修改');
    save.type = 'submit';
    form.appendChild(save);

    form.addEventListener('submit', function (e) {
      e.preventDefault();
      busy(save, true);

      var tasks = [];
      if (i1.value.trim() && i1.value.trim() !== (p.username || '')) {
        tasks.push(api('players.rename', { wjid: p.wjid, name: i1.value.trim() }));
      }
      if (Number(i2.value) !== Number(p.dj)) {
        tasks.push(api('players.setLevel', { wjid: p.wjid, level: Number(i2.value) }));
      }
      if (Number(i3.value) !== Number(j.money)) {
        tasks.push(api('players.setMoney', { wjid: p.wjid, money: Number(i3.value) }));
      }

      if (!tasks.length) {
        busy(save, false);
        toast('没有改动');
        return;
      }

      Promise.all(tasks).then(function () {
        busy(save, false);
        toast('已保存');
        openPlayer(p.wjid);
        loadPlayers($('#playerSearch').value.trim());
      }).catch(function (ex) {
        busy(save, false);
        toast(ex.message, true);
      });
    });

    d.appendChild(form);
  }

  /* ============================================================
     世界
     ============================================================ */
  var worldLoaded = false;
  var rankBy = 'level';

  function loadWorld() {
    if (!worldLoaded) {
      worldLoaded = true;
      loadRank();
      loadLogins();
    }
  }

  function loadRank() {
    var box = $('#rankList');
    box.innerHTML = '';
    for (var i = 0; i < 6; i++) {
      var li = el('li');
      li.appendChild(el('span', 'skel skel--row'));
      box.appendChild(li);
    }

    api('world.rank', { by: rankBy }).then(function (j) {
      box.innerHTML = '';
      var rows = j.rows || [];
      if (!rows.length) {
        box.appendChild(el('li', 'empty', '暂无数据'));
        return;
      }
      rows.forEach(function (r) {
        var li = el('li');
        li.appendChild(el('span', 'rank__name', r.name || '（未命名）'));
        li.appendChild(el('span', 'rank__score',
          rankBy === 'money' ? fmt.money(r.score) : ('Lv ' + r.score)));
        box.appendChild(li);
      });
    }).catch(function (ex) {
      box.innerHTML = '';
      box.appendChild(el('li', 'empty', ex.message));
    });
  }

  function loadLogins() {
    var box = $('#loginFeed');
    box.innerHTML = '';

    api('world.logins').then(function (j) {
      box.innerHTML = '';
      var rows = j.rows || [];
      if (!rows.length) {
        box.appendChild(el('li', 'empty', '暂无记录'));
        return;
      }
      rows.forEach(function (r) {
        var li = el('li');
        li.appendChild(el('span', 'feed__who', r.wjname || ('#' + r.wjid)));
        li.appendChild(el('span', 'feed__time', fmt.time(r.iptime)));
        li.appendChild(el('span', 'feed__ip', r.ip || '—'));
        box.appendChild(li);
      });
    }).catch(function (ex) {
      box.innerHTML = '';
      box.appendChild(el('li', 'empty', ex.message));
    });
  }

  /* ============================================================
     操作
     ============================================================ */

  /* ============================================================
     系统维护与全服操作
     ============================================================ */
  function bindSystemOps() {
    // 维护按钮
    $$('.opbtn').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var op = btn.dataset.op;

        if (op === 'refreshPlayer') {
          var wid = prompt('要刷新哪个玩家？输入玩家ID（如 10000001）');
          if (!wid) return;
          if (!/^\d{8,}$/.test(wid.trim())) { toast('玩家ID格式不对', true); return; }

          btn.classList.add('is-busy');
          api('system.refreshPlayer', { wjid: wid.trim() }).then(function (j) {
            btn.classList.remove('is-busy');
            toast('已清理 ' + j.removed + ' 个缓存文件');
          }).catch(function (ex) {
            btn.classList.remove('is-busy');
            toast(ex.message, true);
          });
          return;
        }

        if (op === 'refreshPublic') {
          if (!confirm('清理全服公共缓存？玩家需重新进入游戏。')) return;
          btn.classList.add('is-busy');
          api('system.refreshPublic').then(function (j) {
            btn.classList.remove('is-busy');
            toast('已清理 ' + j.removed + ' 个公共缓存文件');
          }).catch(function (ex) {
            btn.classList.remove('is-busy');
            toast(ex.message, true);
          });
          return;
        }

        if (op === 'refreshRank') {
          btn.classList.add('is-busy');
          api('system.refreshRank').then(function (j) {
            btn.classList.remove('is-busy');
            toast('排行榜已重算，共 ' + j.updated + ' 名玩家');
          }).catch(function (ex) {
            btn.classList.remove('is-busy');
            toast(ex.message, true);
          });
        }
      });
    });

    // 全服发放
    var f = $('#giveAllForm');
    if (f) {
      f.addEventListener('submit', function (e) {
        e.preventDefault();
        var wp = f.wpid.value.trim();
        if (!wp) { toast('请先从物品库选择物品', true); return; }

        if (!confirm('确定向全服所有玩家各发放 ' + f.num.value + ' 个该物品？')) return;

        var btn = $('button[type=submit]', f);
        busy(btn, true);
        api('system.giveAll', { wpid: wp, num: f.num.value }).then(function (j) {
          busy(btn, false);
          toast('已发放：' + j.sent + ' 人成功' +
                (j.skipped ? '，' + j.skipped + ' 人跳过' : ''));
        }).catch(function (ex) {
          busy(btn, false);
          toast(ex.message, true);
        });
      });

      // 点击只读输入 → 回到物品库挑选
      f.wpid.addEventListener('click', function () {
        var picker = $('.panel--items');
        if (picker) picker.scrollIntoView({ behavior: 'smooth', block: 'center' });
        toast('在下方物品库点选物品，再回来发放');
      });
    }
  }

  /* 选中物品时同步到全服发放输入框 */
  function syncGiveAllField() {
    var inp = $('#giveAllForm [name=wpid]');
    if (!inp) return;
    if (picked.length === 1) {
      inp.value = picked[0].id;
    } else if (picked.length > 1) {
      inp.value = '';
      inp.placeholder = '全服发放只能选 1 种物品';
    } else {
      inp.value = '';
      inp.placeholder = '从下方物品库选择';
    }
  }

  /* ============================================================
     系统消息与官方动态
     ============================================================ */
  function bindMessages() {
    // 系统消息
    var sf = $('#sysMsgForm');
    if (sf) {
      sf.addEventListener('submit', function (e) {
        e.preventDefault();
        var btn = $('button[type=submit]', sf);
        var text = sf.text.value.trim();
        if (!text) return;

        busy(btn, true);
        api('messages.system', { text: text, color: sf.color.value }).then(function (j) {
          busy(btn, false);
          sf.text.value = '';
          toast('已发布到第 ' + j.slot + ' 条，游戏内立即可见');
        }).catch(function (ex) {
          busy(btn, false);
          toast(ex.message, true);
        });
      });

      var cb = $('#clearMsg');
      if (cb) {
        cb.addEventListener('click', function () {
          busy(cb, true);
          api('messages.clear').then(function (j) {
            busy(cb, false);
            toast('已清空 ' + j.cleared + ' 条消息');
          }).catch(function (ex) {
            busy(cb, false);
            toast(ex.message, true);
          });
        });
      }
    }

    // 官方动态
    var nf = $('#newsForm');
    if (nf) {
      nf.addEventListener('submit', function (e) {
        e.preventDefault();
        var btn = $('button[type=submit]', nf);
        var title = nf.title.value.trim();
        if (!title) return;

        busy(btn, true);
        api('news.publish', { title: title, body: nf.body.value.trim() }).then(function () {
          busy(btn, false);
          nf.reset();
          toast('动态已发布到游戏内');
          loadNews();
        }).catch(function (ex) {
          busy(btn, false);
          toast(ex.message, true);
        });
      });
    }
  }

  function loadNews() {
    var box = $('#newsList');
    if (!box) return;

    api('news.list').then(function (j) {
      box.innerHTML = '';
      var rows = j.rows || [];
      if (!rows.length) {
        box.innerHTML = '<li><span></span><span class="newslist__t" style="color:var(--ink-500)">暂无动态</span></li>';
        return;
      }
      rows.reverse().slice(0, 20).forEach(function (r) {
        var li = el('li');
        li.appendChild(el('span', 'newslist__id', '#' + r.id));
        li.appendChild(el('span', 'newslist__t', r.title));
        box.appendChild(li);
      });
    }).catch(function () {});
  }

  /* ============================================================
     装备选择器
     ============================================================ */
  var EQUIPS = null;
  var equipCat = 0;
  var equipKw = '';
  var equipShown = 0;
  var equipPicked = [];

  var EQ_CATS = {
    1: '枪', 2: '刀', 3: '枪', 4: '剑', 5: '斧', 6: '锤',
    7: '鞭', 8: '扇', 9: '头盔', 10: '衣服', 11: '鞋子',
    12: '项链', 13: '戒指', 14: '手镯', 15: '腰带',
    16: '披风', 17: '护腕', 18: '面饰', 19: '法宝', 20: '饰品', 21: '其他'
  };

  function loadEquips() {
    if (EQUIPS) return Promise.resolve(EQUIPS);
    return fetch('data/equips.min.json', { credentials: 'same-origin' })
      .then(function (r) { return r.json(); })
      .then(function (list) { EQUIPS = list; return EQUIPS; });
  }

  function equipFiltered() {
    if (!EQUIPS) return [];
    var kw = equipKw.toLowerCase();
    return EQUIPS.filter(function (e) {
      if (equipCat && e.cat !== equipCat) return false;
      if (!kw) return true;
      return String(e.i) === kw || e.n.toLowerCase().indexOf(kw) >= 0;
    });
  }

  function renderEquipCats() {
    var box = $('#equipCats');
    if (!box || !EQUIPS) return;
    box.innerHTML = '';

    var counts = {};
    EQUIPS.forEach(function (e) { counts[e.cat] = (counts[e.cat] || 0) + 1; });

    function mk(id, label, n) {
      var b = el('button', 'cat' + (equipCat === id ? ' is-active' : ''));
      b.type = 'button';
      b.appendChild(document.createTextNode(label));
      b.appendChild(el('span', 'cat__n', String(n)));
      b.addEventListener('click', function () {
        equipCat = id;
        renderEquipCats();
        renderEquips(true);
      });
      box.appendChild(b);
    }

    mk(0, '全部', EQUIPS.length);
    Object.keys(counts).sort(function (a, b) { return a - b; }).forEach(function (c) {
      var k = parseInt(c, 10);
      mk(k, EQ_CATS[k] || ('类型' + k), counts[c]);
    });
  }

  function renderEquips(reset) {
    var box = $('#equipList');
    if (!box) return;
    if (reset) { box.innerHTML = ''; equipShown = 0; }

    var list = equipFiltered();
    var cnt = $('#equipCount');
    if (cnt) cnt.textContent = list.length + ' 件';

    if (!list.length) {
      box.innerHTML = '<p class="empty" style="padding:32px 12px">没有匹配的装备</p>';
      return;
    }

    var slice = list.slice(equipShown, equipShown + 80);

    slice.forEach(function (e) {
      var on = equipPicked.some(function (p) { return p.i === e.i; });
      var row = el('div', 'item' + (on ? ' is-on' : ''));
      row.dataset.id = e.i;

      row.appendChild(el('span', 'item__id', String(e.i)));

      var main = el('div', 'item__main');
      main.appendChild(el('span', 'item__name', e.n));

      var st = el('span', 'item__stat');
      if (e.atk) st.appendChild(el('span', 's-atk', '攻 ' + e.atk));
      if (e.def) st.appendChild(el('span', 's-def', '防 ' + e.def));
      if (e.hp)  st.appendChild(el('span', 's-hp', '血 ' + e.hp));
      main.appendChild(st);
      row.appendChild(main);

      row.appendChild(el('span', 'item__tag', 'Lv' + e.lv));

      row.addEventListener('click', function () { toggleEquip(e); });
      box.appendChild(row);
    });

    equipShown += slice.length;

    if (equipShown < list.length) {
      var more = el('div', 'picker__more', '显示更多（还有 ' + (list.length - equipShown) + ' 件）');
      more.addEventListener('click', function () { more.remove(); renderEquips(false); });
      box.appendChild(more);
    }
  }

  function toggleEquip(e) {
    var i = -1;
    for (var k = 0; k < equipPicked.length; k++) {
      if (equipPicked[k].i === e.i) { i = k; break; }
    }
    if (i >= 0) equipPicked.splice(i, 1);
    else equipPicked.push({ i: e.i, n: e.n });

    renderEquipPicked();
    var row = $('#equipList .item[data-id="' + e.i + '"]');
    if (row) {
      row.classList.toggle('is-on',
        equipPicked.some(function (p) { return p.i === e.i; }));
    }
    syncEquipSubmit();
  }

  function syncEquipSubmit() {
    var btn = $('#equipSubmit');
    if (!btn) return;
    btn.disabled = equipPicked.length === 0;
    btn.textContent = equipPicked.length
      ? ('发放 ' + equipPicked.length + ' 件装备')
      : '请先选择装备';
  }

  function renderEquipPicked() {
    var box = $('#equipPicked');
    if (!box) return;
    box.innerHTML = '';

    if (!equipPicked.length) {
      box.appendChild(el('p', 'picked__empty', '尚未选择装备'));
      return;
    }

    equipPicked.forEach(function (p, idx) {
      var chip = el('span', 'chip');
      chip.appendChild(document.createTextNode(p.n));
      chip.appendChild(el('span', 'chip__id', '#' + p.i));

      var x = el('button', 'chip__x', '×');
      x.type = 'button';
      x.addEventListener('click', function () {
        equipPicked.splice(idx, 1);
        renderEquipPicked();
        var row = $('#equipList .item[data-id="' + p.i + '"]');
        if (row) row.classList.remove('is-on');
        syncEquipSubmit();
      });
      chip.appendChild(x);
      box.appendChild(chip);
    });
  }

  function loadEquipPicker() {
    if (EQUIPS) {
      if (!$('#equipList').children.length) {
        renderEquipCats();
        renderEquips(true);
        renderEquipPicked();
        syncEquipSubmit();
      }
      return;
    }
    loadEquips().then(function () {
      renderEquipCats();
      renderEquips(true);
      renderEquipPicked();
      syncEquipSubmit();
    }).catch(function (ex) {
      toast('装备库加载失败：' + ex.message, true);
    });
  }

  function bindEquipPicker() {
    var search = $('#equipSearch');
    var timer = null;
    if (search) {
      search.addEventListener('input', function () {
        clearTimeout(timer);
        timer = setTimeout(function () {
          equipKw = search.value.trim();
          renderEquips(true);
        }, 180);
      });
    }

    var form = $('#equipForm');
    if (form) {
      form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (!equipPicked.length) return;

        var btn = $('#equipSubmit');
        var wjid = form.wjid.value.trim();
        var star = form.star.value || 0;
        if (!/^\d{8,}$/.test(wjid)) {
          toast('请输入正确的玩家ID', true);
          return;
        }

        busy(btn, true);

        var seq = Promise.resolve();
        equipPicked.slice().forEach(function (p) {
          seq = seq.then(function () {
            return api('equips.offer', { wjid: wjid, zbid: p.i, star: star });
          });
        });

        seq.then(function () {
          busy(btn, false);
          toast('已发放 ' + equipPicked.length + ' 件装备');
          equipPicked = [];
          renderEquipPicked();
          $$('#equipList .item').forEach(function (r) {
            r.classList.remove('is-on');
          });
          syncEquipSubmit();
        }).catch(function (ex) {
          busy(btn, false);
          toast(ex.message, true);
        });
      });
    }
  }

  /* ============================================================
     GM 账号管理
     ============================================================ */
  function loadGmAccounts() {
    var box = $('#gmList');
    if (!box) return;

    api('gm.list').then(function (j) {
      box.innerHTML = '';
      var rows = j.rows || [];
      if (!rows.length) {
        var li0 = el('li');
        li0.appendChild(el('span', 'gmlist__who', '暂无账号'));
        box.appendChild(li0);
        return;
      }

      var meName = $('#gmName') ? $('#gmName').textContent.trim() : '';

      rows.forEach(function (r) {
        var li = el('li');

        var who = el('span', 'gmlist__who');
        who.appendChild(el('span', 'gmlist__name', r.name || r.username));
        who.appendChild(el('span', 'gmlist__user', r.username));
        if (r.name === meName) {
          who.appendChild(el('span', 'gmlist__me', '当前'));
        }
        li.appendChild(who);

        var ops = el('span', 'gmlist__ops');

        var bPwd = el('button', 'iconbtn', '🔑');
        bPwd.type = 'button';
        bPwd.title = '重置密码';
        bPwd.addEventListener('click', function () {
          var np = prompt('为「' + r.username + '」设置新密码（至少 6 位）');
          if (np === null) return;
          if (np.length < 6) { toast('密码至少 6 位', true); return; }
          api('gm.resetPassword', { username: r.username, password: np })
            .then(function () { toast('密码已更新'); })
            .catch(function (ex) { toast(ex.message, true); });
        });
        ops.appendChild(bPwd);

        var bDel = el('button', 'iconbtn iconbtn--danger', '×');
        bDel.type = 'button';
        bDel.title = '删除账号';
        bDel.addEventListener('click', function () {
          if (!confirm('删除 GM 账号「' + r.username + '」？')) return;
          api('gm.delete', { username: r.username })
            .then(function () { toast('已删除'); loadGmAccounts(); })
            .catch(function (ex) { toast(ex.message, true); });
        });
        ops.appendChild(bDel);

        li.appendChild(ops);
        box.appendChild(li);
      });
    }).catch(function () {});
  }

  function bindGmAccounts() {
    var form = $('#gmForm');
    if (form) {
      form.addEventListener('submit', function (e) {
        e.preventDefault();
        var btn = $('button[type=submit]', form);
        busy(btn, true);

        api('gm.create', {
          username: form.username.value.trim(),
          name: form.name.value.trim(),
          password: form.password.value
        }).then(function () {
          busy(btn, false);
          form.reset();
          toast('GM 账号已创建');
          loadGmAccounts();
        }).catch(function (ex) {
          busy(btn, false);
          toast(ex.message, true);
        });
      });
    }

    var sync = $('#gmSync');
    if (sync) {
      sync.addEventListener('click', function () {
        busy(sync, true);
        api('gm.syncIni').then(function (j) {
          busy(sync, false);
          toast('已清理 ' + j.cleared + ' 个登录缓存');
        }).catch(function (ex) {
          busy(sync, false);
          toast(ex.message, true);
        });
      });
    }
  }

  /* ============================================================
     物品选择器
     ------------------------------------------------------------
     1016 件物品，一次只渲染 80 条，滚动时增量加载，
     保证打开面板和切分类都不卡。
     ============================================================ */
  var ITEMS = null;
  var itemCat = 0;
  var itemKw = '';
  var itemShown = 0;
  var picked = [];
  var PAGE = 80;

  var CAT_NAMES = { 1: '功能道具', 2: '宝石材料', 4: '礼包福利', 5: '药品消耗', 6: '任务物品', 8: '宝箱' };

  function loadItems() {
    if (ITEMS) return Promise.resolve(ITEMS);
    return fetch('data/items.min.json', { credentials: 'same-origin' })
      .then(function (r) { return r.json(); })
      .then(function (list) { ITEMS = list; return ITEMS; });
  }

  function itemFiltered() {
    if (!ITEMS) return [];
    var kw = itemKw.toLowerCase();
    return ITEMS.filter(function (it) {
      if (itemCat && it.c !== itemCat) return false;
      if (!kw) return true;
      return String(it.i) === kw
          || it.n.toLowerCase().indexOf(kw) >= 0
          || (it.d || '').toLowerCase().indexOf(kw) >= 0;
    });
  }

  function renderCats() {
    var box = $('#itemCats');
    if (!box || !ITEMS) return;
    box.innerHTML = '';

    var counts = {};
    ITEMS.forEach(function (it) { counts[it.c] = (counts[it.c] || 0) + 1; });

    function mkCat(id, label, n) {
      var b = el('button', 'cat' + (itemCat === id ? ' is-active' : ''));
      b.type = 'button';
      b.appendChild(document.createTextNode(label));
      b.appendChild(el('span', 'cat__n', String(n)));
      b.addEventListener('click', function () {
        itemCat = id;
        renderCats();
        renderItems(true);
      });
      box.appendChild(b);
    }

    mkCat(0, '全部', ITEMS.length);
    Object.keys(counts).sort().forEach(function (cat) {
      var c = parseInt(cat, 10);
      mkCat(c, CAT_NAMES[c] || ('分类' + c), counts[cat]);
    });
  }

  function renderItems(reset) {
    var box = $('#itemList');
    if (!box) return;
    if (reset) { box.innerHTML = ''; itemShown = 0; }

    var list = itemFiltered();
    var cnt = $('#itemCount');
    if (cnt) cnt.textContent = list.length + ' 件';

    if (!list.length) {
      box.innerHTML = '<p class="empty" style="padding:32px 12px">没有匹配的物品</p>';
      return;
    }

    var slice = list.slice(itemShown, itemShown + PAGE);

    slice.forEach(function (it) {
      var row = el('div', 'item' + (isPicked(it.i) ? ' is-on' : ''));
      row.dataset.id = it.i;
      row.setAttribute('role', 'option');

      row.appendChild(el('span', 'item__id', String(it.i)));

      var main = el('div', 'item__main');
      main.appendChild(el('span', 'item__name', it.n));
      if (it.d) main.appendChild(el('span', 'item__desc', it.d));
      row.appendChild(main);

      row.appendChild(el('span',
        'item__tag' + (it.b === 0 ? ' item__tag--bound' : ''),
        it.b === 0 ? '绑定' : '可交易'));

      row.addEventListener('click', function () { togglePick(it); });
      box.appendChild(row);
    });

    itemShown += slice.length;

    if (itemShown < list.length) {
      var more = el('div', 'picker__more', '显示更多（还有 ' + (list.length - itemShown) + ' 件）');
      more.addEventListener('click', function () {
        more.remove();
        renderItems(false);
      });
      box.appendChild(more);
    }
  }

  function isPicked(id) {
    return picked.some(function (p) { return p.id === id; });
  }

  function syncSubmit() {
    var btn = $('#itemSubmit');
    if (!btn) return;
    btn.disabled = picked.length === 0;
    btn.textContent = picked.length ? ('发放 ' + picked.length + ' 种物品') : '请先选择物品';
  }

  function togglePick(it) {
    var i = -1;
    for (var k = 0; k < picked.length; k++) {
      if (picked[k].id === it.i) { i = k; break; }
    }
    if (i >= 0) picked.splice(i, 1);
    else picked.push({ id: it.i, name: it.n });

    renderPicked();

    var row = $('#itemList .item[data-id="' + it.i + '"]');
    if (row) row.classList.toggle('is-on', isPicked(it.i));

    syncSubmit();
    syncGiveAllField();
  }

  function renderPicked() {
    var box = $('#picked');
    if (!box) return;
    box.innerHTML = '';

    if (!picked.length) {
      box.appendChild(el('p', 'picked__empty', '尚未选择物品'));
      return;
    }

    picked.forEach(function (p, idx) {
      var chip = el('span', 'chip');
      chip.appendChild(document.createTextNode(p.name));
      chip.appendChild(el('span', 'chip__id', '#' + p.id));

      var x = el('button', 'chip__x', '×');
      x.type = 'button';
      x.setAttribute('aria-label', '移除 ' + p.name);
      x.addEventListener('click', function () {
        var id = p.id;
        picked.splice(idx, 1);
        renderPicked();
        var row = $('#itemList .item[data-id="' + id + '"]');
        if (row) row.classList.remove('is-on');
        syncSubmit();
      });
      chip.appendChild(x);
      box.appendChild(chip);
    });
  }

  function loadItemPicker() {
    if (ITEMS) {
      // 已加载：确保当前视图里有内容
      if (!$('#itemList').children.length) {
        renderCats();
        renderItems(true);
        renderPicked();
        syncSubmit();
      }
      return;
    }
    loadItems().then(function () {
      renderCats();
      renderItems(true);
      renderPicked();
      syncSubmit();
    }).catch(function (ex) {
      toast('物品库加载失败：' + ex.message, true);
    });
  }

  function bindItemPicker() {
    var search = $('#itemSearch');
    var timer = null;

    if (search) {
      search.addEventListener('input', function () {
        clearTimeout(timer);
        timer = setTimeout(function () {
          itemKw = search.value.trim();
          renderItems(true);
        }, 180);
      });
    }

    var form = $('#itemForm');
    if (form) {
      form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (!picked.length) return;

        var btn = $('#itemSubmit');
        var wjid = form.wjid.value.trim();
        var num = form.num.value;

        if (!/^\d{8,}$/.test(wjid)) { toast('请输入正确的玩家ID', true); return; }

        busy(btn, true);

        var seq = Promise.resolve();
        picked.slice().forEach(function (p) {
          seq = seq.then(function () {
            return api('items.offer', { wjid: wjid, wpid: p.id, num: num });
          });
        });

        seq.then(function () {
          busy(btn, false);
          toast('已发放 ' + picked.length + ' 种物品 × ' + num);
          picked = [];
          renderPicked();
          $$('#itemList .item').forEach(function (r) { r.classList.remove('is-on'); });
          syncSubmit();
          syncGiveAllField();
        }).catch(function (ex) {
          busy(btn, false);
          toast(ex.message, true);
        });
      });
    }

    // 首次进入操作页时由 switchView 调用
  }

  /* ============================================================
     事件绑定
     ============================================================ */
  function bindNav() {
    $('#nav').addEventListener('click', function (e) {
      var btn = e.target.closest('.nav__item');
      if (!btn) return;
      switchView(btn.dataset.view);
    });
  }

  function bindPlayers() {
    // 搜索防抖
    var inp = $('#playerSearch');
    inp.addEventListener('input', function () {
      clearTimeout(searchTimer);
      var v = inp.value.trim();
      searchTimer = setTimeout(function () {
        loadPlayers(v);
      }, 260);
    });

    // 行点击
    $('#playerRows').addEventListener('click', function (e) {
      var tr = e.target.closest('tr');
      if (!tr || !tr.dataset.wjid) return;
      openPlayer(tr.dataset.wjid);
    });
  }

  function bindWorld() {
    $$('[data-rank]').forEach(function (b) {
      b.addEventListener('click', function () {
        $$('[data-rank]').forEach(function (x) { x.classList.remove('is-active'); });
        b.classList.add('is-active');
        rankBy = b.dataset.rank;
        loadRank();
      });
    });
  }

  /* ============================================================
     启动
     ============================================================ */

  /* ============================================================
     兑换码
     ============================================================ */
  var cdkGifts = [];
  var cdkItems = [];   // 已选的物品
  var cdkEquips = [];  // 已选的装备
  var cdkMoney  = 0;
  var cdkGold   = 0;

  function bindCdk() {
    var view = document.querySelector('.view[data-view="cdk"]');
    if (!view) return;

    var giftList = $('#giftList');
    var genForm  = $('#genForm');
    var genGift  = $('#genGift');
    var genOut   = $('#genOut');
    var cdkRows  = $('#cdkRows');
    var cdkLogs  = $('#cdkLogs');

    // ---------- 统计 ----------
    function loadStats() {
      api('cdk.stats').then(function (j) {
        Object.keys(j).forEach(function (k) {
          var n = view.querySelector('[data-cdk="' + k + '"]');
          if (n) n.textContent = fmt.num(j[k]);
        });
      }).catch(function () {});
    }

    // ---------- 礼包列表 ----------
    function loadGifts() {
      api('cdk.gifts').then(function (j) {
        cdkGifts = j.rows || [];
        renderGifts();
        renderGiftOptions();
      }).catch(function (ex) {
        giftList.innerHTML = '';
        giftList.appendChild(el('p', 'empty', ex.message));
      });
    }

    function renderGifts() {
      giftList.innerHTML = '';
      if (!cdkGifts.length) {
        giftList.appendChild(el('p', 'empty', '还没有礼包，点右上角新建'));
        return;
      }

      cdkGifts.forEach(function (g) {
        var card = el('div', 'gift' + (g.status ? '' : ' is-off'));

        var head = el('div', 'gift__head');
        head.appendChild(el('span', 'gift__name', g.name));
        if (!g.status) head.appendChild(el('span', 'gift__tag', '已下架'));
        card.appendChild(head);

        if (g.remark) card.appendChild(el('p', 'gift__remark', g.remark));

        var meta = el('div', 'gift__meta');
        if (g.items)  meta.appendChild(el('span', null, g.items + ' 种物品'));
        if (g.equips) meta.appendChild(el('span', null, g.equips + ' 件装备'));
        if (g.money)  meta.appendChild(el('span', null, '银两 ' + fmt.money(g.money)));
        if (g.gold)   meta.appendChild(el('span', null, '元宝 ' + fmt.num(g.gold)));
        card.appendChild(meta);

        var acts = el('div', 'gift__acts');

        var bEdit = el('button', 'btn btn--sm', '编辑');
        bEdit.type = 'button';
        bEdit.addEventListener('click', function () { openGiftEditor(g); });
        acts.appendChild(bEdit);

        var bUse = el('button', 'btn btn--sm btn--primary', '生成码');
        bUse.type = 'button';
        bUse.addEventListener('click', function () {
          genGift.value = String(g.id);
          genGift.scrollIntoView({ behavior: 'smooth', block: 'center' });
          genGift.focus();
        });
        acts.appendChild(bUse);

        var bOff = el('button', 'btn btn--sm', g.status ? '下架' : '上架');
        bOff.type = 'button';
        bOff.addEventListener('click', function () {
          api('cdk.giftToggle', { id: g.id }).then(loadGifts)
             .catch(function (ex) { toast(ex.message, true); });
        });
        acts.appendChild(bOff);

        var bDel = el('button', 'iconbtn iconbtn--danger', '×');
        bDel.type = 'button';
        bDel.title = '删除礼包';
        bDel.addEventListener('click', function () {
          if (!confirm('删除礼包「' + g.name + '」？')) return;
          api('cdk.giftDelete', { id: g.id }).then(function () {
            toast('已删除'); loadGifts(); loadStats();
          }).catch(function (ex) { toast(ex.message, true); });
        });
        acts.appendChild(bDel);

        card.appendChild(acts);
        giftList.appendChild(card);
      });
    }

    function renderGiftOptions() {
      var cur = genGift.value;
      genGift.innerHTML = '<option value="">请选择</option>';
      cdkGifts.forEach(function (g) {
        if (!g.status) return;
        var o = document.createElement('option');
        o.value = g.id;
        o.textContent = g.name;
        genGift.appendChild(o);
      });
      if (cur) genGift.value = cur;
    }
    // ---------- 礼包编辑器 ----------
    var editorRepaint = null;   // openGiftEditor 注册的重绘函数

    function openGiftEditor(gift) {
      var isNew = !gift;
      var g = gift || {};

      cdkItems = [];
      cdkEquips = [];
      cdkMoney  = g.money || 0;
      cdkGold   = g.gold || 0;

      var mask = el('div', 'modal');
      var box = el('div', 'modal__box modal__box--wide');

      var head = el('div', 'modal__head');
      head.appendChild(el('h3', null, isNew ? '新建礼包' : '编辑礼包'));
      var x = el('button', 'modal__x', '×');
      x.type = 'button';
      x.addEventListener('click', function () { close(); });
      head.appendChild(x);
      box.appendChild(head);

      var body = el('div', 'modal__body');
      box.appendChild(body);

      var foot = el('div', 'modal__foot');
      box.appendChild(foot);

      function close() {
        mask.remove();
        editorRepaint = null;
      }

      // 顶部固定字段
      var f1 = el('label', 'field');
      f1.appendChild(el('span', 'field__label', '礼包名称'));
      var nameIn = el('input', 'field__input');
      nameIn.type = 'text';
      nameIn.value = g.name || '';
      nameIn.placeholder = '如 新手礼包、中秋福利';
      f1.appendChild(nameIn);
      body.appendChild(f1);

      var f2 = el('label', 'field');
      f2.appendChild(el('span', 'field__label', '备注（仅后台可见）'));
      var rmIn = el('input', 'field__input');
      rmIn.type = 'text';
      rmIn.value = g.remark || '';
      rmIn.placeholder = '选填';
      f2.appendChild(rmIn);
      body.appendChild(f2);

      var fp = el('label', 'field');
      fp.appendChild(el('span', 'field__label', '每人限领次数（0 = 不限）'));
      var perIn = el('input', 'field__input');
      perIn.type = 'number';
      perIn.min = 0;
      perIn.value = (g.per_player === undefined ? 1 : g.per_player);
      fp.appendChild(perIn);
      body.appendChild(fp);

      // 动态区
      var dyn = el('div');
      body.appendChild(dyn);

      function secHead(title, btnText, onAdd) {
        var h = el('div', 'gsec__head');
        h.appendChild(el('span', 'gsec__t', title));
        if (btnText) {
          var b2 = el('button', 'btn btn--sm', btnText);
          b2.type = 'button';
          b2.addEventListener('click', onAdd);
          h.appendChild(b2);
        }
        return h;
      }

      function paintDynamic() {
        dyn.innerHTML = '';

        // 物品
        var s1 = el('div', 'gsec');
        s1.appendChild(secHead('物品', '＋ 添加物品', pickItem));
        var w1 = el('div', 'gpick');
        if (!cdkItems.length) {
          w1.appendChild(el('p', 'gpick__empty', '未添加物品'));
        } else {
          cdkItems.forEach(function (it, idx) {
            var row = el('div', 'gpick__row');
            row.appendChild(el('span', 'gpick__id', '#' + it.id));
            row.appendChild(el('span', 'gpick__n', it.name || '物品'));
            var num = el('input', 'gpick__num');
            num.type = 'number';
            num.min = 1;
            num.value = it.num || 1;
            num.title = '数量';
            num.addEventListener('input', function () {
              cdkItems[idx].num = parseInt(num.value, 10) || 1;
            });
            row.appendChild(num);
            var rm = el('button', 'iconbtn iconbtn--danger', '×');
            rm.type = 'button';
            rm.addEventListener('click', function () {
              cdkItems.splice(idx, 1);
              paintDynamic();
            });
            row.appendChild(rm);
            w1.appendChild(row);
          });
        }
        s1.appendChild(w1);
        dyn.appendChild(s1);

        // 装备
        var s2 = el('div', 'gsec');
        s2.appendChild(secHead('装备', '＋ 添加装备', pickEquip));
        var w2 = el('div', 'gpick');
        if (!cdkEquips.length) {
          w2.appendChild(el('p', 'gpick__empty', '未添加装备'));
        } else {
          cdkEquips.forEach(function (eq, idx) {
            var row = el('div', 'gpick__row');
            row.appendChild(el('span', 'gpick__id', '#' + eq.id));
            row.appendChild(el('span', 'gpick__n', eq.name || '装备'));
            var star = el('input', 'gpick__num');
            star.type = 'number';
            star.min = 0;
            star.max = 15;
            star.value = eq.star || 0;
            star.title = '星级 0-15';
            star.addEventListener('input', function () {
              cdkEquips[idx].star = Math.max(0, Math.min(15, parseInt(star.value, 10) || 0));
            });
            row.appendChild(star);
            var rm2 = el('button', 'iconbtn iconbtn--danger', '×');
            rm2.type = 'button';
            rm2.addEventListener('click', function () {
              cdkEquips.splice(idx, 1);
              paintDynamic();
            });
            row.appendChild(rm2);
            w2.appendChild(row);
          });
        }
        s2.appendChild(w2);
        dyn.appendChild(s2);

        // 附加
        var s3 = el('div', 'gsec');
        s3.appendChild(secHead('附加', null, null));
        var gr = el('div', 'grid2');

        var fm = el('label', 'field');
        fm.appendChild(el('span', 'field__label', '银两'));
        var moneyIn = el('input', 'field__input');
        moneyIn.type = 'number';
        moneyIn.min = 0;
        moneyIn.value = cdkMoney;
        moneyIn.addEventListener('input', function () {
          cdkMoney = parseInt(moneyIn.value, 10) || 0;
        });
        fm.appendChild(moneyIn);
        gr.appendChild(fm);

        var fg = el('label', 'field');
        fg.appendChild(el('span', 'field__label', '元宝'));
        var goldIn = el('input', 'field__input');
        goldIn.type = 'number';
        goldIn.min = 0;
        goldIn.value = cdkGold;
        goldIn.addEventListener('input', function () {
          cdkGold = parseInt(goldIn.value, 10) || 0;
        });
        fg.appendChild(goldIn);
        gr.appendChild(fg);

        s3.appendChild(gr);
        dyn.appendChild(s3);
      }

      editorRepaint = paintDynamic;

      // 底部
      var cancel = el('button', 'btn', '取消');
      cancel.type = 'button';
      cancel.addEventListener('click', close);
      foot.appendChild(cancel);

      var save = el('button', 'btn btn--primary', '保存');
      save.type = 'button';
      save.addEventListener('click', function () {
        var name = nameIn.value.trim();
        if (!name) { toast('请填写礼包名称', true); nameIn.focus(); return; }

        busy(save, true);
        api('cdk.giftSave', {
          id: g.id || 0,
          name: name,
          remark: rmIn.value.trim(),
          per_player: parseInt(perIn.value, 10) || 0,
          items: JSON.stringify(cdkItems.map(function (i) { return { id: i.id, num: i.num }; })),
          equips: JSON.stringify(cdkEquips.map(function (e) { return { id: e.id, star: e.star }; })),
          money: cdkMoney,
          gold: cdkGold
        }).then(function () {
          toast('已保存');
          close();
          loadGifts();
          loadStats();
        }).catch(function (ex) {
          toast(ex.message, true);
          busy(save, false);
        });
      });
      foot.appendChild(save);

      paintDynamic();
      mask.appendChild(box);
      document.body.appendChild(mask);
      setTimeout(function () { nameIn.focus(); }, 100);

      // 编辑已有礼包：拉详情
      if (g.id) {
        api('cdk.giftDetail', { id: g.id }).then(function (j) {
          cdkItems = (j.items || []).map(function (i) { return { id: i.id, name: i.name || ('物品#' + i.id), num: i.num }; });
          cdkEquips = (j.equips || []).map(function (e) { return { id: e.id, name: e.name || ('装备#' + e.id), star: e.star }; });
          cdkMoney = j.money || 0;
          cdkGold = j.gold || 0;
          paintDynamic();
        }).catch(function () {});
      }
    }

    // ---------- 轻量选择器（礼包编辑用） ----------
    function pickItem() {
      loadItems().then(function (list) {
        showPicker('选择物品', list, function (it) {
          return { id: it.i, name: it.n, sub: it.d ? it.d.slice(0, 18) : '' };
        }, function (it) {
          if (cdkItems.some(function (x) { return x.id === it.i; })) {
            toast('已经添加过了', true);
            return;
          }
          cdkItems.push({ id: it.i, name: it.n, num: 1 });
          refreshEditor();
        }, function (kw) {
          var k = kw.toLowerCase();
          return list.filter(function (it) {
            return !k || String(it.i).indexOf(k) !== -1 || (it.n || '').toLowerCase().indexOf(k) !== -1;
          });
        });
      }).catch(function (ex) { toast(ex.message, true); });
    }

    function pickEquip() {
      loadEquips().then(function (list) {
        showPicker('选择装备', list, function (eq) {
          return { id: eq.i, name: eq.n, sub: (eq.cat !== undefined ? eq.cat + ' · ' : '') + 'Lv' + eq.lv };
        }, function (eq) {
          if (cdkEquips.some(function (x) { return x.id === eq.i; })) {
            toast('已经添加过了', true);
            return;
          }
          cdkEquips.push({ id: eq.i, name: eq.n, star: 0 });
          refreshEditor();
        }, function (kw) {
          var k = kw.toLowerCase();
          return list.filter(function (eq) {
            return !k || String(eq.i).indexOf(k) !== -1 || (eq.n || '').toLowerCase().indexOf(k) !== -1;
          });
        });
      }).catch(function (ex) { toast(ex.message, true); });
    }

    /* 通用选择弹窗 */
    function showPicker(title, data, mapFn, onPick, filterFn) {
      var mask = el('div', 'modal modal--pick');
      var box = el('div', 'modal__box modal__box--pick');

      var head = el('div', 'modal__head');
      head.appendChild(el('h3', null, title));
      var x = el('button', 'modal__x', '×');
      x.type = 'button';
      x.addEventListener('click', function () { mask.remove(); });
      head.appendChild(x);
      box.appendChild(head);

      var bar = el('div', 'pickbar');
      var inp = el('input', 'field__input field__input--search');
      inp.type = 'search';
      inp.placeholder = '搜名称或 ID';
      bar.appendChild(inp);
      box.appendChild(bar);

      var list = el('div', 'picklist');
      box.appendChild(list);

      function draw(kw) {
        list.innerHTML = '';
        var arr = filterFn(kw || '').slice(0, 200);
        if (!arr.length) {
          list.appendChild(el('p', 'empty', '没有匹配项'));
          return;
        }
        arr.forEach(function (raw) {
          var m = mapFn(raw);
          var row = el('div', 'pickrow');
          row.appendChild(el('span', 'pickrow__id', '#' + m.id));
          var mid = el('div', 'pickrow__mid');
          mid.appendChild(el('span', 'pickrow__n', m.name));
          if (m.sub) mid.appendChild(el('span', 'pickrow__sub', m.sub));
          row.appendChild(mid);
          row.addEventListener('click', function () {
            onPick(raw);
            mask.remove();
          });
          list.appendChild(row);
        });
      }

      draw('');
      var t = null;
      inp.addEventListener('input', function (e) {
        clearTimeout(t);
        var v = e.target.value;
        t = setTimeout(function () { draw(v); }, 200);
      });

      mask.appendChild(box);
      document.body.appendChild(mask);
      setTimeout(function () { inp.focus(); }, 100);
    }

    /* 重绘编辑器里的物品/装备区域，不关闭弹窗 */
    function refreshEditor() {
      if (typeof editorRepaint === 'function') editorRepaint();
    }

    // ---------- 生成兑换码 ----------
    genForm.addEventListener('submit', function (e) {
      e.preventDefault();
      var fd = new FormData(genForm);
      var giftId = fd.get('gift_id');
      if (!giftId) { toast('请先选择礼包', true); return; }

      var btn = genForm.querySelector('button[type=submit]');
      busy(btn, true);

      var payload = {
        gift_id: giftId,
        count: fd.get('count') || 10,
        prefix: fd.get('prefix') || '',
        start_at: fd.get('start_at') || '',
        end_at: fd.get('end_at') || '',
        limit_total: fd.get('limit_total') || 0
      };

      api('cdk.generate', payload).then(function (j) {
        busy(btn, false);
        toast('已生成 ' + j.count + ' 个');

        genOut.innerHTML = '';
        genOut.appendChild(el('p', 'genout__t', '本次生成（' + j.batch + '）'));

        var ta = document.createElement('textarea');
        ta.className = 'genout__ta';
        ta.rows = Math.min(10, Math.max(3, j.count));
        ta.readOnly = true;
        ta.value = (j.codes || []).join('\n');
        genOut.appendChild(ta);

        var row = el('div', 'btnrow');
        var cp = el('button', 'btn btn--sm btn--primary', '复制全部');
        cp.type = 'button';
        cp.addEventListener('click', function () {
          ta.select();
          try { document.execCommand('copy'); toast('已复制 ' + j.count + ' 个码'); }
          catch (err) { toast('请手动复制', true); }
        });
        row.appendChild(cp);

        var dl = el('button', 'btn btn--sm', '下载 txt');
        dl.type = 'button';
        dl.addEventListener('click', function () {
          var blob = new Blob([(j.codes || []).join('\r\n')], { type: 'text/plain;charset=utf-8' });
          var a = document.createElement('a');
          a.href = URL.createObjectURL(blob);
          a.download = 'cdk-' + j.batch + '.txt';
          a.click();
          URL.revokeObjectURL(a.href);
        });
        row.appendChild(dl);
        genOut.appendChild(row);

        loadCodes();
        loadStats();
      }).catch(function (ex) {
        busy(btn, false);
        toast(ex.message, true);
      });
    });
    // ---------- 兑换码列表 ----------
    function loadCodes(kw) {
      api('cdk.list', { q: kw || '' }).then(function (j) {
        cdkRows.innerHTML = '';
        var rows = j.rows || [];
        if (!rows.length) {
          var tr = el('tr');
          var td = el('td', 'empty', kw ? '没有匹配的兑换码' : '还没有生成兑换码');
          td.colSpan = 6;
          tr.appendChild(td);
          cdkRows.appendChild(tr);
          return;
        }

        rows.forEach(function (r) {
          var tr = el('tr');

          // 码
          var td1 = el('td');
          var code = el('span', 'cdkcode', r.code);
          code.title = '点击复制';
          code.addEventListener('click', function () {
            var ta = document.createElement('textarea');
            ta.value = r.code;
            document.body.appendChild(ta);
            ta.select();
            try { document.execCommand('copy'); toast('已复制'); } catch (e) {}
            ta.remove();
          });
          td1.appendChild(code);
          tr.appendChild(td1);

          tr.appendChild(el('td', null, r.gift_name || '—'));

          // 有效期
          var td3 = el('td', 'cdkdate');
          if (r.start_at || r.end_at) {
            td3.textContent = (r.start_at ? r.start_at.slice(0, 16) : '不限')
                          + ' → ' + (r.end_at ? r.end_at.slice(0, 16) : '不限');
          } else {
            td3.textContent = '长期有效';
          }
          tr.appendChild(td3);

          // 用量
          var used = r.limit_total > 0
            ? r.used + ' / ' + r.limit_total
            : r.used + ' 次';
          tr.appendChild(el('td', 'num', used));

          // 状态
          var td5 = el('td');
          var badge = el('span', 'badge' + (r.status ? '' : ' badge--off'),
                             r.status ? '可用' : '停用');
          td5.appendChild(badge);
          tr.appendChild(td5);

          // 操作
          var td6 = el('td');
          var acts = el('div', 'rowacts');

          var bT = el('button', 'btn btn--xs', r.status ? '停用' : '启用');
          bT.type = 'button';
          bT.addEventListener('click', function () {
            api('cdk.toggle', { id: r.id }).then(function () { loadCodes(kw); })
               .catch(function (ex) { toast(ex.message, true); });
          });
          acts.appendChild(bT);

          var bD = el('button', 'iconbtn iconbtn--danger', '×');
          bD.type = 'button';
          bD.title = '删除这个码';
          bD.addEventListener('click', function () {
            if (!confirm('删除兑换码 ' + r.code + '？' + (r.used ? '（已被用过 ' + r.used + ' 次）' : ''))) return;
            api('cdk.delete', { id: r.id }).then(function () {
              toast('已删除');
              loadCodes(kw);
              loadStats();
            }).catch(function (ex) { toast(ex.message, true); });
          });
          acts.appendChild(bD);

          td6.appendChild(acts);
          tr.appendChild(td6);
          cdkRows.appendChild(tr);
        });
      }).catch(function (ex) {
        cdkRows.innerHTML = '';
        var tr = el('tr');
        var td = el('td', 'empty', ex.message);
        td.colSpan = 6;
        tr.appendChild(td);
        cdkRows.appendChild(tr);
      });
    }

    // ---------- 兑换记录 ----------
    function loadLogs() {
      api('cdk.logs').then(function (j) {
        cdkLogs.innerHTML = '';
        var rows = j.rows || [];
        if (!rows.length) {
          var tr = el('tr');
          var td = el('td', 'empty', '还没有人兑换');
          td.colSpan = 5;
          tr.appendChild(td);
          cdkLogs.appendChild(tr);
          return;
        }
        rows.forEach(function (r) {
          var tr = el('tr');
          tr.appendChild(el('td', 'cdkdate', (r.created_at || '').slice(0, 16)));
          tr.appendChild(el('td', 'cdkcode', r.code));
          tr.appendChild(el('td', null, r.gift_name || '—'));

          var td = el('td');
          td.appendChild(el('span', 'pname__nick', r.nick || '—'));
          td.appendChild(el('span', 'pname__wid', '#' + r.wjid));
          tr.appendChild(td);

          tr.appendChild(el('td', 'num', r.ip || '—'));
          cdkLogs.appendChild(tr);
        });
      }).catch(function (ex) {
        cdkLogs.innerHTML = '';
        var tr = el('tr');
        var td = el('td', 'empty', ex.message);
        td.colSpan = 5;
        tr.appendChild(td);
        cdkLogs.appendChild(tr);
      });
    }

    // ---------- 绑定 ----------
    $('#newGift').addEventListener('click', function () { openGiftEditor(null); });
    $('#cdkRefresh').addEventListener('click', function () { loadCodes($('#cdkSearch').value.trim()); });
    $('#logRefresh').addEventListener('click', loadLogs);

    var searchTimer = null;
    $('#cdkSearch').addEventListener('input', function (e) {
      clearTimeout(searchTimer);
      var v = e.target.value.trim();
      searchTimer = setTimeout(function () { loadCodes(v); }, 300);
    });

    // 首次进入才加载
    var cdkLoaded = false;
    document.querySelector('.nav__item[data-view="cdk"]').addEventListener('click', function () {
      loadStats();
      loadGifts();
      loadCodes('');
      loadLogs();
      cdkLoaded = true;
    });
  }

  function boot() {
    if (booted) {
      loadOverview();
      return;
    }
    booted = true;

    // 逐个绑定并隔离错误：某个绑定失败不应影响其余功能
    [
      ['导航', bindNav],
      ['玩家', bindPlayers],
      ['世界', bindWorld],
      ['物品选择器', bindItemPicker],
      ['系统操作', bindSystemOps],
      ['装备', bindEquipPicker],
      ['GM账号', bindGmAccounts],
      ['消息', bindMessages],
      ['兑换码', bindCdk],
      ['退出', bindLogout]
    ].forEach(function (item) {
      try {
        item[1]();
      } catch (err) {
        if (window.console && console.error) {
          console.error('[GM] ' + item[0] + ' 绑定失败:', err.message);
        }
      }
    });

    loadOverview();

    // 预加载物品库：用户切到操作页时数据已就绪，避免等待
    if (window.requestIdleCallback) {
      requestIdleCallback(function () {
        loadItems().catch(function () {});
        loadEquips().catch(function () {});
      });
    } else {
      setTimeout(function () { loadItems().catch(function () {}); }, 600);
    }
  }

  function init() {
    bindLogin();

    api('auth.status').then(function (j) {
      if (j.loggedIn && j.user) {
        showShell(j.user);
      } else {
        showGate();
      }
    }).catch(function () {
      showGate();
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
