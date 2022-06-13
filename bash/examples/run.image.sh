#!/bin/bash

# ---------------------------------------------
# --
# -- Runs tests via docker image locally
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
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------


# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly IMAGE=myorg/foo:latest


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly DOCKER_BINARY=$(which docker)


# ---------------------------------------------
# -- Run
# ---------------------------------------------
$DOCKER_BINARY run \
  --rm \
  -it \
  $IMAGE
