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
# -- Sub-scripts
# ---------------------------------------------
#$SCRIPTS_DIR/generate.sh

$SCRIPTS_DIR/format.native.sh

$SCRIPTS_DIR/build.native.sh

$SCRIPTS_DIR/test.native.sh

time $SCRIPTS_DIR/lint.via-docker.sh
