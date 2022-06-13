#!/bin/bash

# ---------------------------------------------
# --
# -- Runs tests via docker container
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
readonly GOLANG_IMAGE=golang:1.18.3-bullseye

# Dir contains go.mod file
readonly PROJ_ROOT=$PARENT_DIR


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Test
# ---------------------------------------------
echo
echo "|-- Running tests in ${PROJ_ROOT}"

$DOCKER_BINARY run \
  --rm \
  -it \
  -v "$PROJ_ROOT":/usr/src/myapp \
  --workdir /usr/src/myapp \
  $GOLANG_IMAGE \
  go test ./...

<<EXAMPLE_WITH_CERT
  readonly CERT_FILE=my.crt

  $DOCKER_BINARY run \
    --rm \
    -it \
    -v "$PROJ_ROOT":/usr/src/myapp \
    -v "$CERT_FILE":/usr/local/share/ca-certificates/extra.crt \
    --workdir /usr/src/myapp \
    $GOLANG_IMAGE \
    update-ca-certificates && \
    go test ./...
EXAMPLE_WITH_CERT
