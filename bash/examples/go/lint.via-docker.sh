#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis via docker container
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------

#set -x # uncomment to debug script
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
readonly LINT_IMAGE=golangci/golangci-lint:v1.46.2-alpine
#readonly LINT_IMAGE=golangci/golangci-lint:v1.46.2

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT=$PARENT_DIR
readonly SOURCES_ROOT=$PROJ_ROOT/src

#readonly CERT_FILE="${PROJ_ROOT}/foo.crt"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Lint (static analysis)
# ---------------------------------------------
echo
echo "|-- Analyzing code in ${SOURCES_ROOT}"

$DOCKER_BINARY run \
  --rm \
  -v "${SOURCES_ROOT}":/app \
  --workdir /app \
  $LINT_IMAGE \
  golangci-lint run ./...
