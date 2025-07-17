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
FROM dunglas/frankenphp:php8.2-alpine

RUN install-php-extensions \
	pdo_mysql \
	gd \
	intl \
	zip \
	opcache

# Copy proyect code
WORKDIR /app
COPY --from=php_build /app /app

# Copy assets
COPY --from=node_build /app/public/build /var/www/html/public/build

RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache
