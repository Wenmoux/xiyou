#!/bin/bash
# ============================================================
# 幻想西游一键端 - Web 容器入口
# ------------------------------------------------------------
# 只做"跟部署环境有关"的事：
#   1. 注入数据库连接（原文件写死 127.0.0.1 / root / 123456）
#   2. 注入站点地址（原文件写死某个内网 IP）
#   3. 兜底重建可写目录（挂载卷会覆盖镜像内目录）
#   4. 等数据库就绪再起 Apache
#
# 业务性修复（CSS 引用、入口按钮、存档初始化）已直接改在源码里，
# 不在这里做——那是应用的事，不是部署的事。
# ============================================================
set -euo pipefail

APP_ROOT=/var/www/hxxy

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-hxxy}"
DB_PASS="${DB_PASS:-change_me_db_password}"
SITE_HOST="${SITE_HOST:-localhost}"
SITE_PORT="${SITE_PORT:-80}"

# 站点地址：$config['host'] 用于拼"返回官网/选区传送"的绝对 URL
if [ -n "${SITE_HOST_OVERRIDE:-}" ]; then
  HOST_VALUE="${SITE_HOST_OVERRIDE}"
elif [ "${SITE_PORT}" = "80" ]; then
  HOST_VALUE="${SITE_HOST}"
else
  HOST_VALUE="${SITE_HOST}:${SITE_PORT}"
fi

echo "[hxxy] 数据库: ${DB_USER}@${DB_HOST}:${DB_PORT}"
echo "[hxxy] 站点地址: ${HOST_VALUE}"

# ---------- 1) 数据库连接 ----------
for f in "${APP_ROOT}/sql/mysql.php" "${APP_ROOT}/fqxy/sql/mysql.php"; do
  [ -f "$f" ] || continue
  sed -i \
    -e "s|^\(\$mysqla1 *= *\)'[^']*';|\1'${DB_HOST}';|" \
    -e "s|^\(\$mysqla2 *= *\)'[^']*';|\1'${DB_USER}';|" \
    -e "s|^\(\$mysqla3 *= *\)'[^']*';|\1'${DB_PASS}';|" \
    "$f"
done

# ---------- 2) 站点地址 ----------
if [ -d "${APP_ROOT}/config" ]; then
  printf "<?php\n\n\$config['host'] = '%s';\n" "${HOST_VALUE}" > "${APP_ROOT}/config/config.php"
fi

# ---------- 3) 可写目录兜底 ----------
mkdir -p "${APP_ROOT}/fqxy/ache" "${APP_ROOT}/fqxy/acher" \
         "${APP_ROOT}/fqxy/acher/map" "${APP_ROOT}/fqxy/acher/guoz" \
         "${APP_ROOT}/fqxy/acher/phb" "${APP_ROOT}/fqxy/ip" \
         "${APP_ROOT}/acher" "${APP_ROOT}/acher/map" \
         "${APP_ROOT}/acher/guoz" "${APP_ROOT}/acher/phb"

# WWW/ache 必须指向游戏层存档目录
if [ ! -L "${APP_ROOT}/ache" ]; then
  if [ -d "${APP_ROOT}/ache" ]; then
    cp -an "${APP_ROOT}/ache/." "${APP_ROOT}/fqxy/ache/" 2>/dev/null || true
    rm -rf "${APP_ROOT}/ache"
  fi
  ln -sfn "${APP_ROOT}/fqxy/ache" "${APP_ROOT}/ache"
fi

chown -R www-data:www-data "${APP_ROOT}/fqxy/ache" "${APP_ROOT}/fqxy/acher" \
                            "${APP_ROOT}/fqxy/ip" "${APP_ROOT}/acher" 2>/dev/null || true
chmod -R 777 "${APP_ROOT}/fqxy/ache" "${APP_ROOT}/fqxy/acher" \
             "${APP_ROOT}/fqxy/ip" "${APP_ROOT}/acher" 2>/dev/null || true


# ---------------------------------------------------------------
# 4) 家园总站验证开关
# ---------------------------------------------------------------
# 原端游戏入口会先向 host 发起 HTTP 验证请求，
# 独立部署时 host 就是本机，这条请求会变成“自己请求自己”，
# 占死 Apache worker 直到超时（前端 502）。
# 因此默认走单机本地校验；确有多区总站互联时才打开以下开关。
#
#   REMOTE_AUTH=1  → 写 config/remote_auth.flag，启用外部总站验证
#
REMOTE_FLAG="${APP_ROOT}/config/remote_auth.flag"
if [ "${REMOTE_AUTH:-0}" = "1" ]; then
  : > "$REMOTE_FLAG"
  echo "[hxxy] 已启用外部总站验证（REMOTE_AUTH=1）"
else
  rm -f "$REMOTE_FLAG"
  echo "[hxxy] 单机模式：关闭家园总站验证"
fi
# ---------- 5) 等数据库就绪 ----------
if [ "${WAIT_FOR_DB:-1}" = "1" ]; then
  echo "[hxxy] 等待数据库 ${DB_HOST}:${DB_PORT} ..."
  for i in $(seq 1 80); do
    if mysql -h"${DB_HOST}" -P"${DB_PORT}" -u"${DB_USER}" -p"${DB_PASS}" \
             -e "select 1" >/dev/null 2>&1; then
      echo "[hxxy] 数据库就绪（等待 ${i} 次）"
      break
    fi
    [ "$i" = "80" ] && echo "[hxxy] 警告：等待数据库超时，仍继续启动"
    sleep 3
  done
fi

echo "[hxxy] 启动 Apache ..."
exec "$@"
