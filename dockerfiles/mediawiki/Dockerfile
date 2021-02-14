FROM php:7.4.15-apache-buster
RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev \
    && pecl install memcached-3.1.5 apcu-5.1.19 \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable memcached apcu \
    && curl -SO https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.1.tar.gz \
    && tar xzf mediawiki-1.35.1.tar.gz \
    && mv mediawiki-1.35.1/* . \
    && rm -rf mediawiki-1.35.1*
COPY LocalSettings.php /var/www/html/LocalSettings.php
