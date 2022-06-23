#!/bin/bash

# ---------------------------------------------
# -- Runs main func via local go sdk
# ---------------------------------------------

#set -x # uncomment to debug script
set -e
set -o pipefail
set -u

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER_BINARY=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

CMD_PACKAGE=./src/cmd/run-service/...
CONFIG_FILE=./app.config.yaml

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT=$PARENT_DIR

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Run
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

go run $CMD_PACKAGE $CONFIG_FILE
