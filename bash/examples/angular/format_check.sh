#!/bin/bash

# ---------------------------------------------
# -- Verify auto-formatter was previously run
# --
# -- Assumptions:
# -- 1. Installed prettier: npm install --save-dev prettier
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

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Check Format
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

$NPX prettier --check --no-color "src/**/*.{ts,tsx,js,jsx,json}"
