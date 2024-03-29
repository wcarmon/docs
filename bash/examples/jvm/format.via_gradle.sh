#!/bin/bash

# ---------------------------------------------
# -- Auto format the java files
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
# NOTE: all paths relative to $PROJ_ROOT

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Directory contains settings.gradle.kts, build.gradle.kts, gradlew, ...
readonly PROJ_ROOT="${PARENT_DIR}"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Format
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Formatting code in ${PROJ_ROOT}"

cd "$PROJ_ROOT" >/dev/null 2>&1

./gradlew spotlessApply --quiet
