#!/bin/bash

# ---------------------------------------------
# -- Builds go sources from *.proto files
# --
# -- Assumptions:
# -- 1. protoc installed:
#       - https://developers.google.com/protocol-buffers/docs/gotutorial#compiling-your-protocol-buffers
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly PROTOC=$(which protoc)

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

# Must be relative path ...
# Relative to $PARENT_DIR
# See https://github.com/wcarmon/docs/blob/main/golang/protobuf.md
#
# Contains *.proto files,
# we generate *.pb.go files for each *.proto file
readonly RELATIVE_PROTO_INPUT_DIR=proto

# Root output dir for generated *.pb.go files
# eg. Use the dir containing go.mod file
# "option go_package" is appended to this path
readonly PROTO_OUTPUT_DIR=${PARENT_DIR}/src

# Paths containing *.proto files
# For resolving imports in other *.proto files
#readonly SEARCH_DIR_1=$HOME/opt/protobuf/include
#readonly SEARCH_DIR_2=$HOME/another/path;

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file should exist
readonly PROJ_ROOT="$PARENT_DIR"

readonly PROTO_INPUT_DIR=$(readlink -f "$PARENT_DIR/$RELATIVE_PROTO_INPUT_DIR")

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Generate
# ---------------------------------------------
mkdir -p "$PROTO_OUTPUT_DIR"

cd $PARENT_DIR >/dev/null 2>&1

echo
echo "|-- Generating go code from proto files in $PROTO_INPUT_DIR"

$PROTOC \
  --proto_path="${RELATIVE_PROTO_INPUT_DIR}" \
  --proto_path="${SEARCH_DIR_1}" \
  --go_out=$PROTO_OUTPUT_DIR \
  $RELATIVE_PROTO_INPUT_DIR/*.proto


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See generated go files in $PROTO_OUTPUT_DIR"
find $PROTO_OUTPUT_DIR -name '*.pb.go' | head -7
echo "..."
