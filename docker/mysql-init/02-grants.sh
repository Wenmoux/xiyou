#!/bin/bash
# 幻想西游一键端：补全业务账号权限
# 官方 mysql 镜像只会把 MYSQL_DATABASE(xyy) 的权限授予 MYSQL_USER，
# 但游戏还要读写 xxjyuser（账号库）和 wuzhi_data（站点库）。
# 该脚本由 entrypoint 在 root 上下文执行，因此能读到 compose 传入的账号密码。
set -euo pipefail

DB_USER="${MYSQL_USER:-hxxy}"
DB_PASS="${MYSQL_PASSWORD:-change_me_db_password}"

echo "[hxxy-init] 为账号 ${DB_USER} 授权 xyy / xxjyuser / wuzhi_data"

mysql --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" <<SQL
GRANT ALL PRIVILEGES ON \`xyy\`.*        TO '${DB_USER}'@'%';
GRANT ALL PRIVILEGES ON \`xxjyuser\`.*   TO '${DB_USER}'@'%';
GRANT ALL PRIVILEGES ON \`wuzhi_data\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
SQL

echo "[hxxy-init] 授权完成"
