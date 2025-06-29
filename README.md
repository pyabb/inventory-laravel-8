
# Project Inventory Laravel
This project is based on
<a href="https://www.youtube.com/watch?v=dqBLvR7lC8k" target="_blank">INVENTORY</a>
and has been adapted for easier installation in environments such as XAMPP, cPanel, and Docker. Adjustments have been made to optimize deployment and compatibility, ensuring a more accessible experience for various use cases.

## Laravel Upgrade History

This project has been progressively upgraded through multiple Laravel versions to maintain compatibility and take advantage of new features and improvements:

* Laravel 5.5 → 5.6: Minor updates and security fixes.
* Laravel 5.6 → 5.7: Added new middleware features and improvements in error handling.
* Laravel 5.7 → 5.8: Improved email validation, automatic policy discovery, and performance optimizations.
* Laravel 5.8 → 6.x: Transitioned to LTS (Long-Term Support), replaced str_slug() with Str::slug(), and introduced improved job middleware.
* Laravel 6.x → 7.x: Added Laravel Airlock (now Sanctum), better routing speed, Blade component tags, and fluent string operations.
* Laravel 7.x → 8.x: Introduced Laravel Jetstream, model factory classes, migration squashing, and rate limiting improvements.

## Important Changes
If you are upgrading from an older version, please consider the following adjustments:

* The str_slug() helper function has been removed in Laravel 6. Instead, use Str::slug().
* swiftmailer/swiftmailer has been deprecated in favor of symfony/mailer.
* symfony/debug has been replaced with symfony/error-handler.
* The default CSRF directive has been updated from {{ csrf_field() }} to @csrf for better readability and maintainability.
* Laravel 8 requires PHP 7.3 or higher.
* Model factories have been completely redesigned in Laravel 8. The new class-based factory implementation provides better type-hinting and support for named arguments.
* Models are now placed in the App\Models directory by default in Laravel 8.
* Route definitions now use class name syntax for controller references (e.g., `UserController::class` instead of 'UserController').
* Laravel 8 includes a new maintenance mode experience with pre-rendered views.

## Installation

* [Docker installation](#Docker-installation)
* [Cpanel installation](#Cpanel-installation)
* [Xampp installation](#Xampp-installation)

## Docker installation

### Requirements

Your system needs the following programs:
* Docker
* Docker Compose
* Make

### Steps

Clone the project from the repository url.
```shell
git clone <repository url>
```

Enter the directory.
```shell
cd <directory name>
```

Before running the make commands, you need create a new docker network using the name "inventory".
<br>
If you need change de network name, then you need modify the network in docker compose file.
```shell
docker network create inventory
```

Run `make build` command to build the images for app and db containers.
```shell
make build
```

Run `make up` command to up the containers if the containers are not active.
```shell
make up
```

Run `make db.migrate container=<db_container_name>` command to migrate database information.
<br>
If you need change container name, then you need modify the name in docker compose file.
```shell
make db.migrate container=inventory_db
```

Run `make npm.install container=<db_container_name>` command to install npm dependencies
```shell
make npm.install container=inventory
```

### Makefile
If you need more information about `make` commands for this project, then you need review the Makefile file in this repository.

### Observations
If you are using a 'Windows' operating system, please note that sometimes there may be an issue with networks. Therefore, before creating a new network, you will need to run the following command.
```shell
docker network prune
```
The above command delete all networks.

## Cpanel installation
This files does not need any modification, it includes an .htaccess file for the correct functioning of the routes without needing to alter the structure of the original project.

* Download and import this repository content in your `public_html` directory.
* Import database using the inventory.sql file from `db` directory to your cpanel database.
* In your cpanel set the php version to 7.4. Preferably version ea-7.4 (EasyApache 4).
* Copy the .env.example file and rename it to .env. Then, update the credentials and settings according to your environment.

For production mode set `APP_DEBUG` in `false`

```dotenv
APP_NAME=Inventory
APP_ENV=local
APP_KEY=base64:yru13Kb0wYKh81NezXu2mR9efx33PrawOgfhQ7XcGKM=
APP_DEBUG=true
APP_LOG_LEVEL=debug
APP_URL=https://yourdomain.site

DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=pcajkuwd_inventory
DB_USERNAME=pcajkuwd_root
DB_PASSWORD=Xl34c574B@3L
```

## Xampp installation
The project configuration only allows installation in the htdocs folder and not in child folders.
<br>
This project only works with PHP version 7.3 or higher. It is recommended to download XAMPP with PHP version 7.4 or 8.0.

* Download and import this repository content in your `htdocs` directory.
* Import the database using the inventory.sql file from `db` directory to your phpmyadmin database.
* Copy the .env.example file and rename it to .env. Then, update the credentials and settings according to your environment.

```dotenv
APP_NAME=Inventory
APP_ENV=local
APP_KEY=base64:snRgYbevQFPo68EIDKeUuOTvA1vW3D/M/rm1/8mqC00=
APP_DEBUG=true
APP_LOG_LEVEL=debug
APP_URL=http://localhost/

DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=inventory
DB_USERNAME=root
DB_PASSWORD=
```
* The result of your project structure is like:
  <br> ![](docs/img/structure.JPG)

* Run the URL in your web browser `http://localhost`.
* Remember the new credentials:
  * Email: `admin@inventory.org`
  * Password: `root`
* Enjoy it!

## Summary of Changes
* Upgraded Laravel from 5.5 → 8.x step by step.
* Updated PHP version requirements to 7.3 or higher.
* Switched from `csrf_field()` to `@csrf` for better readability.
* Adjusted deprecated functions and dependencies.
* Restructured model factories to use the new class-based approach.
* Updated routing syntax to use `::class` notation.
* Improved documentation for installation and upgrades.
