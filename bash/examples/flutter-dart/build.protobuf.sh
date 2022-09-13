#!/bin/bash

# ---------------------------------------------
# -- Builds go sources from *.proto files
# --
# -- Assumptions:
# -- 1. protoc installed:
# --    - https://developers.google.com/protocol-buffers/docs/darttutorial
# -- 2. Protobuf package installed:
# --    - https://pub.dev/packages/protobuf/install
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly FLUTTER=$(which flutter)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly PROTOC=$(which protoc)

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# Must be relative path ...
# Relative to $PARENT_DIR
# See https://github.com/wcarmon/docs/blob/main/flutter-dart/protobuf.md
#
# Contains *.proto files,
# we generate *.dart files for each *.proto file
#TODO: revisit the line above
readonly RELATIVE_PROTO_INPUT_DIR=proto

#TODO: revisit the line below
# Root output dir for generated *.pb.go files containing "message"
# Use a dir under the dir containing  pubspec.yaml file
# TODO: FIX: "option go_package" is appended to this path, unless --go_opt=paths=source_relative
readonly PROTO_OUTPUT_DIR="${PARENT_DIR}/src/grpc/foo/api"

#TODO: fix lines below
# Root output dir for generated *.pb.go files containing "rpc"
# Use a dir under the dir containing go.mod file
# "option go_package" is appended to this path, unless --go-grpc_opt=paths=source_relative
readonly GRPC_OUTPUT_DIR="${PARENT_DIR}/src/grpc/foo/api"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Contains pubspec.yaml
readonly PROJ_ROOT="$PARENT_DIR"

readonly PROTO_INPUT_DIR=$(readlink -f "$PARENT_DIR/$RELATIVE_PROTO_INPUT_DIR")

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Generate
# ---------------------------------------------
mkdir -p "$GRPC_OUTPUT_DIR"
mkdir -p "$PROTO_OUTPUT_DIR"

cd $PARENT_DIR >/dev/null 2>&1

echo
echo "|-- Generating go code from proto files in $PROTO_INPUT_DIR"

$PROTOC \
  --dart_out=grpc:lib/src/generated \
  --proto_path="${RELATIVE_PROTO_INPUT_DIR}" \
  --proto_path="${SEARCH_DIR_1}" \
  $RELATIVE_PROTO_INPUT_DIR/*.proto

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See generated dart files in $PROTO_OUTPUT_DIR"
#TODO: revisit lines below
find $PROTO_OUTPUT_DIR -name '*.pb.go' | head -3
echo "..."
