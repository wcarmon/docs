#!/bin/bash

# ---------------------------------------------
# -- Decrypt and "demungle" a file
# --
# -- See sister file at ./encrypt_file.sh
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

# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Decrypt
# ---------------------------------------------
dd if="$INPUT_FILE" of="$INPUT_FILE" conv=swab

openssl enc -d -aes-256-cbc \
-in "$INPUT_FILE" \
-out "$OUTPUT_FILE" \
-k "$SECRET_KEY"

# ---------------------------------------------
# -- Report
# ---------------------------------------------
