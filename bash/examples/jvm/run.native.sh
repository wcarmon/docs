#!/bin/bash

# ---------------------------------------------
# -- Runs main class via local go sdk
# ---------------------------------------------

#set -x # uncomment to debug script
set -e
set -o pipefail
set -u

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
readonly CONFIG_FILE=./app.config.yaml

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains settings.gradle.kts file
readonly PROJ_ROOT="$PARENT_DIR"

readonly GRADLE="$PROJ_ROOT/gradlew"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Run
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

exit 1 # TODO: finish this
TODO: run jar here
#$GRADLE