#!/bin/bash

# ---------------------------------------------
# -- Aggregator
# ---------------------------------------------
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# ---------------------------------------------
# -- Run
# ---------------------------------------------
time (
  echo
  echo "|-- Clean ..."
  $SCRIPTS_DIR/clean.sh

  echo
  echo "|-- Format ..."
  $SCRIPTS_DIR/format.sh

  echo
  echo "|-- Build (Debug) ..."
  $SCRIPTS_DIR/build.debug.sh

  echo
  echo "|-- Build (Release) ..."
  $SCRIPTS_DIR/build.release.sh

  echo
  echo "|-- Test ..."
  $SCRIPTS_DIR/test.sh

  echo
  echo "|-- Lint ..."
  $SCRIPTS_DIR/lint.sh
)
