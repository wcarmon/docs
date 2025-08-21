#!/bin/bash

# ---------------------------------------------
# -- Aggregate/Concatenate all *.xml files in the crate for ChatGPT
# -- ...
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
readonly OUTPUT_FILE="$PARENT_DIR/_all_xml.ai"


# ---------------------------------------------
# -- Concatenate
# ---------------------------------------------
set -x
cd "$PARENT_DIR" >/dev/null 2>&1

rm -vf $OUTPUT_FILE

find ./app/src/main \
    -type f \
    -path '*/res/layout*/*.xml' \
    -not -name '*_test.rs' \
    -not -name 'test_*.rs' \
    -not -path '*/androidTest/*' \
    -not -path '*/build/*' \
    -not -path '*/target/*' \
    -not -path '*/tests/*' \
    -not -path './*/test/*' \
    -not -path './target/*' \
    -print0 |
  sort -z |
  while IFS= read -r -d '' SRC_FILE; do
    REL_PATH="${SRC_FILE#./}"

    echo -e "\n\n// ===== FILE: $REL_PATH =====\n" >> "$OUTPUT_FILE"
    grep -vE '^\s*//+' "$SRC_FILE" \
    | grep -vE '^\s*import ' \
    | grep -vE '^\s*$' >> "$OUTPUT_FILE"
  done


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Wrote all android files to: $OUTPUT_FILE"
