#!/bin/bash

# ---------------------------------------------
# -- Runs tests via local flutter sdk
# --
# -- Assumptions:
# -- 1. Flutter SDK installed: https://docs.flutter.dev/get-started/install
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly FLUTTER=$(which flutter)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# TODO

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# TODO

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Test
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

$FLUTTER test --concurrency=4
