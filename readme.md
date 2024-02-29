## Project
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

Run `make up` command to up the containers.
```shell
make up
```

Run `make db.migrate container=<db_container_name>` command to migrate database information.
<br>
If you need change container name, then you need modify the name in docker compose file.
```shell
make db.migrate container=lara5_cbd_inv_db
```

### Makefile
If you need more information about `make` commands for this project, then you need review the Makefile file in this repository.

### Observations
If you are using a 'Windows' operating system, please note that sometimes there may be an issue with networks. Therefore, before creating a new network, you will need to run the following command.
```shell
docker network --prune
```
The above command delete all networks.