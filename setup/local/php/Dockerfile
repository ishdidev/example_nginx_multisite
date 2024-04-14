FROM php:8.1-fpm-alpine3.16
LABEL maintainer="dev@ishdi.com"

ARG ENV="localdev"
ARG UID=101

RUN echo "@edge-main http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "@edge-community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --no-cache linux-headers \
    && apk add --update alpine-sdk python3 autoconf bash curl freetype-dev g++ gdb git gnu-libiconv@edge-community icu-dev \
    gettext gettext-dev bzip2-dev imap-dev libjpeg-turbo-dev libpng libpng-dev libzip-dev make patch mysql-client pcre-dev \
    strace tzdata vim zip libxml2-dev libxslt-dev libgcrypt-dev ssmtp \
    && deluser www-data \
    && adduser -D -g 'php user' -h /var/www -s /bin/false -u $UID www-data \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) bcmath gd intl mysqli pdo_mysql zip calendar exif gettext bz2 imap soap sockets xsl \
    && cp /usr/share/zoneinfo/Asia/Kolkata /etc/localtime \
    && echo "Asia/Kolkata" > /etc/timezone \
    && chgrp -R www-data /var/www \
    && ln -sf python3  /usr/bin/python \
    && set -xe \
    && apk del --purge alpine-sdk autoconf pcre-dev tzdata \
    && rm -rf /tmp/* /usr/share/vim/vim74/doc/* /usr/share/vim/vim74/tutor/* /usr/src/php.tar* /var/cache/apk/*

COPY php.ini /usr/local/etc/php/
# prefix with zzz- to make sure the config will be loaded
COPY app.conf /usr/local/etc/php-fpm.d/zzz-app.conf
