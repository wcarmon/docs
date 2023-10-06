#!/bin/bash

# ---------------------------------------------
# -- Encrypts a file
# --
# -- See sister file at ./decrypt_file.sh
# --
# -- Example:
# -- SECRET_KEY="foo" $HOME/bin/encrypt_file.sh ./my-file.tar.gz
# --
# -- Assumptions:
# -- 1. openssl installed: https://linux.die.net/man/1/openssl
# -- 2. dd installed: https://man7.org/linux/man-pages/man1/dd.1.html
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
readonly WARPED_FILE_EXTENSION=".warp"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
set +u
if [ -z "$SECRET_KEY" ]; then
  echo "Error: pass env variable: SECRET_KEY"
  exit 30
fi
set -u

readonly ENCRYPTED_OUTPUT_FILE="${INPUT_FILE}${ENCRYPTED_FILE_EXTENSION}"
readonly WARPED_OUTPUT_FILE="${INPUT_FILE}${WARPED_FILE_EXTENSION}"

readonly OUTPUT_PARENT_DIR=$(readlink -f "$(dirname "${WARPED_OUTPUT_FILE}")")


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
rm -vf "$ENCRYPTED_OUTPUT_FILE" || true
rm -vf "$WARPED_OUTPUT_FILE" || true

echo
echo "|-- Encrypting file: $(readlink -f $INPUT_FILE)"

openssl enc \
-aes-256-cbc \
-in "$INPUT_FILE" \
-iter 10000 \
-k "$SECRET_KEY" \
-out "$ENCRYPTED_OUTPUT_FILE" \
-salt

echo
echo "|-- Warping file: $(readlink -f $ENCRYPTED_OUTPUT_FILE)"

# -- Reverse all bytes
dd if="$ENCRYPTED_OUTPUT_FILE" \
of="$WARPED_OUTPUT_FILE" \
bs=1 \
conv=swab


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
#rm -f $ENCRYPTED_OUTPUT_FILE


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See warped, encrypted file: $(readlink -f $WARPED_OUTPUT_FILE)"
ls -l $OUTPUT_PARENT_DIR | grep $ENCRYPTED_FILE_EXTENSION
ls -l $OUTPUT_PARENT_DIR | grep $WARPED_FILE_EXTENSION


echo
echo "|-- File info:"
file $ENCRYPTED_OUTPUT_FILE
file $WARPED_OUTPUT_FILE
