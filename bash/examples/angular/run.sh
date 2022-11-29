#!/bin/bash

# ---------------------------------------------
# -- TODO
# --
# -- Assumptions:
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# --------------------------------------------
# -- Constants
# ---------------------------------------------
readonly NPX=$(which npx)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Run
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

#echo
#echo "-- Navigate to http://localhost:4200"
$NPX ng serve
