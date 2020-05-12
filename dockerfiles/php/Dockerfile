ARG COMPOSER_VERSION=latest
ARG PHP_VERSION=7.4-fpm-alpine

FROM composer:$COMPOSER_VERSION AS composer
FROM php:$PHP_VERSION AS base

LABEL maintainer="info@optimum-web.com"

ENV SYLIUS_VERSION=1.7.3

WORKDIR '/app'

COPY --from=composer /usr/bin/composer /usr/bin/composer
#
# dev stage
#
FROM base AS dev
RUN apk update && apk add --no-cache curl libbz2 php7-bz2 php7-pdo php7-pgsql php7-bcmath php7-zmq php7-curl bash \
    php7-pear php7-imagick \
    libzip-dev \
    libtool \
    postgresql-dev \
    libpng-dev \
    imagemagick-c++ \
    imagemagick-dev \
    libmcrypt-dev \
    libxml2-dev \
    yaml-dev \
    bzip2 \
    aspell-dev \
    autoconf \
    build-base \
    linux-headers \
    libaio-dev \
    zlib-dev \
    git \
    freetype-dev \
    libjpeg-turbo-dev \
    libmcrypt-dev \
    bzip2-dev \
    libstdc++ \
    libxslt-dev \
    openldap-dev \
    hiredis-dev \
    make \
    unzip \
    && docker-php-ext-install -j$(nproc) gd bcmath zip bz2 pdo \
    pdo_pgsql simplexml opcache sockets pcntl xsl pspell \
    && docker-php-ext-configure gd \
    && docker-php-ext-install pdo_mysql exif \
    && pecl install imagick xdebug \
    && docker-php-ext-enable imagick exif

RUN curl -sS -o /tmp/icu.tar.gz -L https://github.com/unicode-org/icu/archive/release-66-1.tar.gz && tar -zxf /tmp/icu.tar.gz -C /tmp && cd /tmp/icu/source && ./configure --prefix=/usr/local && make && make install
RUN docker-php-ext-configure intl --with-icu-dir=/usr/local && \
    docker-php-ext-install intl


ENV XDEBUG_VERSION=2.9.5
RUN curl -OL http://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz
RUN tar -xvzf xdebug-${XDEBUG_VERSION}.tgz

WORKDIR xdebug-${XDEBUG_VERSION}
RUN phpize \
    && ./configure --enable-xdebug \
    && make \
    && make install \
    && make test \
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718 \
    && echo 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20170718/xdebug.so' >> /usr/local/etc/php.ini \
    && echo 'xdebug.remote_enable=on' >> /usr/local/etc/php.ini \
    && echo 'xdebug.remote_connect_back=1' >> /usr/local/etc/php.ini \
    && echo 'xdebug.remote_host=127.0.0.1' >> /usr/local/etc/php.ini \
    && echo 'xdebug.remote_port=9000' >> /usr/local/etc/php.ini \
    && echo 'xdebug.remote_handler=dbgp' >> /usr/local/etc/php.ini \
    && echo 'xdebug.max_nesting_level=512' >> /usr/local/etc/php.ini \
    && echo 'extension=xdebug.so' >> /usr/local/etc/php.ini \
    && echo 'memory_limit=1G' >> /usr/local/etc/php.ini \
    && sed -i 's/memory_limit\ =\ 128M/memory_limit\ =\ 1G/g' /usr/local/etc/php/php.ini-development \
    && sed -i 's/memory_limit\ =\ 128M/memory_limit\ =\ 1G/g' /usr/local/etc/php/php.ini-production \
    && echo 'date.timezone=Europe/Warsaw' >> /usr/local/etc/php/php.ini-development \
    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN cd /usr/src && curl -OL https://github.com/Sylius/Sylius/archive/v$SYLIUS_VERSION.tar.gz
RUN adduser -u 2000 -g 2000 -h /home/symfony -s /bin/bash -D symfony
WORKDIR /var/www/html
