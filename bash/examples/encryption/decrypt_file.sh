#!/bin/bash

# ---------------------------------------------
# -- Decrypts a file
# --
# -- See sister file at ./encrypt_file.sh
# --
# -- Examples:
# -- SECRET_KEY="foo" $HOME/bin/decrypt_file.sh ./my-file.tar.gz.enc
# -- SECRET_KEY="foo" OUTPUT_FILE=zzz.tar.gz $HOME/bin/decrypt_file.sh ./my-file.tar.gz.enc
# --
# -- Assumptions:
# -- 1. openssl installed: https://linux.die.net/man/1/openssl
# --
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
readonly ENCRYPTED_FILE_EXTENSION=".enc"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
set +u
if [ -z "$SECRET_KEY" ]; then
  echo "Error: pass env variable: SECRET_KEY"
  exit 30
fi
set -u


# -- Allow user to override OUTPUT_FILE
set +u
if [ -z "$OUTPUT_FILE" ]; then
  OUTPUT_FILE="${INPUT_FILE%.*}"
fi
set -u

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

elif [[ ! "$INPUT_FILE" =~ $ENCRYPTED_FILE_EXTENSION$ ]]; then
    echo "Error: INPUT_FILE must end with '$ENCRYPTED_FILE_EXTENSION'"
    exit 110
fi


# ---------------------------------------------
# -- Decrypt
# ---------------------------------------------
rm -vf "$OUTPUT_FILE"

echo
echo "|-- Decrypting file: $(readlink -f $INPUT_FILE)"

openssl enc \
-d \
-aes-256-cbc \
-in "$INPUT_FILE" \
-iter 10000 \
-k "$SECRET_KEY" \
-out "$OUTPUT_FILE" \
-salt

# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See decrypted file: $(readlink -f $OUTPUT_FILE)"
ls -lt "$OUTPUT_PARENT_DIR" | head -2

echo
echo "|-- File info:"
file "$OUTPUT_FILE"
