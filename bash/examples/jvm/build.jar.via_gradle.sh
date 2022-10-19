#!/bin/bash

# ---------------------------------------------
# -- Builds local jar via gradle
# --
# -- Assumptions:
# -- 1. gradle installed
# -- 2. lint, tests, and static analysis run separately
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

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
readonly BINARY=build/app

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains settings.gradle.kts, build.gradle.kts, gradlew, ...
readonly PROJ_ROOT="$PARENT_DIR"

readonly GRADLE="$PROJ_ROOT/gradlew"

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
  -x test \
  --quiet

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See jar(s) in $PROJ_ROOT/build/libs"
ls -hlt $PROJ_ROOT/build/libs/*.jar