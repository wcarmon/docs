#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via docker container
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

# See https://hub.docker.com/_/golang?tab=tags
# Some debian and alpine binaries are incompatible because of musl libc
# Alpine uses: /lib/ld-musl-x86_64.so
# Debian uses: /lib64/ld-linux-x86-64.so
# So we build both
readonly GOLANG_ALPINE_IMAGE=golang:1.19.0-alpine3.16
readonly GOLANG_DEBIAN_IMAGE=golang:1.19.0-bullseye

# GOTCHA: Leading dot is important
readonly CMD_PACKAGE=./cmd/run-service/...

readonly OUTPUT_BINARY_NAME=foo-service
readonly OUTPUT_DIR="bin"
#readonly CERT_FILE=...

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file should exist
readonly PROJ_ROOT="$PARENT_DIR"

readonly GIT_COMMIT=$(
  cd $PROJ_ROOT
  git rev-list -1 HEAD
  #git rev-parse HEAD
)

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$PROJ_ROOT/$OUTPUT_DIR"

# ---------------------------------------------
# -- Build for Alpine
# ---------------------------------------------
echo
echo "|-- Building binary for Alpine based container image"

$DOCKER run \
  --rm \
  -v "${PROJ_ROOT}/src":/usr/src/myapp \
  --workdir /usr/src/myapp \
  $GOLANG_ALPINE_IMAGE \
  /bin/ash -c "
  set -e
  set -u
  #set -x

  # -- get gcc for alpine
  echo
  echo '|-- [Alpine] Installing build tools'
  apk add build-base

  echo
  echo '|-- [Alpine] Downloading dependencies ...'
  go mod download;
  go mod tidy;
  go install github.com/google/wire/cmd/wire@latest;

  echo
  echo '|-- [Alpine] Running wire ...'
  wire ./...

  echo
  echo '|-- [Alpine] Compiling ...'

  GOOS=linux GOARCH=amd64 \
    go build \
    -o \"$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.alpine.bin\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;
  "

echo
echo '|-- [Alpine] Successfully built binary:'
ls -hlt $PROJ_ROOT/$OUTPUT_DIR/*.alpine.bin

# ---------------------------------------------
# -- Build for everything else
# ---------------------------------------------
echo
echo "|-- Cross compiling via Debian.  sources: $PROJ_ROOT"

$DOCKER run \
  --rm \
  -v "${PROJ_ROOT}/src":/usr/src/myapp \
  --workdir /usr/src/myapp \
  $GOLANG_DEBIAN_IMAGE \
  /bin/bash -c "
  set -e
  set -u
  #set -x

  echo
  echo '|-- [Debian] Downloading dependencies ...'
  go mod download;
  go mod tidy;
  go install github.com/google/wire/cmd/wire@latest;

  echo
  echo '|-- [Debian] Running wire ...'
  wire ./...

  echo
  echo '|-- [Debian] Compiling ...'

  GOOS=linux GOARCH=amd64 \
    go build \
    -o \"$OUTPUT_DIR/$OUTPUT_BINARY_NAME.amd64.bin\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  GOOS=darwin GOARCH=amd64 \
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
#   $GO tool dist list;

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See binaries in $PROJ_ROOT/$OUTPUT_DIR"
ls -hlt "$PROJ_ROOT/$OUTPUT_DIR"

<<'EXAMPLE_WITH_CERT'
  readonly CERT_FILE=my.crt

$DOCKER run \
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
