#!/bin/bash

# ---------------------------------------------
# -- Prints gradle dependencies with older versions
# --
# -- Assumptions:
# -- 1. gradle installed
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------
# -- Constants
# ---------------------------------------------

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly SEARCH_ROOT=$HOME/git-repos/modern-jvm

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Print old versions
# ---------------------------------------------
readonly GRADLE_PROJECT_DIRS=$(find "$SEARCH_ROOT" \
-type f \
-name "gradlew" \
-exec dirname {} \;)

for PROJECT_ROOT in $GRADLE_PROJECT_DIRS; do
    echo
    echo "|-- Upgrading gradle version to $TARGET_GRADLE_VERSION in $PROJECT_ROOT"

  (
    echo
    echo "|-- Checking dependencies in $PROJECT_ROOT ..."
# TODO: run ben's versions plugin

  )
done
