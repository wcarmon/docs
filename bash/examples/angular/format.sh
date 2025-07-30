#!/bin/bash

# ---------------------------------------------
# -- Auto format the ts/js files
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
# -- Format
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

# NOTE: --log-level <silent|error|warn|log|debug>
$NPX prettier \
  --log-level log \
  --write "src/**/*.{ts,tsx,js,jsx,json}"

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Successfully auto-formatted"
