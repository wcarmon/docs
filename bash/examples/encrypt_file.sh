#!/bin/bash

# ---------------------------------------------
# -- Encrypt and "mungle" a file
# --
# -- See sister file at ./decrypt_file.sh
# --
# -- Assumptions:
# -- 1. openssl installed: https://linux.die.net/man/1/openssl
# -- 2. dd installed: https://man7.org/linux/man-pages/man1/dd.1.html
# ---------------------------------------------
set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------
INPUT_FILE="$1"

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# TODO: generate from input file
OUTPUT_FILE="$2"

# TODO: require env var
SECRET_KEY="foo"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ ! -e "$INPUT_FILE" ]; then
    echo "Error: input file must exist: $INPUT_FILE"
    exit 10

elif [ ! -f "$INPUT_FILE" ]; then
    echo "Error: input file must be a regular file: $INPUT_FILE"
    exit 11
fi


# ---------------------------------------------
# -- Encrypt
# ---------------------------------------------
openssl enc \
-aes-256-cbc \
-salt \
-in "$INPUT_FILE" \
-out "$OUTPUT_FILE" \
-k "$SECRET_KEY"

# -- Reverse the bytes using dd
dd if="$OUTPUT_FILE" of="$OUTPUT_FILE" conv=swab


# ---------------------------------------------
# -- Report
# ---------------------------------------------
