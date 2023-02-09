#!/bin/bash

# ---------------------------------------------
# -- Runs main func via local go sdk
# --
# -- Assumptions:
# -- 1. Go SDK installed: https://go.dev/doc/install
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly GO=$(which go)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"

# Relative to dir containing go.mod file
readonly CMD_PACKAGE=./cmd/run-server/...

readonly CONFIG_FILE=$PROJ_ROOT/app.conf.toml

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Run
# ---------------------------------------------
cd "$PROJ_ROOT/src" >/dev/null 2>&1

#TODO: pass the dir for config files
$GO run $CMD_PACKAGE $CONFIG_FILE
