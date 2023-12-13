#!/bin/bash

# ---------------------------------------------
# -- Stop all test containers
# --
# -- Assumptions:
# -- 1. docker installed
# -- 2. test containers all have some prefix
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------


# ---------------------------------------------
# -- Config
# ---------------------------------------------


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Stop & rm
# ---------------------------------------------
docker ps -q --filter "name=test_mssql*" | xargs docker stop || true
docker ps -q --filter "name=test_pg*" | xargs docker stop || true

docker rm $(docker ps --filter status=exited -q) || true

# ---------------------------------------------
# -- Report
# ---------------------------------------------
docker ps;
