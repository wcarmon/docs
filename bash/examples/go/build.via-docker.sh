#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via docker container
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------

#set -x # uncomment to debug
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

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

# See https://hub.docker.com/_/golang?tab=tags
#readonly GOLANG_IMAGE=golang:1.19.0-alpine3.16
readonly GOLANG_IMAGE=golang:1.19.0-bullseye

# GOTCHA: Leading dot is important
readonly CMD_PACKAGE=./src/cmd/run-service/

readonly OUTPUT_BINARY_NAME=foo-service

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

readonly OUTPUT_DIR="bin"

#readonly CERT_FILE=...
readonly GIT_COMMIT=$(
  cd $PROJ_ROOT
  git rev-list -1 HEAD
)
#readonly GIT_COMMIT=$(cd $PROJ_ROOT; git rev-parse HEAD)

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$PROJ_ROOT/$OUTPUT_DIR"

echo "|-- Cross compiling go code in $PROJ_ROOT"

$DOCKER_BINARY run \
  --rm \
  -v "${PROJ_ROOT}":/usr/src/myapp \
  --workdir /usr/src/myapp \
  $GOLANG_IMAGE \
  /bin/bash -c "
  set -e
  set -u
  #set -x

  go mod tidy;

  go install github.com/google/wire/cmd/wire@latest;
  wire ./src/...

  echo '-- Compiling...'
  GOOS=linux   GOARCH=amd64 \
    go build \
    -o \"$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.bin\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  GOOS=darwin  GOARCH=amd64 \
    go build \
    -o \"$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.app\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  GOOS=windows GOARCH=amd64 \
    go build \
    -o \"$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.exe\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;
  "

# NOTE: list architectures:
#   go tool dist list;

echo "|-- See binaries in $PROJ_ROOT/$OUTPUT_DIR"
ls -dhlt "$PROJ_ROOT/$OUTPUT_DIR"/*

<<'EXAMPLE_WITH_CERT'
  readonly CERT_FILE=my.crt

$DOCKER_BINARY run \
  --rm \
  -v "${PROJ_ROOT}":/usr/src/myapp \
  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt \
  --workdir /usr/src/myapp \
  $GOLANG_IMAGE \
  /bin/bash -c "
  update-ca-certificates;
  go install github.com/google/wire/cmd/wire@latest;
  wire ./...

  echo '-- Compiling...'
  GOOS=linux   GOARCH=amd64 \
    go build \
    -o \"$OUTPUT_DIR/$OUTPUT_BINARY_NAME.linux.amd64\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  ... other OS...
  "
EXAMPLE_WITH_CERT
