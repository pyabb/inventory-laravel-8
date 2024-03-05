ARG PHP_VERSION=7.4.33-cli-bullseye
FROM php:${PHP_VERSION}

RUN apt-get update && apt-get install tzdata

ENV TZ=America/Lima

RUN cp /usr/share/zoneinfo/America/Lima /etc/localtime
RUN echo "America/Lima" >  /etc/timezone

RUN apt-get install -y libicu-dev libpng-dev libfreetype-dev libjpeg62-turbo-dev libzip-dev
RUN docker-php-ext-configure intl && docker-php-ext-install intl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd

RUN docker-php-ext-install zip
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql

ARG USERNAME=appuser
RUN groupadd -g 1000 ${USERNAME} \
    && useradd -u 1000 -g ${USERNAME} -m -s /sbin/nologin ${USERNAME}

# If you need to install Composer, uncomment the following lines of code, then update the Composer file hash from:
# https://getcomposer.org/download/

#ARG COMPOSER_FILE_HASH=dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '${COMPOSER_FILE_HASH}') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
#RUN php -r "unlink('composer-setup.php');"

WORKDIR /var/www/html
#COPY . /var/www/html

# Copy migration script
COPY init.sh /usr/local/bin/init.sh

# Dar permisos de ejecución al script
RUN chmod +x /usr/local/bin/init.sh

USER ${USERNAME}
