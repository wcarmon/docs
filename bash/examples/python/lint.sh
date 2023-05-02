#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis
# --
# -- Assumptions:
# -- 1. Virtual environments setup
# -- 2. mypy installed
# -- 3. flake8 installed (runs pyflakes)
# -- 4. radon and radon[toml] installed
# -- 5. pyroma installed
# -- 6. pyright installed
# -- 7. bandit installed
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
# -- Lint (static analysis)
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

PYTHONPATH="${PYTHONPATH:=}"
export PYTHONPATH="${PROJ_ROOT}/src:${PYTHONPATH}"
export MYPYPATH="${PYTHONPATH}"

echo
echo "|-- Using Virtual environment: $VIRTUAL_ENV"

# ---------------------------------------------
# -- Run: MyPy
# ---------------------------------------------
echo
echo "|-- Running mypy on ${PROJ_ROOT}"
mypy .

# GOTCHA: only works after first run
mypy --install-types

# ---------------------------------------------
# -- Run: Flake8
# ---------------------------------------------
echo
echo "|-- Running flake8 on ${PROJ_ROOT}"
flake8 --exit-zero .

# ---------------------------------------------
# -- Run: Pylint
# ---------------------------------------------
echo
echo "|-- Running pylint on ${PROJ_ROOT}"
pylint --enable-all-extensions --jobs=2 --output-format=colorized --recursive=y --verbose .
#pylint --errors-only --enable-all-extensions --jobs=2 --output-format=colorized --recursive=y --verbose .

# ---------------------------------------------
# -- Run: Radon
# ---------------------------------------------
echo
echo "|-- Running radon on ${PROJ_ROOT}"
# -- NOTE: F=function, M=method, C=class

# Maintainability Index: A is best, C is worst
# See https://radon.readthedocs.io/en/latest/commandline.html#the-mi-command

# -- highest priority
radon mi --show --min C .

# -- everything else
#radon mi --show --max B .

# ----------------
# Cyclomatic Complexity: A is best, F is worst
# See https://radon.readthedocs.io/en/latest/commandline.html#the-cc-command

# -- high priority
radon cc --average --show-closures --total-average --min C .

# -- low priority
#radon cc --average --show-closures --total-average --max C .

# ---------------------------------------------
# -- Run: Bandit
# ---------------------------------------------
echo
echo "|-- Running bandit (security) on ${PROJ_ROOT}"
bandit -r .

# ---------------------------------------------
# -- Run: pyroma
# ---------------------------------------------
# TODO: only enable if packaging your code
#echo
#echo "|-- Running pyroma (packaging) on ${PROJ_ROOT}"
#pyroma .

# ---------------------------------------------
# -- Run: Pyright
# ---------------------------------------------
# sometimes annoying
#echo
#echo "|-- Running pyright on ${PROJ_ROOT}"
#pyright --level warning .
#pyright --level error .

# ---------------------------------------------
# -- Run: pylama
# ---------------------------------------------
# GOTCHA: mostly redundant
#pylama .
