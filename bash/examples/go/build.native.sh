#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local go sdk
# ---------------------------------------------

#set -x # uncomment to debug script
set -e
set -o pipefail
set -u

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

readonly CMD_PACKAGE=./src/cmd/run-service
readonly OUTPUT_BINARY_NAME=foo-service

# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly OUTPUT_DIR="$PROJ_ROOT/bin"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$PROJ_ROOT/$OUTPUT_DIR"

cd "$PROJ_ROOT" >/dev/null 2>&1

echo "|-- Cross compiling go code in $(pwd)"
GOOS=linux GOARCH=amd64 go build -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.linux.amd64" $CMD_PACKAGE
GOOS=darwin GOARCH=amd64 go build -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.macos.amd64" $CMD_PACKAGE
GOOS=windows GOARCH=amd64 go build -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.win.amd64.exe" $CMD_PACKAGE

# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries in $OUTPUT_DIR"
ls -dhlt "$OUTPUT_DIR"/*
