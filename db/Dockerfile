# replace TIME_ZONE variable for your time zone region
ARG TIME_ZONE=America/Lima

ARG MARIA_DB_VERSION=10.2.29
FROM mariadb:${MARIA_DB_VERSION}

ENV TZ=${TIME_ZONE}

RUN cp /usr/share/zoneinfo/America/Lima /etc/localtime
RUN echo "${TIME_ZONE}" >  /etc/timezone

# Copy migration script
COPY import_db.sh /usr/local/bin/import_db.sh

# Copy database file into root directory
COPY inventory.sql .

# Dar permisos de ejecución al script
RUN chmod +x /usr/local/bin/import_db.sh
