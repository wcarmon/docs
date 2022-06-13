#!/bin/bash

# ---------------------------------------------
# --
# -- Delete docker images created by build.*.sh
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
# TODO: change grep pattern to match your generated images
readonly IMAGE_PATTERN="foo-bar"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly DOCKER_BINARY=$(which docker)


# ---------------------------------------------
# -- Delete
# ---------------------------------------------
echo
echo "|-- Images before Delete:"
$DOCKER_BINARY images -a


$DOCKER_BINARY images -a |
  grep -i $IMAGE_PATTERN |
  awk '{print $3}' |
  xargs docker rmi --force || true


echo
echo "|-- Images after Delete:"
$DOCKER_BINARY images -a
