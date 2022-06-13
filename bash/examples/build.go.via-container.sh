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
readonly CMD_PACKAGE=./cmd/run-service
readonly OUTPUT_BINARY_NAME=foo-service

# Dir contains go.mod file
readonly PROJ_ROOT=$PARENT_DIR


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly OUTPUT_DIR="$PROJ_ROOT/bin"

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p $OUTPUT_DIR

TODO: call docker here


# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries in $(pwd)/bin"
