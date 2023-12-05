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
readonly MSSQL_IMAGE="mcr.microsoft.com/mssql/server:2022-latest"
#readonly MSSQL_IMAGE="mcr.microsoft.com/mssql/server:2022-preview-ubuntu-22.04"

readonly CONTAINER_NAME="mssql_for_foobar"
readonly DB_PORT=1433
readonly ADMIN_PORT=1434

# -- Developer | Express | Standard
readonly PRODUCT_ID="Developer"

# -- GOTCHA: must be complex enough
# -- https://learn.microsoft.com/en-us/sql/relational-databases/security/password-policy?view=sql-server-ver16
readonly DB_PASS="bacon4321!"

#readonly SQL_FOR_CREATE_TABLES="$HOME/tmp/foobar/mssql_create_table.sql"
#readonly SQL_FOR_FOREIGN_KEYS="$HOME/tmp/foobar/foreign_keys.sql"


# --------------------------------------------
# -- Derived
# --------------------------------------------
readonly DB_HOSTNAME=$(hostname)


# --------------------------------------------
# -- Run
# --------------------------------------------
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# -- See https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&pivots=cs1-bash
# -- See https://hub.docker.com/_/microsoft-mssql-server

docker run \
--detach \
--hostname $DB_HOSTNAME \
--name $CONTAINER_NAME \
--restart always \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_PID=$PRODUCT_ID" \
-e "MSSQL_SA_PASSWORD=$DB_PASS" \
-p $ADMIN_PORT:1434 \
-p $DB_PORT:1433 \
$MSSQL_IMAGE

# TODO: mount volumes

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
echo ""
echo "JDBC-url: jdbc:sqlserver://localhost:${DB_PORT}"
echo "user=sa"
echo "port=$DB_PORT"


# TODO: example connection via local client

#sudo docker exec -it sql1 "bash"
#/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "<YourNewStrong@Passw0rd>"
#  /opt/mssql-tools/bin/sqlcmd -S localhost -U SA

# /var/opt/mssql/log/errorlog

#sqlcmd -S localhost,1433 -U sa -P Your_Password_Here