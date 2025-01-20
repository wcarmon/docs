#!/bin/bash

# ---------------------------------------------
# -- Deletes all generated artifacts
# --
# -- Assumptions:
# -- 1. directory names below are generated
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

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Clean
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

# conan
rm -rf $PROJ_ROOT/build
rm -rf $PROJ_ROOT/build-debug
rm -rf $PROJ_ROOT/build-release
rm -rf $PROJ_ROOT/cmake-build-debug
rm -rf $PROJ_ROOT/cmake-build-release
