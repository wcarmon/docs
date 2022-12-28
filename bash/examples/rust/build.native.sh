#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local go sdk
# --
# -- Assumptions:
# TODO: more here
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
# Available targets:    rustup target list
# Current target:       rustc -vV
# Setup targets:
#                       rustup target add aarch64-apple-darwin;  # M1
#                       rustup target add x86_64-pc-windows-gnu
#                       rustup target add x86_64-apple-darwin


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See binaries in $ABSOLUTE_OUTPUT_DIR"
ls -hlt $ABSOLUTE_OUTPUT_DIR
