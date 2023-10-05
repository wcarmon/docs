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

#TODO: decide on OUTPUT_FILE

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ ! -e "$INPUT_FILE" ]; then
    echo "Usage: pass a path to an existing file"
    exit 100

elif [ ! -f "$INPUT_FILE" ]; then
    echo "Error: input file must be a regular file: $INPUT_FILE"
    exit 101

elif [[ ! "$INPUT_FILE" =~ \Q$ENCRYPTED_FILE_EXTENSION\E$ ]]; then
    echo "Error: INPUT_FILE must end with '$ENCRYPTED_FILE_EXTENSION'"
    exit 102
fi

# ---------------------------------------------
# -- Decrypt
# ---------------------------------------------
#rm -vf "$OUTPUT_FILE"

dd if="$INPUT_FILE" of="$INPUT_FILE" conv=swab

openssl enc -d -aes-256-cbc \
-in "$INPUT_FILE" \
-out "$OUTPUT_FILE" \
-k "$SECRET_KEY"

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See decrypted file: $OUTPUT_FILE in $OUTPUT_PARENT_DIR"
ls -l $OUTPUT_PARENT_DIR | grep $ENCRYPTED_FILE_EXTENSION

echo
echo "|-- File info:"
file $OUTPUT_FILE
