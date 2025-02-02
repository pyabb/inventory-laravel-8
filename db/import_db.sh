#!/bin/sh

# Variables
MYSQL_ROOT_PASSWORD="password9"

# Waiting for mysql server availability
until mysql -u root -p$MYSQL_ROOT_PASSWORD -e ";" > /dev/null 2>&1; do
  echo "MySQL is unavailable - sleeping"
  sleep 1
done

# Mysql server available message
echo "MySQL is up - importing database"

# Import inventory database
mysql -u root -p$MYSQL_ROOT_PASSWORD < inventory.sql
