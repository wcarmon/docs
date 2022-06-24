#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via gradle & graal
# --
# -- Assumptions:
# -- 1. (graal) native-image is installed:
# --    https://www.graalvm.org/22.1/reference-manual/native-image/#install-native-image
# ---------------------------------------------

#set -x # uncomment to debug script
set -e
set -o pipefail
set -u

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly NATIVE_IMAGE=$HOME/bin/native-image
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly BINARY=build/app

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly GRADLE=$PROJ_ROOT/gradlew
readonly PROJ_ROOT=$PARENT_DIR

# NOTE: to get project name: (might not match the jar name)
# ./gradlew properties -q | grep name
readonly JAR_FILE=$PROJ_ROOT/build/libs/foo.1.0.0.jar


# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Building jar"

# TODO: build fat-jar using shadow
time $GRADLE \
  clean \
  build \
  jar \
  --quiet
#-x test

echo
echo "|-- Building native binary from jar..."
time $NATIVE_IMAGE \
  -jar $JAR_FILE \
  $BINARY
