#!/bin/bash

if [ ! -f ".env" ]; then
    cp .env.example .env
    php artisan key:generate
fi

php artisan config:clear
php artisan cache:clear
php artisan view:clear

exec php artisan serve --host=0.0.0.0 --port=8000
