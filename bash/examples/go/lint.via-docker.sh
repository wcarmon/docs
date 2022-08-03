#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis via docker container
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------

#set -x # trace commands
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
# See https://hub.docker.com/r/golangci/golangci-lint/tags
readonly GOLANGCI_IMAGE=golangci/golangci-lint:v1.46.2-alpine
#readonly GOLANGCI_IMAGE=golangci/golangci-lint:v1.46.2

# See https://hub.docker.com/r/returntocorp/semgrep
readonly SEMGREP_IMAGE=returntocorp/semgrep

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"
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
  -v "${SOURCES_ROOT}:/src" \
  $SEMGREP_IMAGE \
  semgrep scan \
  --config "p/ci" \
  --config "p/docker" \
  --config "p/golang" \
  --config "p/jwt" \
  --config "p/r2c-ci" \
  --config "p/trailofbits" \
  --disable-version-check \
  --jobs 4 \
  --metrics=off \
  --timeout 30 \
  --use-git-ignore

$DOCKER_BINARY run \
  --rm \
  -v "${SOURCES_ROOT}":/app \
  --workdir /app \
  $GOLANGCI_IMAGE \
  golangci-lint run ./... \
  --color auto \
  --concurrency 6 \
  --sort-results \
  --tests true \
  --timeout 1m30s
