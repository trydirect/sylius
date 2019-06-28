FROM php:7.2-fpm-alpine3.6
WORKDIR '/app'
RUN apk update && apk upgrade\
    && apk add --no-cache curl libbz2 php7-bz2 php7-pdo php7-pgsql php7-bcmath php7-zmq php7-curl bash php7-pear php7-imagick openssh\
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
    subversion \
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
    ffmpeg \
    wget

RUN curl -sS -o /tmp/icu.tar.gz -L http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.tgz && tar -zxf /tmp/icu.tar.gz -C /tmp && cd /tmp/icu/source && ./configure --prefix=/usr/local && make && make install
RUN docker-php-ext-configure intl --with-icu-dir=/usr/local && \
    docker-php-ext-install intl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install gd bcmath zip bz2 pdo pdo_pgsql simplexml opcache sockets mbstring pcntl xsl pspell
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install pdo_mysql exif
RUN pecl install imagick
RUN docker-php-ext-enable imagick exif
RUN pecl install xdebug
RUN wget http://xdebug.org/files/xdebug-2.6.1.tgz
RUN tar -xvzf xdebug-2.6.1.tgz
RUN cd xdebug-2.6.1 \
    && phpize \
    && ./configure --enable-xdebug \
    && make \
    && make install \
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
RUN cd /usr/src && curl -OL https://github.com/Sylius/Sylius/archive/v1.5.2.tar.gz
RUN adduser -u 2000 -g 2000 -h /home/symfony -s /bin/bash -D symfony
WORKDIR '/var/www/html'
