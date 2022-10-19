#!/bin/bash

# ---------------------------------------------
# -- Builds, lints, tests, checks formatting
# --
# -- Assumptions:
# -- 1. gradle installed
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains settings.gradle.kts, build.gradle.kts, gradlew, ...
readonly PROJ_ROOT="$PARENT_DIR"

readonly GRADLE="$PROJ_ROOT/gradlew"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
$GRADLE \
  clean \
  build \
  check \
  jar \
  pmdMain \
  pmdTest \
  spotlessCheck \
  test \
  --quiet

$SCRIPTS_DIR/build.image.sh

$SCRIPTS_DIR/push.image.sh
