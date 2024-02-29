ARG PHP_VERSION=7.4.30-fpm-alpine3.16
FROM php:${PHP_VERSION}

RUN apk update && apk add tzdata

ENV TZ=America/Lima

RUN cp /usr/share/zoneinfo/America/Lima /etc/localtime
RUN echo "America/Lima" >  /etc/timezone

RUN apk add --no-cache icu-dev libpng-dev freetype-dev libjpeg-turbo-dev zlib-dev libzip-dev
RUN docker-php-ext-configure intl && docker-php-ext-install intl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd
RUN docker-php-ext-install zip

RUN docker-php-ext-install mysqli pdo pdo_mysql

ARG USERNAME=appuser
RUN addgroup -g 1000 ${USERNAME} \
    && adduser -D -u 1000 -G ${USERNAME} -h /home/${USERNAME} -s /sbin/nologin ${USERNAME}

# If you need to install Composer, uncomment the following lines of code, then update the Composer file hash from:
# https://getcomposer.org/download/

#ARG COMPOSER_FILE_HASH=dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '${COMPOSER_FILE_HASH}') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
#RUN php -r "unlink('composer-setup.php');"

# Define work directory and copy data
WORKDIR /var/www/html
COPY . /var/www/html

# Clone .env file to load enviromnet variblaes into project
COPY .env.example .env

USER ${USERNAME}
