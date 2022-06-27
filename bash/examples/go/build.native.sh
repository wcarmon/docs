#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local go sdk
# ---------------------------------------------

#set -x # trace commands
set -e  # exit on first error
set -o pipefail
set -u  # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly WIRE=$(which wire)

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

readonly CMD_PACKAGE=./src/cmd/run-service
readonly OUTPUT_BINARY_NAME=foo-service

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

readonly OUTPUT_DIR="bin"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$PROJ_ROOT/$OUTPUT_DIR"

cd "$PROJ_ROOT" >/dev/null 2>&1

$WIRE ./src/...

echo "|-- Cross compiling go code in $(pwd)"
GOOS=linux    GOARCH=amd64 go build -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.linux.amd64"   $CMD_PACKAGE;
GOOS=darwin   GOARCH=amd64 go build -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.macos.amd64"   $CMD_PACKAGE;
#GOOS=windows GOARCH=amd64 go build -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.win.amd64.exe" $CMD_PACKAGE;

# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries in $PROJ_ROOT/$OUTPUT_DIR"
ls -dhlt "$PROJ_ROOT/$OUTPUT_DIR"/*
