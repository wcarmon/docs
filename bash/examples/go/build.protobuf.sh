#!/bin/bash

# ---------------------------------------------
# -- Builds go sources from *.proto files
# ---------------------------------------------

#set -x # uncomment to debug
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# Contains proto files we generate
PROTO_INPUT_DIR=$HOME/git-repos/go/src/chrono/proto

# "option go_package" is appended to this path
PROTO_OUTPUT_DIR=$HOME/git-repos/go/src/chrono

# For resolving imports in proto files
#SEARCH_PATH1=$HOME/opt/protobuf/include;

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Generate
# ---------------------------------------------
mkdir -p $PROTO_OUTPUT_DIR

echo
echo "|-- Generating go code from proto files in $PROTO_INPUT_DIR"
protoc \
  --proto_path=$PROTO_INPUT_DIR \
  --go_out=$PROTO_OUTPUT_DIR \
  $PROTO_INPUT_DIR/*.proto

# -- See generated *.pb.go files
#find $PROTO_OUTPUT_DIR -name '*.pb.go'
