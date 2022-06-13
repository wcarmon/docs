#!/bin/bash

# ---------------------------------------------
# --
# -- Runs main func via local go sdk
# --
# ---------------------------------------------

#set -x
set -e
set -o pipefail
set -u


# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT
CONFIG_FILE=./app.config.yaml
CMD_PACKAGE=./cmd/run-service/...

# Dir contains go.mod file
readonly PROJ_ROOT=$(dirname "${BASH_SOURCE[0]}")/..


# ---------------------------------------------
# -- Run
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

go run $CMD_PACKAGE $CONFIG_FILE
