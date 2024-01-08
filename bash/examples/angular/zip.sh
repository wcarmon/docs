#!/bin/bash

# ---------------------------------------------
# -- Zips sources for angular app, ignoring irrelevant files
# --
# -- Assumptions:
# -- 1. zip installed
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
readonly OUTPUT_FILE=dist/archive.zip


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly REAL_OUTPUT=$(readlink -f "${OUTPUT_FILE}")


# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Zip
# ---------------------------------------------
cd "$PARENT_DIR" >/dev/null 2>&1

rm -vf "$OUTPUT_FILE" || true

zip -r "$OUTPUT_FILE" \
. \
-x "./package-lock.json" \
-x "./pnpm-lock.yaml" \
-x ".angular*" \
-x ".idea*" \
-x "dist*" \
-x "node_modules*"


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Wrote zip file:"
du -sh $REAL_OUTPUT || true
