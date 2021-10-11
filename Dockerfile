#-----------------------------
# App: PHP-FPM base image
#-----------------------------
FROM php:8-fpm as php8-fpm

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
    curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony && \
    npm install --global yarn

COPY --from=composer /usr/bin/composer /usr/bin/composer

VOLUME /var/www/html

EXPOSE 80 443 9000

CMD symfony server:start --port=80
