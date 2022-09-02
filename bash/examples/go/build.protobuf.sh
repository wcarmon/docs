#!/bin/bash

# ---------------------------------------------
# -- Builds go sources from *.proto files
# --
# -- Assumptions:
# -- 1. protoc installed:
#       https://developers.google.com/protocol-buffers/docs/gotutorial#compiling-your-protocol-buffers
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

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

# Contains *.proto files,
# we generate *.pb.go files for each *.proto file
#readonly PROTO_INPUT_DIR=$(readlink -f "$PARENT_DIR/proto")
readonly PROTO_INPUT_DIR=$HOME/fix/dir/with/proto

# Root output dir for generated *.pb.go files
# eg. Use the dir containing go.mod file
# "option go_package" is appended to this path
readonly PROTO_OUTPUT_DIR=$PARENT_DIR/src

# Paths containing *.proto files
# For resolving imports in other *.proto files
#readonly SEARCH_PATH1=$HOME/opt/protobuf/include;
#readonly SEARCH_PATH2=$HOME/another/path;

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file should exist
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Generate
# ---------------------------------------------
mkdir -p "$PROTO_OUTPUT_DIR"

cd "$PROJ_ROOT/src" >/dev/null 2>&1

echo
echo "|-- Generating go code from proto files in $PROTO_INPUT_DIR"

protoc \
  --proto_path=$PROTO_INPUT_DIR \
  --go_out=$PROTO_OUTPUT_DIR \
  $PROTO_INPUT_DIR/*.proto

# If needed, add flags like --proto_path=$SEARCH_PATH1

echo
echo "|-- See generated go files in $PROTO_OUTPUT_DIR"
find $PROTO_OUTPUT_DIR -name '*.pb.go' | head -10
echo "..."
