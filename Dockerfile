#-----------------------------
# App: PHP-FPM base image
#-----------------------------
FROM php:8-apache as php-apache

# Install and configure PHP-FPM basic image dependencies
RUN apt-get update && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends zlib1g-dev libicu-dev libpq-dev g++ unzip git nodejs openssh-client wget nano && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    docker-php-ext-install pdo_pgsql && \
    docker-php-ext-configure opcache && \
    docker-php-ext-install opcache && \
    wget https://getcomposer.org/download/latest-stable/composer.phar && \
    mv composer.phar /bin/composer && \
    npm install --global yarn

VOLUME /var/www/html

EXPOSE 80 443 9000