# arm64v8 (ARMv8 64-bit) for M1 macbooks
# amd64 for Linux x86-64
ARG ARCHITECTURE=amd64
ARG PHP_VERSION=8.1
FROM ${ARCHITECTURE}/php:${PHP_VERSION}-fpm-alpine AS app_php

ENV PS1='\[\033[1;32m\]🐳  \[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Set build arguments
ARG RUN_USER="developer"
ARG RUN_GROUP="${RUN_USER}"
# UID is missed as it will be set by docker-compose
ARG RUN_UID=""
ARG RUN_GID="${RUN_UID}"

RUN addgroup -g ${RUN_GID} ${RUN_GROUP} \
    && adduser -h /app -S -u ${RUN_UID} -G ${RUN_GROUP} -D --gecos "" ${RUN_USER} \
    && chmod 777 /usr/local/var/log/

RUN apk add --no-cache --update --virtual .build-deps $PHPIZE_DEPS \
	&& pecl install xdebug \
	&& docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-enable xdebug pdo_mysql \
	&& apk del -f .build-deps

RUN apk add --no-cache --update bash


COPY .docker/php/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy manifest folder
RUN rm -f /usr/local/etc/php-fpm.d/*
COPY .docker/php/manifest/usr /usr

# Configure xdebug
ARG XDEBUG_REMOTE_HOST=false
COPY .docker/php/config/config-xdebug.sh /usr/local/bin/config-xdebug
RUN chmod +x /usr/local/bin/config-xdebug && /usr/local/bin/config-xdebug

RUN chown -hR ${RUN_USER}:${RUN_GROUP} /app

WORKDIR /app

USER ${RUN_USER}

ENTRYPOINT ["/entrypoint.sh"]

CMD ["server"]
