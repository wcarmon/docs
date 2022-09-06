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
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly APP_VERSION=1.0.0

# ---------------------------------------------
# -- Sub-scripts
# ---------------------------------------------
time (
  #$SCRIPTS_DIR/generate.sh

  $SCRIPTS_DIR/format.native.sh

  $SCRIPTS_DIR/build.native.sh

  $SCRIPTS_DIR/test.native.sh

  $SCRIPTS_DIR/lint.native.sh
)
