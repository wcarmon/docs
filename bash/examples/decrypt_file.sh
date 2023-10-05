#!/bin/bash

# ---------------------------------------------
# -- Decrypts and "de-warps" a file
# --
# -- See sister file at ./encrypt_file.sh
# --
# -- Example:
# -- SECRET_KEY="foo" $HOME/bin/decrypt_file.sh ./my-file.tar.gz.warp
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
readonly UNWARPED_FILE_EXTENSION=".dec"
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

readonly ENCRYPTED_OUTPUT_FILE="${INPUT_FILE%.*}$UNWARPED_FILE_EXTENSION"
readonly OUTPUT_FILE="${INPUT_FILE%.*}"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ ! -e "$INPUT_FILE" ]; then
    echo "Usage: pass a path to an existing file"
    exit 100

elif [ ! -f "$INPUT_FILE" ]; then
    echo "Error: input file must be a regular file: $INPUT_FILE"
    exit 101

elif [[ ! "$INPUT_FILE" =~ $WARPED_FILE_EXTENSION$ ]]; then
    echo "Error: INPUT_FILE must end with '$WARPED_FILE_EXTENSION'"
    exit 102
fi


# ---------------------------------------------
# -- Decrypt
# ---------------------------------------------
rm -vf "$ENCRYPTED_OUTPUT_FILE"
#rm -vf "$OUTPUT_FILE"  # TODO: uncomment me

# -- Reverse all bytes
echo
echo "|-- Unwarping $(readlink -f $INPUT_FILE)"

dd if="$INPUT_FILE" \
of="$ENCRYPTED_OUTPUT_FILE" \
bs=1 \
conv=swab

set -x # <-- TODO: delete me
exit


echo
echo "|-- Decrypting $(readlink -f $ENCRYPTED_OUTPUT_FILE)"

openssl enc \
-d \
-aes-256-cbc \
-in "$ENCRYPTED_OUTPUT_FILE" \
-iter 10000 \
-k "$SECRET_KEY" \
-out "$OUTPUT_FILE" \
-salt


set -x # <-- TODO: delete me


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See decrypted file: $OUTPUT_FILE in $OUTPUT_PARENT_DIR"
ls -l $OUTPUT_PARENT_DIR | grep $ENCRYPTED_FILE_EXTENSION

echo
echo "|-- File info:"
file $OUTPUT_FILE
