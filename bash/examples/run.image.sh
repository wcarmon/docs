#!/bin/bash

# ---------------------------------------------
# --
# -- Runs main func via docker image locally
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
