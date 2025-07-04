ARG PHP_VERSION=7.4.33-cli-bullseye
FROM php:${PHP_VERSION}

# Update and install php extension for the project
RUN apt-get update
RUN apt-get install -y libicu-dev libpng-dev libfreetype-dev libjpeg62-turbo-dev libzip-dev
RUN docker-php-ext-configure intl && docker-php-ext-install intl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo_mysql

# Create appuser
ARG USERNAME=appuser
RUN groupadd -g 1000 ${USERNAME} \
    && useradd -u 1000 -g ${USERNAME} -m -s /sbin/nologin ${USERNAME}

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Node.js
COPY --from=node:14 /usr/local/bin/node /usr/local/bin/node
COPY --from=node:14 /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# Set work directory and copy project to image
WORKDIR /var/www/html
COPY . .

# Install dependencias
RUN composer install --no-dev --optimize-autoloader
RUN npm install
RUN npm run production

RUN chown -R ${USERNAME}:${USERNAME} /var/www/html

# Modified permissions init.sh script
COPY --chown=${USERNAME}:${USERNAME} init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

USER ${USERNAME}

CMD ["/usr/local/bin/init.sh"]
