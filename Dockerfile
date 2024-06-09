FROM ubuntu:24.04
MAINTAINER "Kohana World Team"

# noninteractive to prevent user input forms
ARG DEBIAN_FRONTEND=noninteractive

ARG TZ=Etc/UTC

# Set ENV treavis_test to 1 (true) - This can be used inside Unittests to detrmine the env
ENV TRAVIS_TEST=1;

# Install Required Packages
# First add 'deb-src' so we can 'build-dep'
# Update an upgrade system
# Install (without recommends and silent) basic system tools and required libs
# Add PHP 7.3 repository and install php7.3 with all required extensions
# Finally: install composer and configure services
RUN cp /etc/apt/sources.list /etc/apt/sources.list~ && \
    sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -qq install --no-install-recommends apt-utils software-properties-common htop nano && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get -qq upgrade && \
    apt-get -qq install ca-certificates \
    language-pack-en \
    curl \
    unzip \
    wget \
    gcc \
    git \
    libcurl4-openssl-dev \
    libde265-dev \
    libwebp-dev \
    libmagic-dev \
    libmcrypt-dev \
    libmemcached11 \
    libmemcachedutil2 \
    libmemcached-dev \
    libmagickwand-dev \
    zlib1g-dev \
    zlib1g \
    imagemagick \
    webp \
    tzdata && \
    apt-get -qq install --no-install-recommends \
    redis-server \
    memcached \
    php-dev \
    php-pear && \
    echo "requirepass password" >> /etc/redis/redis.conf && \
    sed -i "s/bind .*/bind 127.0.0.1/g" /etc/redis/redis.conf && \
    pear update-channels && \
    pecl upgrade timezonedb && \
    apt-get -qq install --no-install-recommends \
    php7.3-dev \
    php7.3 \
    php7.3-apcu \
    php7.3-common \
    php7.3-cli \
    php7.3-mbstring \
    php7.3-gd \
    php7.3-mysql \
    php7.3-curl \
    php7.3-xml \
    php7.3-sqlite3 \
    php7.3-opcache \
    php7.3-pgsql \
    php7.3-mysql \
    php7.3-intl \
    php7.3-raphf \
    php7.3-mcrypt \
    php7.3-apcu \
    php7.3-gmagick \
    php7.3-mcrypt \
    php7.3-propro \
    php7.3-redis && \
    update-alternatives --set php /usr/bin/php7.3 && \
    update-alternatives --set phpize /usr/bin/phpize7.3 && \
    update-alternatives --set php-config /usr/bin/php-config7.3 && \
    printf "\n" | pecl install memcache-4.0.5.2  && \
    echo 'extension=memcache.so' >> /etc/php/7.3/cli/php.ini && \
    echo 'apc.enabled=1' >> /etc/php/7.3/cli/php.ini && \
    echo 'apc.enable_cli=1' >> /etc/php/7.3/cli/php.ini && \
    echo "\n" | pecl install xdebug-3.1.6 && \
    echo 'zend_extension=/usr/lib/php/20180731/xdebug.so' >> /etc/php/7.3/cli/php.ini && \
    echo 'xdebug.mode = coverage ' >> /etc/php/7.3/cli/php.ini && \
    apt-get -qq install --no-install-recommends \
    php-curl \
    php-xdebug \
    php-redis \
    php-pear \
    php-yaml \
    php-gd \
    php-http \
    php-raphf \
    php-mcrypt \
    php-mbstring \
    php-memcache \
    php-sqlite3 \
    php-mysql \
    php-pgsql \
    php-apcu \
    php-gmagick && \
    echo 'xdebug.mode = coverage ' >> /etc/php/8.3/cli/php.ini && \
    echo 'apc.enabled=1' >> /etc/php/8.3/cli/php.ini && \
    echo 'apc.enable_cli=1' >> /etc/php/8.3/cli/php.ini && \
    apt-get -qq remove  gcc php-dev php7.3-dev && \
    echo 'Y' | apt -qq autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    mkdir -p /tmp/kohana
