#!/bin/bash

# ---------------------------------------------
# -- Builds release artifact
# --
# -- Assumptions:
# -- 1. clang-format installed
# --     sudo apt install -y clang-format
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
#readonly CLANG_FORMAT_STYLE="GNU"
#readonly CLANG_FORMAT_STYLE="LLVM"
#readonly CLANG_FORMAT_STYLE="WebKit"
readonly CLANG_FORMAT_STYLE="Chromium"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Format
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Formatting files in $(pwd)"

find src \( -name '*.h' -o -name '*.cpp' \) -print0 |
while IFS= read -r -d '' file; do
    echo "- $file"
    clang-format -i --sort-includes --style="$CLANG_FORMAT_STYLE" "$file"
done
