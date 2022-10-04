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

# Dir, Contains *.proto with model messages
readonly MODEL_PROTOS_DIR="${RELATIVE_PROTO_INPUT_DIR}/model"

# Dir, Contains *.proto with rpc, request, response messages and services
readonly GRPC_PROTOS_DIR="${RELATIVE_PROTO_INPUT_DIR}/rpc"

# Dir to write *_gen.pb.go files for model messages
# Use a sub directory under the dir containing go.mod file
# "option go_package" is appended to this path, unless --go_opt=paths=source_relative
readonly MODEL_GO_CODE_OUTPUT_DIR="${PARENT_DIR}/src/serde/pb"

# Dir to write *_gen.pb.go files for rpc, request, response messages & services
# Use a sub directory under the dir containing go.mod file
# "option go_package" is appended to this path, unless --go_opt=paths=source_relative
readonly GRPC_GO_CODE_OUTPUT_DIR="${PARENT_DIR}/src/grpc/foo/api"

# Paths containing more *.proto files
# For resolving imports in other *.proto files
#readonly SEARCH_DIR_1=$HOME/opt/protobuf/include
#readonly SEARCH_DIR_2=$HOME/another/path

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Generate dependencies
# ---------------------------------------------
#TODO: if you depend on other protos, build them here

# ---------------------------------------------
# -- Generate
# ---------------------------------------------
mkdir -p $MODEL_GO_CODE_OUTPUT_DIR
mkdir -p $GRPC_GO_CODE_OUTPUT_DIR

cd $PROJ_ROOT >/dev/null 2>&1

echo
echo "|-- Generating go code for model protos in $MODEL_PROTOS_DIR"
$PROTOC \
  --go_opt=paths=source_relative \
  --go_out="$MODEL_GO_CODE_OUTPUT_DIR" \
  --proto_path="${MODEL_PROTOS_DIR}" \
  $MODEL_PROTOS_DIR/*.proto

echo
echo "|-- Generating go code for rpc proto files in $GRPC_PROTOS_DIR"
$PROTOC \
  --go-grpc_opt=paths=source_relative \
  --go-grpc_out="${GRPC_GO_CODE_OUTPUT_DIR}" \
  --go_opt=paths=source_relative \
  --go_out="${GRPC_GO_CODE_OUTPUT_DIR}" \
  --proto_path="${GRPC_PROTOS_DIR}" \
  --proto_path="${MODEL_PROTOS_DIR}" \
  $GRPC_PROTOS_DIR/*.proto

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See generated model go files in $MODEL_GO_CODE_OUTPUT_DIR"
find $MODEL_GO_CODE_OUTPUT_DIR -name '*.pb.go' | head -5
echo "..."

echo
echo "|-- See generated rpc go files in $GRPC_GO_CODE_OUTPUT_DIR"
find $GRPC_GO_CODE_OUTPUT_DIR -name '*.pb.go' | head -5
echo "..."
