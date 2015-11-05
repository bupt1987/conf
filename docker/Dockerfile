FROM debian:jessie

ENV PHP_VERSION            5.6.9
ENV PHP_MONGO_VERSION      1.6.8
ENV PHP_MEMCACHED_VERSION  2.2.0
ENV PHP_MEMCACHE_VERSION   2.2.7
ENV PHP_MSGPACK_VERSION    0.5.7
ENV PHP_XDEBUG_VERSION     2.3.3
ENV PHP_INI_DIR            /etc/php
ENV PHP_CONF_DIR           $PHP_INI_DIR/conf.d

ENV GPG_KEYS 6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3 0BD78B5F97500D450838F95DFE857D9A90D90EC1

ENV DEBIAN_FRONTEND noninteractive

ENV TZ Asia/Shanghai
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

RUN apt-get update
RUN apt-get install -y apt-utils

RUN apt-get install -y locales
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
RUN locale-gen

RUN apt-get install -y ca-certificates curl

RUN mkdir -p $PHP_CONF_DIR
RUN mkdir -p /var/log/php

#
# php source
#
RUN set -xe \
	&& for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done

RUN set -x \
	&& curl -SL "http://php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror" -o php.tar.gz \
	&& curl -SL "http://php.net/get/php-$PHP_VERSION.tar.gz.asc/from/this/mirror" -o php.tar.gz.asc \
	&& gpg --verify php.tar.gz.asc \
	&& mkdir -p /usr/src/php \
	&& tar -xvf php.tar.gz -C /usr/src/php --strip-components=1 \
	&& rm php.tar.gz*

#
# deps
#
ENV PHPIZE_DEPS \
	autoconf \
	file \
	g++ \
	gcc \
	libc-dev \
	make \
	pkg-config \
	re2c

ENV BUILD_DEPS \
	bzip2 \
	libcurl4-openssl-dev \
	libreadline6-dev \
	libssl-dev \
	libxml2-dev \
	libgmp-dev \
	libmhash-dev \
	libmcrypt-dev \
	libmemcached-dev

RUN apt-get install -y \
	$PHPIZE_DEPS \
	$BUILD_DEPS

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h

RUN set -x \
	&& curl -SL "http://ftp.gnu.org/gnu/bison/bison-2.7.1.tar.gz" -o bison.tgz \
	&& mkdir -p /usr/src/bison \
	&& tar -xvf bison.tgz -C /usr/src/bison --strip-components=1 \
	&& rm bison.tgz \
	&& cd /usr/src/bison \
	&& ./configure --prefix=/usr \
	&& make -j"$(nproc)" \
	&& make install \
	&& rm -rf /usr/src/bison

#
# configure && make
#
COPY config.nice /usr/src/php/config.nice
WORKDIR /var/www/html

RUN cd /usr/src/php \
	&& ./config.nice \
		"--sysconfdir=$PHP_INI_DIR" \
		"--with-config-file-path=$PHP_INI_DIR" \
		"--with-config-file-scan-dir=$PHP_CONF_DIR" \
	&& make -j"$(nproc)" \
	&& strip --strip-all /usr/src/php/sapi/fpm/php-fpm \
	&& strip --strip-all /usr/src/php/sapi/cli/php \
	&& make install \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps

#
# memcached
#
RUN set -x \
	&& curl -SL "http://pecl.php.net/get/memcached-$PHP_MEMCACHED_VERSION.tgz" -o memcached.tgz \
	&& mkdir -p /usr/src/memcached \
	&& tar -xvf memcached.tgz -C /usr/src/memcached --strip-components=1 \
	&& rm memcached.tgz \
	&& cd /usr/src/memcached \
	&& phpize \
	&& ./configure \
	&& make -j"$(nproc)" \
	&& make install \
	&& rm -rf /usr/src/memcached

#
# memcache
#
RUN set -x \
	&& curl -SL "http://pecl.php.net/get/memcache-$PHP_MEMCACHE_VERSION.tgz" -o memcache.tgz \
	&& mkdir -p /usr/src/memcache \
	&& tar -xvf memcache.tgz -C /usr/src/memcache --strip-components=1 \
	&& rm memcache.tgz \
	&& cd /usr/src/memcache \
	&& phpize \
	&& ./configure \
	&& make -j"$(nproc)" \
	&& make install \
	&& rm -rf /usr/src/memcache

#
# mongo
#
RUN set -x \
	&& curl -SL "http://pecl.php.net/get/mongo-$PHP_MONGO_VERSION.tgz" -o mongo.tgz \
	&& mkdir -p /usr/src/mongo \
	&& tar -xvf mongo.tgz -C /usr/src/mongo --strip-components=1 \
	&& rm mongo.tgz \
	&& cd /usr/src/mongo \
	&& phpize \
	&& ./configure \
	&& make -j"$(nproc)" \
	&& make install \
	&& rm -rf /usr/src/mongo

#
# msgpack
#
RUN set -x \
	&& curl -SL "http://pecl.php.net/get/msgpack-$PHP_MSGPACK_VERSION.tgz" -o msgpack.tgz \
	&& mkdir -p /usr/src/msgpack \
	&& tar -xvf msgpack.tgz -C /usr/src/msgpack --strip-components=1 \
	&& rm msgpack.tgz \
	&& cd /usr/src/msgpack \
	&& phpize \
	&& ./configure \
	&& make -j"$(nproc)" \
	&& make install \
	&& rm -rf /usr/src/msgpack

#
# xdebug
#
RUN set -x \
	&& curl -SL "http://pecl.php.net/get/xdebug-$PHP_XDEBUG_VERSION.tgz" -o xdebug.tgz \
	&& mkdir -p /usr/src/xdebug \
	&& tar -xvf xdebug.tgz -C /usr/src/xdebug --strip-components=1 \
	&& rm xdebug.tgz \
	&& cd /usr/src/xdebug \
	&& phpize \
	&& ./configure \
	&& make -j"$(nproc)" \
	&& make install \
	&& rm -rf /usr/src/xdebug

#
# clean
#
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /usr/src/php

ADD php/* $PHP_INI_DIR/
ADD php/conf.d/* $PHP_INI_DIR/conf.d/

RUN touch /tmp/clean_cache_4

RUN php -m
EXPOSE 9000
CMD ["php-fpm"]
