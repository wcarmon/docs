#!/bin/bash

# ---------------------------------------------
# -- Build, test and assemble Android APKs
# --
# -- Assumptions
# -- 1. gradle installed
# -- 2. Wrapper setup (once)
# --    $ command gradle wrapper --gradle-version 9.0 --distribution-type all
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


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

# ---------------------------------------------
# -- Build, Test, Package
# ---------------------------------------------
cd $PARENT_DIR > /dev/null 2>&1

# ./scripts/generate-grpc.sh
./gradlew clean build assembleDebug assembleRelease test -q
