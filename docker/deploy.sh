#!/bin/bash
# ============================================================
# 幻想西游 一键端 - Docker 部署脚本
# 用法：
#   ./deploy.sh            首次部署或更新
#   ./deploy.sh down       停止
#   ./deploy.sh logs       查看日志
#   ./deploy.sh status     状态
#   ./deploy.sh reset      停止并清空所有数据（危险）
# ============================================================
set -euo pipefail

cd "$(dirname "$0")"

log() { printf '\033[36m[hxxy]\033[0m %s\n' "$*"; }
err() { printf '\033[31m[hxxy]\033[0m %s\n' "$*" >&2; }

# ---------- 前置检查 ----------
if ! command -v docker >/dev/null 2>&1; then
  err "未检测到 docker，请先安装 Docker"
  exit 1
fi
if ! docker compose version >/dev/null 2>&1; then
  err "未检测到 docker compose 插件"
  exit 1
fi

ACTION="${1:-up}"

case "$ACTION" in
  down)
    log "停止服务..."
    docker compose down
    exit 0
    ;;
  logs)
    docker compose logs -f --tail=100
    exit 0
    ;;
  status)
    docker compose ps
    exit 0
    ;;
  reset)
    printf '\033[31m这会删除全部游戏数据（数据库 + 玩家存档）！\033[0m\n'
    read -rp "确认请输入 yes: " ans
    [ "$ans" = "yes" ] || { echo "已取消"; exit 0; }
    docker compose down -v
    log "已清空"
    exit 0
    ;;
  up|"")
    ;;
  *)
    err "未知参数: $ACTION"
    exit 1
    ;;
esac

# ---------- 配置 ----------
if [ ! -f .env ]; then
  log "生成 .env（首次部署）"
  cp .env.example .env

  # 自动探测服务器公网 IP，作为站点地址
  PUBLIC_IP="$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null || true)"
  if [ -n "$PUBLIC_IP" ]; then
    sed -i "s|^SITE_HOST=.*|SITE_HOST=${PUBLIC_IP}|" .env
    log "探测到公网 IP: ${PUBLIC_IP}"
  fi

  # 随机生成数据库密码，避免默认弱口令
  ROOT_PW="$(head -c 18 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 20)"
  USER_PW="$(head -c 18 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 20)"
  sed -i "s|^MYSQL_ROOT_PASSWORD=.*|MYSQL_ROOT_PASSWORD=${ROOT_PW}|" .env
  sed -i "s|^DB_PASS=.*|DB_PASS=${USER_PW}|" .env
  log "已生成随机数据库密码（保存在 .env）"
else
  log "使用已有 .env"
fi

set -a
# shellcheck disable=SC1091
. ./.env
set +a

HTTP_PORT="${HTTP_PORT:-8080}"

# ---------- 端口检查 ----------
if command -v ss >/dev/null 2>&1; then
  if ss -lnt 2>/dev/null | grep -q ":${HTTP_PORT} "; then
    err "端口 ${HTTP_PORT} 已被占用，请修改 .env 里的 HTTP_PORT"
    exit 1
  fi
fi

# ---------- 源码上传路径校验 ----------
if [ ! -d ../phpstudy/WWW ]; then
  err "找不到 ../phpstudy/WWW，请确保 docker/ 与 phpstudy/ 同级"
  exit 1
fi

# ---------- 构建 ----------
log "构建镜像（首次需要 2-5 分钟编译 PHP 扩展）..."
docker compose build

log "启动服务..."
docker compose up -d

# ---------- 等待就绪 ----------
log "等待 MySQL 初始化并导入数据..."
for i in $(seq 1 60); do
  if docker compose ps mysql 2>/dev/null | grep -q "healthy"; then
    break
  fi
  sleep 3
  [ "$i" = "60" ] && { err "MySQL 启动超时，请查看: docker compose logs mysql"; exit 1; }
done

# web 容器依赖 MySQL 健康，这里确保它真的起来
for i in $(seq 1 30); do
  if docker compose ps web 2>/dev/null | grep -q "Up"; then
    break
  fi
  docker compose up -d web >/dev/null 2>&1 || true
  sleep 3
done

sleep 3

# ---------- 健康检查 ----------
log "健康检查..."
FAIL=0
for path in / /xxjy/login.php /admin/login.php; do
  code="$(curl -s -o /dev/null -w '%{http_code}' --max-time 10 "http://127.0.0.1:${HTTP_PORT}${path}" || echo 000)"
  if [ "$code" = "200" ]; then
    printf '  ✓ %-22s HTTP %s\n' "$path" "$code"
  else
    printf '  ✗ %-22s HTTP %s\n' "$path" "$code"
    FAIL=1
  fi
done

# 数据库校验
TB="$(docker compose exec -T mysql mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -N -B \
      -e "select count(*) from information_schema.tables where table_schema in ('xyy','xxjyuser','wuzhi_data');" 2>/dev/null | tr -d '\r')"
if [ "${TB:-0}" -ge 200 ]; then
  printf '  ✓ %-22s %s 张表\n' "数据库" "$TB"
else
  printf '  ✗ %-22s 仅 %s 张表（导入可能失败）\n' "数据库" "${TB:-0}"
  FAIL=1
fi

echo
if [ "$FAIL" = "0" ]; then
  printf '\033[32m部署成功\033[0m\n\n'
  echo "  游戏地址:  http://${SITE_HOST}:${HTTP_PORT}/"
  echo "  注册地址:  http://${SITE_HOST}:${HTTP_PORT}/xxjy/regist.php"
  echo "  登录地址:  http://${SITE_HOST}:${HTTP_PORT}/xxjy/login.php"
  echo "  GM 后台:   http://${SITE_HOST}:${HTTP_PORT}/admin/login.php"
  echo
  echo "  常用命令:"
  echo "    ./deploy.sh status   查看状态"
  echo "    ./deploy.sh logs     查看日志"
  echo "    ./deploy.sh down     停止"
  echo "    ./deploy.sh up       重新启动"
else
  printf '\033[31m部署未完全成功\033[0m，请执行 ./deploy.sh logs 排查\n'
  exit 1
fi
