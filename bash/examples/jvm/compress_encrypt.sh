#!/bin/bash

# ---------------------------------------------
# -- Builds, formats, compresses source code
# --
# -- Assumptions:
# -- 1. gradle installed
# -- 2. tar installed
# -- 3. xz installed
# -- 4. gpg installed
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# --------------------------------------------
# -- Constants
# --------------------------------------------

# --------------------------------------------
# -- Config
# --------------------------------------------
readonly PROJECT_DIR="$HOME/tmp/..."

readonly ARCHIVE_FILE_WITHOUT_EXT="foo-bar"
readonly PASSPHRASE="...something_secret..."

# --------------------------------------------
# -- Run
# --------------------------------------------
cd "$PROJECT_DIR" >/dev/null 2>&1

rm -f "${ARCHIVE_FILE_WITHOUT_EXT}.tar"
rm -f "${ARCHIVE_FILE_WITHOUT_EXT}.tar.xz"
rm -f "${ARCHIVE_FILE_WITHOUT_EXT}.tar.xz.gpg"

echo
echo "|-- Formatting & Building ..."
time ./gradlew clean spotlessApply build -q -x test -x pmdMain -x pmdTest

echo
echo "|-- Compressing ..."

readonly TAR_FILE="${ARCHIVE_FILE_WITHOUT_EXT}.tar"

tar -cf $TAR_FILE \
  build.gradle.kts \
  settings.gradle.kts \
  src

xz --compress \
  -8 \
  --threads=2 \
  $TAR_FILE

gpg --symmetric \
  --pinentry-mode loopback \
  --passphrase "$PASSPHRASE" \
  "${ARCHIVE_FILE_WITHOUT_EXT}.tar.xz"

rm -f "${ARCHIVE_FILE_WITHOUT_EXT}.tar"
rm -f "${ARCHIVE_FILE_WITHOUT_EXT}.tar.xz"
readonly COMPRESSED_ENCRYPTED="$ARCHIVE_FILE_WITHOUT_EXT.tar.xz.gpg"

# --------------------------------------------
# -- Report
# --------------------------------------------

echo "|-- See file: $COMPRESSED_ENCRYPTED"

# NOTE for receiver:
# 1. ensure tar, gpg and xz are installed
#   - eg. brew install xz

<<RECEIVER_SIDE
ARCHIVE_FILE="...";

mkdir -p ~/tmp/example
cd ~/tmp/example
gpg --decrypt \
  --output tmp.tar.xz \
  --pinentry-mode loopback \
  --passphrase "..."
   "$ARCHIVE_FILE";

xz --decompress tmp.tar.xz;

tar -xf tmp.tar;
rm -f tmp.tar;

RECEIVER_SIDE