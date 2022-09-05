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
  echo
  echo "|-- [Phase: Pre-build]"
  $SCRIPTS_DIR/delete.generated.sh
  #$SCRIPTS_DIR/generate.sh

  $SCRIPTS_DIR/format.native.sh

  echo
  echo "|-- [Phase: Build]"
  #$SCRIPTS_DIR/build.protobuf.sh
  $SCRIPTS_DIR/build.via-docker.sh

  echo
  echo "|-- [Phase: Verify]"
  $SCRIPTS_DIR/test.native.sh

  $SCRIPTS_DIR/lint.via-docker.sh

  echo
  echo "|-- [Phase: Push]"
  # ...

  echo
  echo "|-- [Phase: Deploy]"
  # ...
)
