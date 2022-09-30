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

# Relative to dir containing go.mod file
# GOTCHA: Leading dot is important
readonly CMD_PACKAGE=./cmd/run-server/...

readonly OUTPUT_BINARY_NAME=foo-server
readonly RELATIVE_OUTPUT_DIR="bin"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"

readonly GIT_COMMIT=$(
  cd $PROJ_ROOT
  git rev-list -1 HEAD
  #git rev-parse HEAD
)

#readonly CERT_FILE="${PROJ_ROOT}/foo.crt"

mkdir -p $PROJ_ROOT/$RELATIVE_OUTPUT_DIR
readonly ABSOLUTE_OUTPUT_DIR=$(readlink -f "$PROJ_ROOT/$RELATIVE_OUTPUT_DIR")

readonly MY_UID=$(id -u)

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
echo
echo "|-- Clearing old binaries in $ABSOLUTE_OUTPUT_DIR"
rm -vf $ABSOLUTE_OUTPUT_DIR/${OUTPUT_BINARY_NAME}*.bin
rm -vf $ABSOLUTE_OUTPUT_DIR/${OUTPUT_BINARY_NAME}*.app
rm -vf $ABSOLUTE_OUTPUT_DIR/${OUTPUT_BINARY_NAME}*.exe

# ---------------------------------------------
# -- Build
# ---------------------------------------------
mkdir -p "$ABSOLUTE_OUTPUT_DIR"

cd "$PROJ_ROOT" >/dev/null 2>&1

# ---------------------------------------------
# -- Build for everything except Alpine
# ---------------------------------------------
echo
echo "|-- [Debian] Cross compiling.  sources: $PROJ_ROOT"

# NOTE: if you have dependency protos, mount the dir volume here
# NOTE: if you have a custom certificate, mount the volume here
#  eg.  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt:ro \
$DOCKER run \
  --rm \
  -v "${ABSOLUTE_OUTPUT_DIR}":/output:rw \
  -v "${PROJ_ROOT}/src":/usr/src/myapp:rw \
  --workdir /usr/src/myapp \
  $GOLANG_DEBIAN_IMAGE \
  /bin/bash -c "
  set -e
  set -u
  #set -x

  update-ca-certificates

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
    -o \"/output/$OUTPUT_BINARY_NAME.amd64.bin\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  GOOS=darwin GOARCH=amd64 \
    go build \
    -o \"/output/$OUTPUT_BINARY_NAME.amd64.app\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  GOOS=windows GOARCH=amd64 \
    go build \
    -o \"/output/$OUTPUT_BINARY_NAME.amd64.exe\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  # -- Fix ownership on output
  chmod -v 777 /output/${OUTPUT_BINARY_NAME}*
  chown -v $MY_UID /output/${OUTPUT_BINARY_NAME}*
  "

# ---------------------------------------------
# -- Build for Alpine
# ---------------------------------------------
# NOTE: if you have dependency protos, mount the dir volume here
# NOTE: mount volume for cert if required
#  eg.  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt:ro \
$DOCKER run \
  --rm \
  -v "${ABSOLUTE_OUTPUT_DIR}":/output:rw \
  -v "${PROJ_ROOT}/src":/usr/src/myapp:rw \
  --workdir /usr/src/myapp \
  $GOLANG_ALPINE_IMAGE \
  /bin/ash -c "
  set -e
  set -u
  #set -x

  #update-ca-certificates

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
    -o \"/output/$OUTPUT_BINARY_NAME.amd64.alpine.bin\" \
    -ldflags=\"-X main.gitCommitHash=${GIT_COMMIT}\" \
    $CMD_PACKAGE;

  # -- Fix ownership on output
  chmod -v 777 /output/${OUTPUT_BINARY_NAME}*.alpine.bin
  chown -v $MY_UID /output/${OUTPUT_BINARY_NAME}*.alpine.bin
  "

# NOTE: list architectures:
#   $GO tool dist list;

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Successfully built.  See binaries in $ABSOLUTE_OUTPUT_DIR"
ls -hlt "${ABSOLUTE_OUTPUT_DIR}/${OUTPUT_BINARY_NAME}"*
