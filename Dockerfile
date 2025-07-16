### STAGE 1: Build de frontend con Node 22 y Vite
FROM node:22-alpine AS node_build

WORKDIR /app

# Copiar necessary files to build Vite assets
COPY package*.json vite.config.* ./
COPY resources resources

# Install dependencies and compile assets
RUN npm install && npm run build


### STAGE 2: Build de PHP + Composer
FROM php:8.2-fpm-alpine3.21 AS php_build

RUN apk add --no-cache \
    libpng-dev libjpeg-turbo-dev freetype-dev icu-dev libzip-dev \
    oniguruma-dev git bash curl

# Install necessary PHP extensions
RUN docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install intl gd zip pdo_mysql

# Install Composer
COPY --from=composer:2.2.20 /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

# Remove unnecessary node_build files and install composer dependencias
RUN rm -rf node_modules \
    package*.json \
    vite.config.* \
    resources/js \
    resources/css \
    resources/sass \
    resources/ts \
    && composer install --no-dev --optimize-autoloader


### STAGE 3: Final production only with PHP and assets
FROM php:8.2-fpm-alpine3.21

RUN apk add --no-cache \
    libpng libjpeg-turbo freetype icu libzip oniguruma bash

# Copy PHP extensions
COPY --from=php_build /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=php_build /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d

# Copy proyect code
WORKDIR /var/www/html
COPY --from=php_build /app /var/www/html

# Copy assets
COPY --from=node_build /app/public/build /var/www/html/public/build

# Create secure user
ARG USERNAME=appuser
RUN addgroup -g 1000 ${USERNAME} && \
    adduser -D -u 1000 -G ${USERNAME} -s /sbin/nologin ${USERNAME} && \
    chown -R ${USERNAME}:${USERNAME} storage bootstrap/cache public

# Script to run clear commandas and start server
COPY --chown=${USERNAME}:${USERNAME} init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

USER ${USERNAME}

CMD ["php-fpm"]
