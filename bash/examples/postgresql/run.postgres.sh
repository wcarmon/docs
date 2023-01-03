#!/bin/bash

# ---------------------------------------------
# -- Runs Postgresql in local container
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
readonly CONTAINER_NAME="postgres_for_foobar"
readonly DB_NAME="postgres"
readonly DB_PASS="postgres"
readonly DB_PORT=5432
readonly DB_USER="postgres"
readonly POSTGRES_IMAGE="postgres:15.1-alpine"
readonly PROJECT_DIR="$HOME/tmp/foobar"

readonly SQL_FOR_CREATE_TABLES="$HOME/tmp/foobar/postgres_create_table.sql"
readonly SQL_FOR_FOREIGN_KEYS="$HOME/tmp/foobar/foreign_keys.sql"

# --------------------------------------------
# -- Run
# --------------------------------------------
cd "$PROJECT_DIR" >/dev/null 2>&1

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# GOTCHA: SQL setup scripts only runs when data directory is empty/new
# NOTE: scripts run in alphabetical order

docker run \
  --name $CONTAINER_NAME \
  --detach \
  -e POSTGRES_DB="$DB_NAME" \
  -e POSTGRES_PASSWORD="$DB_PASS" \
  -e POSTGRES_USER="$DB_USER" \
  -p $DB_PORT:5432 \
  -v "$SQL_FOR_CREATE_TABLES":/docker-entrypoint-initdb.d/000.setup.sql:ro \
  -v "$SQL_FOR_FOREIGN_KEYS":/docker-entrypoint-initdb.d/010.fk.sql:ro \
  $POSTGRES_IMAGE

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
#psql -h localhost \
#-p $DB_PORT \
#-U postgres \
#-d postgres \
#-c "DESCRIBE product"
