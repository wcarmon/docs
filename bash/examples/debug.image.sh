#!/bin/bash

# ---------------------------------------------
# --
# -- Starts & enters an image (for debugging)
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------

#set -x
set -e
set -o pipefail
set -u


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
readonly DOCKER_BINARY=$(which docker)


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
