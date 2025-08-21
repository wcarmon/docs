#!/bin/bash

# ---------------------------------------------
# -- Deploy android package to device
# --
# -- Assumptions
# -- 1. already ran ci.sh
# -- 2. gradle installed
# -- 3. adb installed
# -- 4. device connected
# -- 5. usb debugging enabled
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

# -- If pushing extra config or certs or sensitive files
# readonly DEFAULT_CREDS_FILE="$HOME/.config/android-app-default-credentials.json"


# readonly TMP_FILE_ON_DEVICE="/data/local/tmp/default-creds.json"

# -- Relative to the app user's home dir
# readonly CREDS_DEST="files/auth/default.credentials.json"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ ! -f "$DEFAULT_CREDS_FILE" ]; then
    echo "Error: default credentials file required at $DEFAULT_CREDS_FILE" >&2
    exit 7
fi


# ---------------------------------------------
# -- Prep device connection
# ---------------------------------------------
adb kill-server
adb start-server
adb devices -l


# ---------------------------------------------
# -- Deploy
# ---------------------------------------------
echo
echo "|-- Deploying app to device..."
./gradlew installDebug -q


# ---------------------------------------------
# -- Prep Dirs for extra files
# ---------------------------------------------
# GOTCHA: only works after first install
adb shell run-as $ANDROID_PACKAGE_AND_APP_USER mkdir -p files/auth


# ---------------------------------------------
# -- Push extras
# ---------------------------------------------
echo
echo "|-- Pushing default credentials to device..."
adb push $DEFAULT_CREDS_FILE $TMP_FILE_ON_DEVICE
adb shell run-as $ANDROID_PACKAGE_AND_APP_USER cp $TMP_FILE_ON_DEVICE $CREDS_DEST
adb shell rm $TMP_FILE_ON_DEVICE


# ---------------------------------------------
# -- Launch
# ---------------------------------------------
echo
echo "|-- Launching app ..."
adb shell am start -n $ANDROID_PACKAGE_AND_APP_USER/.MainActivity


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Deployed and launched app successfully."
