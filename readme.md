## Project Inventory
The main branch is the 'develop' branch that includes the updates where it was made: the 'dockerization' of the project, fixes for development on `cpanel` and `xampp` platforms.
<br>
When the necessary tests have been carried out, the `merge` corresponding to the `main` branch will be carried out.

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

Before running the make commands, you need create a new docker network using the name "lara5_cbd_inv".
<br>
If you need change de network name, then you need modify the network in docker compose file.
```shell
docker network create lara5_cbd_inv
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
make db.migrate container=lara5_cbd_inv_db
```

Run `make npm.install container=<db_container_name>` command to install npm dependencies
```shell
make npm.install container=lara5_cbd_inv_db
```

### Makefile
If you need more information about `make` commands for this project, then you need review the Makefile file in this repository.

### Observations
If you are using a 'Windows' operating system, please note that sometimes there may be an issue with networks. Therefore, before creating a new network, you will need to run the following command.
```shell
docker network --prune
```
The above command delete all networks.

## Cpanel installation
The compressed file does not need any modification, it includes an .htaccess file for the correct functioning of the routes without needing to alter the structure of the original project.

* Download `db.zip` file from `zip_storag` and import in your cpanel database.
  [Download db.zip](https://raw.githubusercontent.com/pyabb/inventory/develop/zip_storage/db.zip)
* Download `inventory.zip` file from `zip_storage` directory then uncompressed al content in your `public_html` directory.
  [Download inventory.zip](https://raw.githubusercontent.com/pyabb/inventory/develop/zip_storage/inventory.zip)
* In your cpanel set the php version to 7.4. Preferably version ea-7.4 (EasyApache 4).
* Edit .env file, replace data for your database credentials:

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
...