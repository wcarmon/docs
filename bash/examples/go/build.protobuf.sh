#!/bin/bash

# ---------------------------------------------
# -- Builds go sources from *.proto files
# ---------------------------------------------
#set -x # uncomment to debug
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# Contains *.proto files, we generate *.pb.go files for each
readonly PROTO_INPUT_DIR=$HOME/dir/with/protos
#readonly PROTO_INPUT_DIR=$PARENT_DIR/../protos


# Root output dir for generated *.pb.go files
# eg. Use the dir containing go.mod file
# "option go_package" is appended to this path
readonly PROTO_OUTPUT_DIR=$HOME/src

# Paths containing *.proto files
# For resolving imports in other *.proto files
#readonly SEARCH_PATH1=$HOME/opt/protobuf/include;
#readonly SEARCH_PATH2=$HOME/another/path;

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

# If needed, add flags like --proto_path=$SEARCH_PATH1

# -- See generated *.pb.go files
#find $PROTO_OUTPUT_DIR -name '*.pb.go'
