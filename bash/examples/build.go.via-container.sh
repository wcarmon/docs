#!/bin/bash

# ---------------------------------------------
# --
# -- Builds local binary via docker container
# --
# ---------------------------------------------

#set -x
set -e
set -o pipefail
set -u


# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER_BINARY=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------


# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

readonly CMD_PACKAGE=./cmd/run-service
readonly GOLANG_IMAGE=golang:1.18.3-bullseye
readonly OUTPUT_BINARY_NAME=foo-service

# Dir contains go.mod file
readonly PROJ_ROOT=$PARENT_DIR


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Inside container:  relative to /usr/src/myapp
# outside container: relative to $PROJ_ROOT
readonly OUTPUT_DIR="bin"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$PROJ_ROOT/$OUTPUT_DIR"

# -- Cross compile
$DOCKER_BINARY run \
  --rm \
  -it \
  -e GOARCH=amd64 \
  -e GOOS=$GOOS \
  -v "${PROJ_ROOT}":/usr/src/myapp \
  --workdir /usr/src/myapp \
  $GOLANG_IMAGE \
  /bin/bash -c "
  GOOS=linux GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.linux.amd64 $CMD_PACKAGE;
  GOOS=darwin GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.macos.amd64 $CMD_PACKAGE;
  GOOS=windows GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.win.amd64.exe $CMD_PACKAGE;
  "

<<EXAMPLE_WITH_CERT
readonly CERT_FILE="my.crt"

$DOCKER_BINARY run \
  --rm \
  -it \
  -v "${PROJ_ROOT}":/usr/src/myapp \
  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt \
  --workdir /usr/src/myapp \
  $GOLANG_IMAGE \
  /bin/bash -c "
  update-ca-certificates;
  GOOS=linux GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.linux.amd64 $CMD_PACKAGE;
  GOOS=darwin GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.macos.amd64 $CMD_PACKAGE;
  GOOS=windows GOARCH=amd64 go build -o $OUTPUT_DIR/$OUTPUT_BINARY_NAME.win.amd64.exe $CMD_PACKAGE;
  "
EXAMPLE_WITH_CERT

# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries in $OUTPUT_DIR"
