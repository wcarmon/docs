#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis via eslint
# --
# -- Assumptions:
# -- 1. eslint installed: npm init @eslint/config
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# --------------------------------------------
# -- Constants
# ---------------------------------------------
readonly NPX=$(which npx)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

readonly ESLINT_SRC_CONFIG="$PROJ_ROOT/.eslintrc.js"
readonly ESLINT_TEST_CONFIG="$PROJ_ROOT/.eslintrc.test.js"

# ---------------------------------------------
# -- Lint
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- linting & fixing sources"
$NPX eslint \
  --config $ESLINT_SRC_CONFIG \
  --ext .ts \
  --ext .tsx \
  --ignore-pattern *.spec.ts \
  --fix \
  src

echo
echo "|-- linting & fixing tests"
$NPX eslint \
  --config $ESLINT_TEST_CONFIG \
  --ext .ts \
  --ext .tsx \
  --fix \
  src/**/*.spec.ts
