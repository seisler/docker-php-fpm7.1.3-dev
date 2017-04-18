FROM php:7.1.3-fpm

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

WORKDIR "/"

COPY start.sh /start.sh

# composer
COPY composer/composer /usr/local/bin/composer

# php
COPY pool.d/www.conf /etc/php/7.1/fpm/pool.d/www.conf
COPY php.ini /etc/php/7.1/fpm/php.ini
COPY php.ini /usr/local/etc/php/php.ini
COPY cli/php.ini /etc/php/7.1/cli/php.ini

# xdebug
COPY xdebug/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY xdebug/xdebug-2.5.3.tgz /xdebug-2.5.3.tgz
COPY xdebug/xdebug.sh /xdebug.sh

RUN echo "\nexport TERM=xterm" >> /etc/bash.bashrc \
 && apt-get update && apt-get install -y --no-install-recommends \
    apt-utils

RUN echo '\n\
deb http://packages.dotdeb.org jessie all\n\
deb-src http://packages.dotdeb.org jessie all\n'\
>> /etc/apt/sources.list

# extra packages
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 7E3F070089DF5277 \
 && apt-get update && apt-get install -y --no-install-recommends \
    zip \
    unzip \
    git-core \
    vim \
    telnet \
    tar \
 && rm -rf /var/lib/apt/lists/*

# xdebug installation
RUN chmod +x /xdebug.sh && /xdebug.sh

EXPOSE 9000

CMD ["/start.sh"]
