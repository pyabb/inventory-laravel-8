cp .env.example .env
php artisan config:clear
php artisan key:generate
php artisan serve --host 0.0.0.0 --port=8000
