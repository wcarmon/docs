#!/bin/bash

# ---------------------------------------------
# -- Auto format the go files
# --
# -- Assumptions:
# -- 1. gofmt is on your PATH: https://golang.org/cmd/gofmt/
# --    see $GO_SDK/bin/gofmt
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
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"
readonly SOURCES_ROOT=$PROJ_ROOT/src

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Format
# ---------------------------------------------
echo
echo "|-- Formatting code in ${SOURCES_ROOT}"

gofmt -s -e -w "$SOURCES_ROOT"
