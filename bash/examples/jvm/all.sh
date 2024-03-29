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
#readonly VERSION_FILE="$PARENT_DIR/VERSION"
readonly APP_VERSION=1.0.0

# ---------------------------------------------
# -- Sub-scripts
# ---------------------------------------------
time (
  echo
  echo "|-- [Phase: Pre-build]"
  #$SCRIPTS_DIR/generate.sh

  $SCRIPTS_DIR/format.native.sh

  echo
  echo "|-- [Phase: Build]"
  $SCRIPTS_DIR/build.native.sh

  $SCRIPTS_DIR/test.native.sh

  $SCRIPTS_DIR/lint.native.sh

  echo
  echo "|-- [Phase: Push]"
  # ...

  echo
  echo "|-- [Phase: Deploy]"
  # ...

)
