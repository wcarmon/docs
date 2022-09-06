#!/bin/bash

# ---------------------------------------------
# -- Delete docker images created by build.*.sh
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

# ---------------------------------------------
# -- Delete
# ---------------------------------------------
echo
echo "|-- Images before Delete:"
$DOCKER images -a

$DOCKER images -a |
  grep -i $IMAGE_PATTERN |
  awk '{print $3}' |
  xargs docker rmi --force || true

echo
echo "|-- Images after Delete:"
$DOCKER images -a
