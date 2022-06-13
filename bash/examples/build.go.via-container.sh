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
readonly OUTPUT_DIR="$PROJ_ROOT/bin"

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p $OUTPUT_DIR

for GOOS in linux darwin windows;
do
  echo ""
  echo "|-- Building for $GOOS ...";

  $DOCKER_BINARY run \
    --rm \
    -it \
    -e GOARCH=amd64 \
    -e GOOS=$GOOS \
    -v "${PROJ_ROOT}":/usr/src/myapp \
    --workdir /usr/src/myapp \
    $GOLANG_IMAGE \
    go build ./...
done

<<EXAMPLE_WITH_CERT
$DOCKER_BINARY run \
  --rm \
  -it \
  -e GOARCH=amd64 \
  -e GOOS=$GOOS \
  -v "${PROJ_ROOT}":/usr/src/myapp \
  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt \
  --workdir /usr/src/myapp \
  $GOLANG_IMAGE \
  update-ca-certificates && \
  go build ./...
EXAMPLE_WITH_CERT

# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries in $(pwd)/bin"
