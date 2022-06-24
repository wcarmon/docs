#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis via gradle
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

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Lint (static analysis)
# ---------------------------------------------
echo
echo "|-- Analyzing code in ${PROJ_ROOT}"

cd $PROJ_ROOT >/dev/null 2>&1

$GRADLE check --quiet
