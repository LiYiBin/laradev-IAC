FROM php:7.1.4-apache

# Install iconv, mcrypt, and gd
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN rm /etc/apache2/sites-available/*
RUN rm /etc/apache2/sites-enabled/*

COPY ./vhost.conf /etc/apache2/sites-enabled/vhost.conf

RUN usermod -u 1000 www-data