# ============================================================
# 幻想西游一键端 - Web 运行环境
# ------------------------------------------------------------
# 只负责"让 PHP 5.6 能跑这套老代码"，不掺业务逻辑。
# 业务性修复（CSS 引用、入口页、存档初始化）都已直接改在源码里，
# 见 phpstudy/WWW/ 下的 play.php、class/user_ini_compat.php。
#
# 为什么锁 PHP 5.6：
#   全站依赖 mysql_*（1800+ 处）、each()（736 处）、split()（47 处），
#   PHP 7 已全部移除。下限需 >= 5.3（短标签 + mysql_*）。
# 为什么用 Apache mod_php：
#   与原端 phpstudy 的 Apache + php5_module 行为一致，
#   CWD / SCRIPT_FILENAME 语义相同，旧代码的相对路径 include 才能正确解析。
# ============================================================
FROM php:5.6.40-apache

# ---------- Debian 9 (stretch) 已 EOL，软件源迁至归档 ----------
# 不修这一层，apt-get 全部 404，扩展无法编译
RUN set -eux; \
    printf '%s\n' \
      'deb http://archive.debian.org/debian stretch main' \
      'deb http://archive.debian.org/debian-security stretch/updates main' \
      > /etc/apt/sources.list; \
    { \
      echo 'Acquire::Check-Valid-Until "false";'; \
      echo 'Acquire::AllowInsecureRepositories "true";'; \
    } > /etc/apt/apt.conf.d/99archive;

# ---------- 运行期依赖 ----------
RUN set -eux; \
    apt-get -o Acquire::Check-Valid-Until=false update; \
    apt-get install -y --no-install-recommends --allow-unauthenticated \
        default-mysql-client \
    ; \
    rm -rf /var/lib/apt/lists/*

# ---------- PHP 扩展 ----------
# mysql  : 全站主用（mysql_query / mysql_fetch_array...），必需
# mysqli : 少数脚本混用
# bcmath : wp/funk1.php 的 calc() 用 bcadd/bcsub/bcmul/bcdiv 处理大额银两
#          （1 金锭 = 99 亿银两，必须高精度），缺失会让游戏页直接 Fatal error
# mbstring / iconv / curl / json / pcre 已由基础镜像编译内置
RUN set -eux; \
    docker-php-ext-install -j"$(nproc)" mysql mysqli bcmath; \
    php -m | grep -q '^mysql$'  || { echo "mysql 扩展缺失";  exit 1; }; \
    php -m | grep -q '^bcmath$' || { echo "bcmath 扩展缺失"; exit 1; }

# ---------- 配置 ----------
COPY docker/php/php.ini /usr/local/etc/php/conf.d/zz-hxxy.ini

# 替换官方默认站点：000-default.conf 固定 DocumentRoot /var/www/html，
# 会覆盖 conf-enabled 中的主配置，因此直接替换该虚拟主机
COPY docker/apache/hxxy.conf /etc/apache2/sites-available/000-default.conf

RUN set -eux; \
    a2enmod rewrite headers expires; \
    mkdir -p /var/www/hxxy

# ---------- 应用代码 ----------
COPY phpstudy/WWW/ /var/www/hxxy/

# ---------- 存档目录统一 ----------
# 原端两套 .ini 缓存，相对路径不同：
#   xxjy/*.php -> '../ache/<wjid>'  => WWW/ache        （登录层，只写令牌）
#   fqxy/*.php -> 'ache/<wjid>'     => WWW/fqxy/ache   （游戏层，完整存档）
# 两层互不可见。以游戏层为唯一真实存储，WWW/ache 做软链接指向它。
RUN set -eux; \
    if [ -d /var/www/hxxy/ache ] && [ ! -L /var/www/hxxy/ache ]; then \
      cp -an /var/www/hxxy/ache/. /var/www/hxxy/fqxy/ache/ 2>/dev/null || true; \
      rm -rf /var/www/hxxy/ache; \
    fi; \
    ln -sfn /var/www/hxxy/fqxy/ache /var/www/hxxy/ache; \
    mkdir -p /var/www/hxxy/fqxy/ache /var/www/hxxy/fqxy/acher \
             /var/www/hxxy/fqxy/acher/map /var/www/hxxy/fqxy/acher/guoz \
             /var/www/hxxy/fqxy/acher/phb /var/www/hxxy/fqxy/ip \
             /var/www/hxxy/acher /var/www/hxxy/acher/map \
             /var/www/hxxy/acher/guoz /var/www/hxxy/acher/phb; \
    chown -R www-data:www-data /var/www/hxxy; \
    chmod -R 777 /var/www/hxxy/fqxy/ache /var/www/hxxy/fqxy/acher \
                 /var/www/hxxy/acher /var/www/hxxy/fqxy/ip

# 源码语法自检：确保业务补丁文件能被 PHP 5.6 解析
RUN set -eux; \
    php -l /var/www/hxxy/play.php; \
    php -l /var/www/hxxy/class/user_ini_compat.php

# ---------- 启动 ----------
COPY docker/php/entrypoint.sh /usr/local/bin/hxxy-entrypoint
RUN chmod +x /usr/local/bin/hxxy-entrypoint

EXPOSE 80
ENTRYPOINT ["hxxy-entrypoint"]
CMD ["apache2-foreground"]
