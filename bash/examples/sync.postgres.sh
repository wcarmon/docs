#!/bin/bash

# ---------------------------------------------
# -- Copies data from one postgres table to another
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. Caller exports or sets SOURCE_DB_PASS and DEST_DB_PASS before calling
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
#readonly POSTGRES_IMAGE="postgres:15.2-alpine"
readonly POSTGRES_IMAGE="postgres:14.8-alpine"

readonly SOURCE_DB_HOST="src-db.bar.com"
readonly SOURCE_DB_NAME="postgres"
readonly SOURCE_DB_PORT=5432
readonly SOURCE_DB_USER="postgres"
readonly SOURCE_TABLE="my_schema.my_table"

readonly DEST_DB_HOST="sink-db.bar.com"
readonly DEST_DB_NAME="postgres"
readonly DEST_DB_PASS="foobar"
readonly DEST_DB_PORT=5432
readonly DEST_DB_USER="postgres"

# -- NOTE: caller must set SOURCE_DB_PASS
# -- NOTE: caller must set DEST_DB_PASS
# eg. export SOURCE_DB_PASS="quux"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Pull
# ---------------------------------------------
# -- See https://www.postgresql.org/docs/current/app-pgdump.html

$DOCKER run \
--network host \
$POSTGRES_IMAGE \
/bin/bash -c "
echo
echo '|-- Exporting from postgres on $SOURCE_DB_HOST'

PGPASSWORD='$SOURCE_DB_PASS' /usr/local/bin/pg_dump \
--data-only \
--format=plain \
--host='$SOURCE_DB_HOST' \
--no-owner \
--no-password \
--port=$SOURCE_DB_PORT \
--table='$SOURCE_TABLE' \
--username='$SOURCE_DB_USER' \
$SOURCE_DB_NAME > /tmp/pgdump.sql

echo
echo '|-- Importing to postgres on $DEST_DB_HOST'

PGPASSWORD='$DEST_DB_PASS' /usr/local/bin/psql \
--host='$DEST_DB_HOST' \
--port=$DEST_DB_PORT \
--username='$SOURCE_DB_USER' \
$DEST_DB_NAME < /tmp/pgdump.sql
"
