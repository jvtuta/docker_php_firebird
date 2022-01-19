FROM php:8.0-apache 

WORKDIR /src

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions pdo_firebird 

COPY --chown=www-data:www-data --chmod=755 src/ /var/www/painelProdutosFarmacotecnica

ENV APACHE_DOCUMENT_ROOT /var/www/html/public/

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN ln -s /var/www/painelProdutosFarmacotecnica/public public && \
    mv public /var/www/html/

RUN a2enmod rewrite headers


COPY ./interbase.so /usr/local/lib/php/extensions/no-debug-non-zts-20200930/

COPY ./interbase.ini /usr/local/etc/php/conf.d/



