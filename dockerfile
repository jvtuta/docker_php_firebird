FROM php:8.0-apache 

WORKDIR /src

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions pdo_firebird

COPY ./interbase.so /usr/local/lib/php/extensions/no-debug-non-zts-20200930/
COPY ./interbase.ini /usr/local/etc/php/conf.d/


