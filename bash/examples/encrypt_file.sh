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
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------
# -- Constants
# ---------------------------------------------


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------
set +u
INPUT_FILE="$1"
set -u


# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly ENCRYPTED_FILE_EXTENSION=".foo"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
set +u
if [ -z "$SECRET_KEY" ]; then
  echo "Error: pass env variable: SECRET_KEY"
  exit 30
fi
set -u


readonly OUTPUT_FILE="${INPUT_FILE}${ENCRYPTED_FILE_EXTENSION}"

readonly OUTPUT_PARENT_DIR=$(readlink -f "$(dirname "${OUTPUT_FILE}")")


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ ! -e "$INPUT_FILE" ]; then
    echo "Usage: pass a path to an existing file"
    exit 100

elif [ ! -f "$INPUT_FILE" ]; then
    echo "Error: input file must be a regular file: $INPUT_FILE"
    exit 101
fi


# ---------------------------------------------
# -- Encrypt
# ---------------------------------------------
echo
echo "|-- Encrypting file: $INPUT_FILE"

openssl enc \
-aes-256-cbc \
-salt \
-in "$INPUT_FILE" \
-out "$OUTPUT_FILE" \
-k "$SECRET_KEY"

# -- Reverse the bytes using dd
#dd if="$OUTPUT_FILE" of="$OUTPUT_FILE" conv=swab


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See encrypted file: $OUTPUT_FILE in $OUTPUT_PARENT_DIR"
ls -l $OUTPUT_PARENT_DIR | grep $ENCRYPTED_FILE_EXTENSION
