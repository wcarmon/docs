#!/bin/bash

# ---------------------------------------------
# --
# -- Runs static analysis via docker container
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
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
# See https://hub.docker.com/r/golangci/golangci-lint/tags
readonly LINT_IMAGE=golangci/golangci-lint:v1.46.2


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT=$PARENT_DIR


# ---------------------------------------------
# -- Lint
# ---------------------------------------------
$DOCKER_BINARY run \
  --rm \
  -v "${PROJ_ROOT}":/app \
  --workdir /app \
  $LINT_IMAGE \
  golangci-lint run ./...

<<EXAMPLE_WITH_CERT
  readonly CERT_FILE=my.crt

  $DOCKER_BINARY run \
    --rm \
    -it \
    -v "${PROJ_ROOT}":/app \
    -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt \
    --workdir /app \
    $LINT_IMAGE \
    /bin/bash -c "
    update-ca-certificates;
    golangci-lint run ./...
    "

EXAMPLE_WITH_CERT