FROM php:7.2-apache
RUN a2enmod rewrite

RUN apt-get update -yqq
RUN apt-get install git wget libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq
RUN apt-get install libgmp-dev

RUN docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache gmp

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

COPY / /var/www/html/

WORKDIR /var/www/html/
RUN php composer.phar install

RUN chown -R www-data:www-data /var/www/html/storage/logs/

EXPOSE 80
