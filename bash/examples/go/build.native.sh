#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local go sdk
# --
# -- Assumptions:
# -- 1. Go SDK installed: https://go.dev/doc/install
# -- 2. wire installed: https://github.com/google/wire
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
readonly WIRE=$(which wire)

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# Relative to dir containing go.mod file
readonly CMD_PACKAGE=./cmd/run-server/...

readonly OUTPUT_BINARY_NAME=foo-service

# Relative to $PROJ_ROOT
readonly RELATIVE_OUTPUT_DIR="bin"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"

readonly GIT_COMMIT=$(
  cd $PROJ_ROOT
  git rev-list -1 HEAD
  #git rev-parse HEAD
)

mkdir -p $PROJ_ROOT/$RELATIVE_OUTPUT_DIR
readonly ABSOLUTE_OUTPUT_DIR=$(readlink -f "$PROJ_ROOT/$RELATIVE_OUTPUT_DIR")

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
echo
echo "|-- Clearing old binaries in $ABSOLUTE_OUTPUT_DIR"
rm -vf $ABSOLUTE_OUTPUT_DIR/${OUTPUT_BINARY_NAME}*.bin
rm -vf $ABSOLUTE_OUTPUT_DIR/${OUTPUT_BINARY_NAME}*.app
rm -vf $ABSOLUTE_OUTPUT_DIR/${OUTPUT_BINARY_NAME}*.exe

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$ABSOLUTE_OUTPUT_DIR"

#$SCRIPTS_DIR/fix_imports.native.sh
#$SCRIPTS_DIR/format.native.sh

cd "$PROJ_ROOT/src" >/dev/null 2>&1
$GO version
$GO mod tidy

# -- TODO: If you use protobuf, run build.protobuf.sh here:
#$SCRIPTS_DIR/build.protobuf.sh

echo
echo "|-- Running wire ..."
$WIRE ./...

echo
echo "|-- Cross compiling go code for $CMD_PACKAGE"

GOWORK=off GOOS=linux GOARCH=amd64 \
  $GO build \
  -o "$ABSOLUTE_OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.bin" \
  -ldflags="-X main.gitCommitHash=${GIT_COMMIT}" \
  $CMD_PACKAGE

GOOS=darwin GOARCH=amd64 \
  $GO build \
  -o "$ABSOLUTE_OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.app" \
  -ldflags="-X main.gitCommitHash=${GIT_COMMIT}" \
  $CMD_PACKAGE

GOOS=windows GOARCH=amd64 \
  $GO build \
  -o "$ABSOLUTE_OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.exe" \
  -ldflags="-X main.gitCommitHash=${GIT_COMMIT}" \
  $CMD_PACKAGE

# NOTE: list architectures:
#   $GO tool dist list;

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See binaries in $ABSOLUTE_OUTPUT_DIR"
ls -hlt $ABSOLUTE_OUTPUT_DIR
