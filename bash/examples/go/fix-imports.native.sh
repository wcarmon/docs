#!/bin/bash

# ---------------------------------------------
# -- Auto fix imports
# -- eg. remove unused, add missing
# --
# -- Assumptions:
# -- 1. goimports is on your PATH: https://pkg.go.dev/golang.org/x/tools/cmd/goimports
# --    go install golang.org/x/tools/cmd/goimports@latest
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly GOIMPORTS=$(which goimports)
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
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Fix
# ---------------------------------------------
echo
echo "|-- Fixing imports in code in ${PROJ_ROOT}/src"
$GOIMPORTS -w "${PROJ_ROOT}/src"