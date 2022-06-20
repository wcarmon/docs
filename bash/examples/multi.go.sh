#!/bin/bash

# ---------------------------------------------
# -- Aggregator
# ---------------------------------------------

set -e
set -o pipefail
set -u

readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

#$SCRIPTS_DIR/generate.sh

$SCRIPTS_DIR/format.native.sh
$SCRIPTS_DIR/build.native.sh
$SCRIPTS_DIR/test.native.sh
$SCRIPTS_DIR/lint.docker.sh
