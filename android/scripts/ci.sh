#!/bin/bash

# ---------------------------------------------
# -- Build, test and assemble Android APKs
# --
# -- Assumptions
# -- 1. gradle installed
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
 