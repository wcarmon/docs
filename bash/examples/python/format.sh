#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis
# --
# -- Assumptions:
# -- 1. Virtual environments setup
# -- 2. black installed
# -- 3. docformatter installed
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
# -- Derived
# ---------------------------------------------
# Dir contains pyproject.toml file
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
set +u
if [ -z "$VIRTUAL_ENV" ]; then
  echo "|-- Error: Activate a virtual environment first"
  echo
  echo "|-- Pyenv environments:"
  find "$HOME/.pyenv/versions" -type f -name activate | grep envs
  exit 10
fi
set -u


# ---------------------------------------------
# -- Format
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Using Virtual environment: $VIRTUAL_ENV"

echo
echo "|-- Reformatting with black: $PROJ_ROOT"
black .

echo
echo "|-- Reformatting docs with docformatter: $VIRTUAL_ENV"
docformatter --in-place --recursive .
