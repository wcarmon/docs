#!/bin/bash

# ---------------------------------------------
# -- Starts & enters an image (for debugging)
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
readonly DOCKER=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SHELL_FOR_ALPINE=/bin/ash
readonly SHELL_FOR_DEBIAN=/bin/bash

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: change to whatever image/tag you need
readonly IMAGE=golang:1.19-alpine

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
#readonly CERT_FILE="${PARENT_DIR}/foo.crt"

# ---------------------------------------------
# -- Debug
# ---------------------------------------------
echo "|-- interesting local images: "
$DOCKER images \
  | grep -v "<none>" \
  | grep -v "golangci/golangci-lint" \
  | grep -v "mysql" \
  | grep -v "openapi-generator-cli" \
  | grep -v "postgres" \
  | grep -v "returntocorp/semgrep"

echo
echo "|-- Starting shell in container..."
$DOCKER run \
  --rm \
  -it \
  $IMAGE \
  $SHELL_FOR_ALPINE

# You are now at a terminal inside the container ...
