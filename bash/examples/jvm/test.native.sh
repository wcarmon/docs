#!/bin/bash

# ---------------------------------------------
# -- Runs tests via local go sdk
# ---------------------------------------------

#set -x # trace commands
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
# Dir contains settings.gradle.kts, build.gradle.kts, gradlew, ...
readonly PROJ_ROOT="$PARENT_DIR"

readonly GRADLE="$PROJ_ROOT/gradlew"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Test
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Testing code in $(pwd)"

#$GRADLE test --quiet
$GRADLE test --quiet -i
