#!/bin/bash

# ---------------------------------------------
# --
# -- Builds local binary via local go sdk
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
readonly CMD_PACKAGE=./cmd/run-service
readonly OUTPUT_BINARY_NAME=foo-service
readonly PROJ_ROOT=$(dirname "${BASH_SOURCE[0]}")/..


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly OUTPUT_DIR="$PROJ_ROOT/bin"


# ---------------------------------------------
# -- Build
# ---------------------------------------------

cd "$PROJ_ROOT" >/dev/null 2>&1

mkdir -p $OUTPUT_DIR

echo "|-- Cross compiling code in $(pwd)"
GOOS=linux GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.linux.amd64 $CMD_PACKAGE;
GOOS=darwin GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.macos.amd64 $CMD_PACKAGE;
GOOS=windows GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.win.amd64.exe $CMD_PACKAGE;


# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries at $(pwd)/bin"
