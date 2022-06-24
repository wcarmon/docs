#!/bin/bash

# ---------------------------------------------
# -- Runs tests via local go sdk
# ---------------------------------------------

#set -x # uncomment to debug script
set -e
set -o pipefail
set -u

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
# Dir contains settings.gradle.kts file
readonly PROJ_ROOT=$PARENT_DIR

readonly GRADLE=$PROJ_ROOT/gradlew

# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Test
# ---------------------------------------------
cd $PROJ_ROOT >/dev/null 2>&1

echo
echo "|-- Testing code in ${PROJ_ROOT}"

#$GRADLE test --quiet
$GRADLE test --quiet -i
