#!/bin/bash

# ---------------------------------------------
# -- Auto format the go files via docker container
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
#readonly GOLANG_IMAGE=golang:1.19.0-bullseye
readonly GOLANG_IMAGE=golang:1.19.0-alpine3.16

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

#readonly CERT_FILE="${PARENT_DIR}/foo.crt"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Format
# ---------------------------------------------
echo
echo "|-- Formatting code in ${PROJ_ROOT}/src"

# NOTE: mount volume for cert if required
#  eg.  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt:ro \
$DOCKER run \
  --rm \
  -v "${PROJ_ROOT}/src":/usr/src/myapp:rw \
  --workdir /usr/src/myapp \
  $GOLANG_IMAGE \
  gofmt -s -e -w .
