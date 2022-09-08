#!/bin/bash

# ---------------------------------------------
# -- Runs main func via docker image locally
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
readonly IMAGE=myorg/foo:latest

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Run
# ---------------------------------------------
# NOTE: mount volume for cert if required
#  eg.  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt:ro \
$DOCKER run \
  --rm \
  -it \
  $IMAGE
