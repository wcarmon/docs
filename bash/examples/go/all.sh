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
  #$SCRIPTS_DIR/build.protobuf.sh

  $SCRIPTS_DIR/format.native.sh
  #$SCRIPTS_DIR/fix-imports.native.sh

  echo
  echo "|-- [Phase: Build]"
  $SCRIPTS_DIR/build.via-docker.sh

  echo
  echo "|-- [Phase: Verify]"
  $SCRIPTS_DIR/test.native.sh

  $SCRIPTS_DIR/lint.via-docker.sh

  echo
  echo "|-- [Phase: Push]"
  $SCRIPTS_DIR/version.bump.sh
  readonly APP_SEMVER=$(cat $VERSION_FILE | head -1)

  $SCRIPTS_DIR/build.image.sh "${APP_SEMVER}"

  echo
  echo "|-- [Phase: Deploy]"
  $SCRIPTS_DIR/push.image.sh "${APP_SEMVER}"
  # ... deploy pushed image to cloud provider
)
