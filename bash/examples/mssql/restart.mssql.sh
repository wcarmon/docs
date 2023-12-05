#!/bin/bash

# ---------------------------------------------
# -- Runs sql server in local container
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. local *.sql file(s) with schema (SQL CREATE TABLE statements)
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# --------------------------------------------
# -- Constants
# --------------------------------------------

# --------------------------------------------
# -- Config
# --------------------------------------------
readonly CONTAINER_NAME="mssql_for_foobar"
readonly DB_PASS="bacon4321"
readonly DB_PORT=1433
readonly PROJECT_DIR="$HOME/tmp/foobar"

# Developer | Express | Standard
readonly PRODUCT_ID="Developer"

readonly MSSQL_IMAGE="mcr.microsoft.com/mssql/server:2022-latest"
#readonly MSSQL_IMAGE="mcr.microsoft.com/mssql/server:2022-preview-ubuntu-22.04"

#readonly SQL_FOR_CREATE_TABLES="$HOME/tmp/foobar/mssql_create_table.sql"
#readonly SQL_FOR_FOREIGN_KEYS="$HOME/tmp/foobar/foreign_keys.sql"


# --------------------------------------------
# -- Derived
# --------------------------------------------
readonly DB_HOSTNAME=$(hostname)

# --------------------------------------------
# -- Run
# --------------------------------------------
#cd "$PROJECT_DIR" >/dev/null 2>&1

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# -- See https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&pivots=cs1-bash
# -- See https://hub.docker.com/_/microsoft-mssql-server

set -x # uncomment to debug script

docker run \
--detach \
--hostname $DB_HOSTNAME \
--name $CONTAINER_NAME \
--restart always \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_PID=$PRODUCT_ID" \
-e "MSSQL_SA_PASSWORD=$DB_PASS" \
-p $DB_PORT:1433 \
$MSSQL_IMAGE

# TODO: mount volumes

#  -e POSTGRES_DB="$DB_NAME" \
#  -e POSTGRES_USER="$DB_USER" \
#  -v "$SQL_FOR_CREATE_TABLES":/docker-entrypoint-initdb.d/000.setup.sql:ro \
#  -v "$SQL_FOR_FOREIGN_KEYS":/docker-entrypoint-initdb.d/010.fk.sql:ro \

# --------------------------------------------
# -- Report
# --------------------------------------------
sleep 2  # allow time to start
docker ps --filter name=$CONTAINER_NAME

docker logs $CONTAINER_NAME
# TODO: wait for message: "database system is ready to accept connections"

# --------------------------------------------
# -- Connect
# --------------------------------------------
# TODO: example connection via local client

# user = mssql
# user = SA
# user = sa

#sudo docker exec -it sql1 "bash"
#/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "<YourNewStrong@Passw0rd>"
#  /opt/mssql-tools/bin/sqlcmd -S localhost -U SA

# /var/opt/mssql/log/errorlog

#sqlcmd -S localhost,1433 -U sa -P Your_Password_Here