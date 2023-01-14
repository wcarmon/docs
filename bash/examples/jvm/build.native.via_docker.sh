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
# -- See https://github.com/graalvm/container/pkgs/container/native-image
readonly NATIVE_IMAGE_DOCKER_IMAGE=ghcr.io/graalvm/native-image:muslib-ol9-java17-22.3.0-b2

# Relative to $PROJECT_DIR/build/libs/
readonly NATIVE_IMAGE_INPUT_JAR=app.uber.jar



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


mkdir -p ./build/native_image;
rm -rf ./build/native_image/*;

# NOTE: /bin/native-image
# NOTE: working dir: /app
#
# NOTE: JAVA_HOME=/usr/lib64/graalvm/graalvm22-ce-java17
#   openjdk version "17.0.5" 2022-10-18
#   OpenJDK Runtime Environment GraalVM CE 22.3.0 (build 17.0.5+8-jvmci-22.3-b08)
#   OpenJDK 64-Bit Server VM GraalVM CE 22.3.0 (build 17.0.5+8-jvmci-22.3-b08, mixed mode, sharing)
#
# See options here: https://www.graalvm.org/22.0/reference-manual/native-image/Options/#options-to-native-image-builder
#
time $DOCKER run \
  --name native-image-builder \
  --rm \
  -v $PROJECT_DIR/build/libs/$NATIVE_IMAGE_INPUT_JAR:/app/input.jar:ro \
  -v $PROJECT_DIR/build/native_image:/app/output:rw \
  $NATIVE_IMAGE_DOCKER_IMAGE \
  --static \
  --libc=musl \
  -jar input.jar \
  /app/output/app.bin

<< 'DEBUG_NATIVE_IMAGE'
IMAGE=ghcr.io/graalvm/native-image:muslib-ol9-java17-22.3.0-b2;
PROJECT_DIR=/home/wcarmon/git-repos/modern-jvm/chrono-javafx-v3;
NATIVE_IMAGE_INPUT_JAR=app.uber.jar;

docker run \
  --entrypoint /bin/bash \
  --rm \
  -it \
  -v $PROJECT_DIR/build/libs/$NATIVE_IMAGE_INPUT_JAR:/app/input.jar:ro \
  -v $PROJECT_DIR/build/native_image:/app/output:rw \
  $IMAGE;

docker inspect $IMAGE;
DEBUG_NATIVE_IMAGE


# TODO: test binary on alpine (where it will run)
#alpine:3.17


# ---------------------------------------------
# -- Report
# ---------------------------------------------
ls -hlt $PROJECT_DIR/build/libs/*.jar;
ls -hlt $PROJECT_DIR/build/native_image/app*;
