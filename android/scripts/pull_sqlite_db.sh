#!/bin/bash

# ---------------------------------------------
# -- Push images to device via adb
# --
# -- Assumptions
# -- 1. adb installed
# -- 2. device connected
# -- 3. usb debugging enabled
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

# -- Matches app/build.gradle.kts > android > defaultConfig > applicationId
readonly ANDROID_PACKAGE_AND_APP_USER="com.foo.bar"

readonly LOCAL_DEST_FILE="$HOME/tmp/my.sqlite.db"
readonly RELATIVE_DB_PATH="databases/quux.db"

readonly TEMP_FILE_ON_DEVICE="/sdcard/quux.sqlite.db"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Prep
# ---------------------------------------------
adb kill-server
adb start-server
adb devices -l


# ---------------------------------------------
# -- Pull
# ---------------------------------------------
rm -vf $LOCAL_DEST_FILE
adb exec-out run-as $ANDROID_PACKAGE_AND_APP_USER cat $RELATIVE_DB_PATH > $LOCAL_DEST_FILE


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Wrote local sqlite database from device [$RELATIVE_DB_PATH] to [$LOCAL_DEST_FILE]"
