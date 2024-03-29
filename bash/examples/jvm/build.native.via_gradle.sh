#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via gradle & graal
# --
# -- Assumptions:
# -- 1. gradle installed
# -- 2. (graal) native-image is installed:
# --    https://www.graalvm.org/22.1/reference-manual/native-image/#install-native-image
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly NATIVE_IMAGE=$HOME/bin/native-image
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

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
# Dir contains settings.gradle.kts, build.gradle.kts, gradlew, ...
readonly PROJ_ROOT="$PARENT_DIR"

# NOTE: to get project name: (might not match the jar name)
# ./gradlew properties -q | grep name
readonly JAR_FILE=$PROJ_ROOT/build/libs/foo.1.0.0.jar

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
$SCRIPTS_DIR/build.jar.via_gradle.sh

cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Building native binary from jar..."
time $NATIVE_IMAGE \
  -jar $JAR_FILE \
  $BINARY
