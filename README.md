Dockers
=======

Create Docker image
-------------------

docker build ${PATH_TO_DOCKERFILE} -t ${NAME}

Docker Run Example
------------------

VERSION=13
PREFIX=misc
DB_PREFIX=misc
FOLDER=${PREFIX}-addons
ODOO_CONTAINER=${VERSION}container-${DB_PREFIX}
ODOO_BRANCH=${VERSION}.0
DB_CONTAINER=${VERSION}db
DB_NAME=${DB_PREFIX}.odoo${VERSION}.local
DOCKER_IMAGE=my_odoo

docker run \
-p 8069:8069 \
-p 8072:8072 \
-v /home/n56/work/odoo-${ODOO_BRANCH}/docker/My/conf/:/etc/odoo \
-v /home/n56/work/odoo-${ODOO_BRANCH}/${FOLDER}/:/mnt/it-projects/${FOLDER}/ \
--name $ODOO_CONTAINER \
--link $DB_CONTAINER:db \
--link wdb:wdb -e WDB_SOCKET_SERVER=wdb -e WDB_NO_BROWSER_AUTO_OPEN=True \
-t ${DOCKER_IMAGE}

in order to mount an odoo core repository add:

-v /home/n56/work/odoo-${ODOO_BRANCH}/odoo/addons/point_of_sale/:/usr/lib/python3/dist-packages/odoo/addons/point_of_sale/ \


Some Useful Commands
====================

Create DB container
-------------------

NAME=13db
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name ${NAME} postgres:10

PSQL
----

docker exec -it ${CONTAINER_NAME}  bash

then:

psql -U odoo
\c {db_name}

Restore DB:

PATH_TO_DUMP=/mnt/copy/dump
\i ${PATH_TO_DUMP}
