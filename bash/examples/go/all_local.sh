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
readonly VERSION_FILE="$PARENT_DIR/VERSION"

# ---------------------------------------------
# -- Sub-scripts
# ---------------------------------------------
time (
  echo
  echo "|-- [Phase: Pre-build]"
  $SCRIPTS_DIR/delete.generated.sh
  #$SCRIPTS_DIR/generate.sh
  $SCRIPTS_DIR/build.protobuf.sh

  $SCRIPTS_DIR/format.native.sh

  # For Generated Dependency
  #$OME/git-repos/go/projects/foo/scripts/fix-imports.native.sh

  $SCRIPTS_DIR/fix-imports.native.sh



  echo
  echo "|-- [Phase: Build]"
  $SCRIPTS_DIR/build.via-docker.sh

  echo
  echo "|-- [Phase: Verify]"
  $SCRIPTS_DIR/test.native.sh

  $SCRIPTS_DIR/lint.via-docker.sh
)
