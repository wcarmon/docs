#!/bin/bash

# ---------------------------------------------
# -- Aggregator example
# ---------------------------------------------

set -e # exit on first error
set -o pipefail
set -u # fail on unset var

readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

#$SCRIPTS_DIR/generate.sh

$SCRIPTS_DIR/format.native.sh
$SCRIPTS_DIR/build.native.sh
$SCRIPTS_DIR/test.native.sh
$SCRIPTS_DIR/lint.via-docker.sh
