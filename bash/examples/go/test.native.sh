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

# Dir contains go.mod file
readonly PROJ_ROOT=$PARENT_DIR

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly SOURCES_ROOT=$PROJ_ROOT/src

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Test
# ---------------------------------------------
cd "$SOURCES_ROOT" >/dev/null 2>&1

echo
echo "|-- Running tests in $(pwd)"
go test ./...
