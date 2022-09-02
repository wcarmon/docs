#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local go sdk
# --
# -- Assumptions:
# -- 1. Go SDK installed: https://go.dev/doc/install
# ---------------------------------------------

#set -x # uncomment to debug
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

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
readonly OUTPUT_DIR="bin"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

readonly GIT_COMMIT=$(
  cd $PROJ_ROOT
  git rev-list -1 HEAD
)
#readonly GIT_COMMIT=$(cd $PROJ_ROOT; git rev-parse HEAD)

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$PROJ_ROOT/$OUTPUT_DIR"

cd "$PROJ_ROOT" >/dev/null 2>&1

go mod tidy

# TODO: If you use protobuf, run build.protobuf.sh here

$WIRE ./src/...

echo "|-- Cross compiling go code in $PROJ_ROOT"
GOOS=linux GOARCH=amd64 \
  go build \
  -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.bin" \
  -ldflags="-X main.gitCommitHash=${GIT_COMMIT}" \
  $CMD_PACKAGE

GOOS=darwin GOARCH=amd64 \
  go build \
  -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.app" \
  -ldflags="-X main.gitCommitHash=${GIT_COMMIT}" \
  $CMD_PACKAGE

GOOS=windows GOARCH=amd64 \
  go build \
  -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.exe" \
  -ldflags="-X main.gitCommitHash=${GIT_COMMIT}" \
  $CMD_PACKAGE

# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries in $PROJ_ROOT/$OUTPUT_DIR"
ls -dhlt "$PROJ_ROOT/$OUTPUT_DIR"/*
