#!/usr/bin/env bash

[ -z ${XDEBUG_REMOTE_HOST+x} ] \
  && echo 'ERROR: Define XDEBUG_REMOTE_HOST variable' \
  && exit 1

declare -A XDEBUG_CONFIG
XDEBUG_CONFIG[xdebug.client_host]=${XDEBUG_REMOTE_HOST}
XDEBUG_CONFIG[xdebug.mode]=debug,coverage,develop
XDEBUG_CONFIG[xdebug.start_with_request]=yes
XDEBUG_CONFIG[xdebug.discover_client_host]=1
XDEBUG_CONFIG[xdebug.log_level]=0


for parameter in "${!XDEBUG_CONFIG[@]}"; do
  key="${parameter%%:*}"
  value="${parameter##*:}"
  sed -i \
    -e "/^\(${parameter}=\).*/{s//\1${XDEBUG_CONFIG[${parameter}]}/;:a;n;ba;q}" \
    -e '$a'${parameter}=${XDEBUG_CONFIG[${parameter}]}'' \
  /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
done