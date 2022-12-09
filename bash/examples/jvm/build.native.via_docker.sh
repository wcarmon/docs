#!/bin/bash

# ---------------------------------------------
# -- Builds native image via docker
# --
# --
# -- TODO: assumptions
# --
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
# See https://github.com/graalvm/container/pkgs/container/native-image
readonly DOCKER_IMAGE_FOR_NATIVE_IMAGE="ghcr.io/graalvm/native-image:muslib-ol9-java17"

#TODO: rename
readonly BINARY_NAME="bacon.bin"

readonly JARS_DIR="${PARENT_DIR}/build/libs"
readonly OUTPUT_DIR="${PARENT_DIR}/build/native"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1
mkdir -p $OUTPUT_DIR;


# TODO: how to get shell?
#$DOCKER run --rm -it $DOCKER_IMAGE_FOR_NATIVE_IMAGE /bin/bash  <-- no bash
#$DOCKER run --rm -it $DOCKER_IMAGE_FOR_NATIVE_IMAGE /bin/ash <-- no ash
#$DOCKER run --rm -it $DOCKER_IMAGE_FOR_NATIVE_IMAGE


# See options here: https://www.graalvm.org/22.0/reference-manual/native-image/Options/#options-to-native-image-builder
#$DOCKER run \
#  --rm \
#  -v "${JARS_DIR}":/jars:ro \
#  -v "${OUTPUT_DIR}":/output:rw \
#  $DOCKER_IMAGE_FOR_NATIVE_IMAGE -jar /jars/app.jar /output/${BINARY_NAME} --static --verbose -H:Log=registerResource

docker pull alpine:3.17

#--target ...

# TODO: test binary on alpine (where it will run)
#alpine:3.17


# ---------------------------------------------
# -- Report
# ---------------------------------------------
