#!/bin/bash

# ---------------------------------------------
# -- Runs tests via docker container
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
readonly GOLANG_DEBIAN_IMAGE=golang:1.20.0-bullseye

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"

#readonly CERT_FILE="${PROJ_ROOT}/foo.crt"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Test
# ---------------------------------------------
echo
echo "|-- Running tests in ${PROJ_ROOT}/src"

# NOTE: if you have dependency protos, mount the dir volume here
#-v /home/wcarmon/git-repos/go/.../foo-common:/usr/foo-common:ro \

# NOTE: if you have a custom cert:
#    -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt \
$DOCKER run \
  --rm \
  -v "${PROJ_ROOT}/src":/usr/src/myapp:ro \
  --workdir /usr/src/myapp \
  $GOLANG_DEBIAN_IMAGE \
  /bin/bash -c "
    # update-ca-certificates;
    go test ./...
    #go test -short ./...
  "
