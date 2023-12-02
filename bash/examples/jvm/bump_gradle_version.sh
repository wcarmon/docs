#!/bin/bash

# ---------------------------------------------
# -- Bumps gradle version on all project roots under configured search root
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
readonly SEARCH_ROOT=$HOME/git-repos/modern-jvm/mature

# -- See https://gradle.org/releases/
readonly TARGET_GRADLE_VERSION=8.5

# -- bin | all
readonly DISTRIBUTION_TYPE=bin


# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Bump gradle versions
# ---------------------------------------------

readonly GRADLE_PROJECT_DIRS=$(find "$SEARCH_ROOT" \
-type f \
-name "gradlew" \
-exec dirname {} \;)

for PROJECT_ROOT in $GRADLE_PROJECT_DIRS; do
    echo
    echo "|-- Upgrading gradle version to $TARGET_GRADLE_VERSION in $PROJECT_ROOT"

    (
      cd $PROJECT_ROOT >/dev/null 2>&1
      ./gradlew wrapper --gradle-version=$TARGET_GRADLE_VERSION --distribution-type="$DISTRIBUTION_TYPE" -q
    ) || true
done
