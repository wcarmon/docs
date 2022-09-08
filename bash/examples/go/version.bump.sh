#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local go sdk
# --
# -- Assumptions:
# -- 1. version file exists
# -- 2. version file contains only a valid semver string
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly DEFAULT_SEMVER="0.0.0"
readonly VERSION_FILE="$PARENT_DIR/VERSION"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if test -f "$VERSION_FILE"; then
  echo
  echo "|-- Reading version file: $VERSION_FILE"

  readonly OLD_SEMVER=$(cat $VERSION_FILE | head -1)

else
  echo
  echo "|-- Creating new version file: $VERSION_FILE"

  readonly OLD_SEMVER=$DEFAULT_SEMVER
  echo "$OLD_SEMVER" >$VERSION_FILE
fi

# ---------------------------------------------
# -- Parse, bump, write
# ---------------------------------------------

# -- Parse
IFS='.' read -ra ver <<<"$OLD_SEMVER"
[[ "${#ver[@]}" -ne 3 ]] && echo "Invalid semver string in version file at $VERSION_FILE: version=$OLD_SEMVER" && exit 1

PATCH=${ver[2]}
readonly MINOR=${ver[1]}
readonly MAJOR=${ver[0]}

# -- Bump
PATCH=$((PATCH + 1))

readonly NEW_SEMVER="$MAJOR.$MINOR.$PATCH"

# -- Update file
echo "$NEW_SEMVER" >$VERSION_FILE

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Old version: $OLD_SEMVER"
echo "|-- New version: $NEW_SEMVER"
