#!/bin/bash

# ---------------------------------------------
# -- Find shell files with a name & execute
# --
# -- Assumptions:
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly CURRENT_SCRIPT_FILE=$(readlink -f "${BASH_SOURCE[0]}")
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly FILE_NAME_TO_RUN="build.native.sh"
readonly MAX_DEPTH=5

# ---------------------------------------------
# -- Iterate
# ---------------------------------------------
cd "$PARENT_DIR" >/dev/null 2>&1

find . \
  -maxdepth $MAX_DEPTH \
  -name $FILE_NAME_TO_RUN \
  -type f \
  -print0 | while read -d $'\0' file; do

  SCRIPT_TO_RUN=$(readlink -f "$file")

  if [ "$SCRIPT_TO_RUN" = "$CURRENT_SCRIPT_FILE" ]; then
    # -- Avoid infinite loop
    continue
  fi

  echo ""
  echo ""
  echo "|-- =================================================================="
  echo "|-- Running: $SCRIPT_TO_RUN"
  echo "|-- =================================================================="
  bash -c "$file"
done

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Ran all files named $FILE_NAME_TO_RUN"
