#!/bin/bash

# ---------------------------------------------
# -- Auto format the go files
# --
# -- Assumptions:
# -- 1. gofmt is on your PATH: https://golang.org/cmd/gofmt/
# --    see $GO_SDK/bin/gofmt
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly GOFMT=$(which gofmt)
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
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Format
# ---------------------------------------------
echo
echo "|-- Formatting code in ${SOURCES_ROOT}"

$GOFMT -s -e -w "$SOURCES_ROOT"
