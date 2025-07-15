### STAGE 1: Build PHP + Composer + Node 14 + npm
FROM php:8.2-fpm-alpine3.21 AS build

# Instalar dependencias necesarias para compilar extensiones PHP
RUN apk add --no-cache \
    libpng-dev libjpeg-turbo-dev freetype-dev icu-dev libzip-dev \
    oniguruma-dev git bash curl

# Instalar extensiones PHP necesarias
RUN docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install intl gd zip pdo_mysql

# Instalar Composer
COPY --from=composer:2.2.20 /usr/bin/composer /usr/bin/composer

# Instalar Node 14 desde Node.js Alpine tarball
RUN curl -fsSL https://unofficial-builds.nodejs.org/download/release/v14.21.3/node-v14.21.3-linux-x64-musl.tar.xz | tar -xJ -C /usr/local --strip-components=1

# Comprobar versiones
RUN node -v && npm -v

WORKDIR /app
COPY . .

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build


### STAGE 2: Producción final sin herramientas de desarrollo
FROM php:8.2-fpm-alpine3.21

# Instalar solo librerías necesarias para ejecutar
RUN apk add --no-cache \
    libpng libjpeg-turbo freetype icu libzip oniguruma bash

# Copiar extensiones PHP ya compiladas
COPY --from=build /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=build /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d

# Copiar solo la app ya preparada
WORKDIR /var/www/html
COPY --from=build /app /var/www/html

# Crear usuario de ejecución
ARG USERNAME=appuser
RUN addgroup -g 1000 ${USERNAME} && \
    adduser -D -u 1000 -G ${USERNAME} -s /sbin/nologin ${USERNAME} && \
    chown -R ${USERNAME}:${USERNAME} storage bootstrap/cache

# Script de inicialización
COPY --chown=${USERNAME}:${USERNAME} init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

USER ${USERNAME}

CMD ["/usr/local/bin/init.sh"]
