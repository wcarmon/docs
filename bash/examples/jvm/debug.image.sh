#!/bin/bash

# ---------------------------------------------
# -- Starts & enters an image (for debugging)
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

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: change to whatever image/tag you need
readonly IMAGE=golang:1.18-alpine

readonly SHELL_FOR_ALPINE=/bin/ash
readonly SHELL_FOR_DEBIAN=/bin/bash

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Debug
# ---------------------------------------------
echo
echo "|-- Starting shell in container..."
$DOCKER_BINARY run \
  --rm \
  -it \
  $IMAGE \
  $SHELL_FOR_ALPINE

# You are now at a terminal inside the container ...
