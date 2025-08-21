#!/bin/bash

# ---------------------------------------------
# -- Push media assets to device via adb
# --
# -- Assumptions
# -- 1. adb installed
# -- 2. device connected
# -- 3. usb debugging enabled
# --
# -- GOTCHA: must double-jump due to permissions
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
# -- ON DESKTOP: Location of asset files
readonly DESKTOP_ASSETS_DIR="$HOME/tmp/my-assets"

# -- Matches app/build.gradle.kts > android > defaultConfig > applicationId
readonly ANDROID_PACKAGE_AND_APP_USER="com.foo.bar"

# -- ON DEVICE: Temporary dir for images
readonly TMP_DIR_ON_DEVICE="/data/local/tmp/preloaded-assets-for-app0"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly ADB_PUSH_OUTPUT_LOG=$(mktemp)

# -- ON DEVICE: App's data directory for images
readonly APP_IMG_DIR_ON_DEVICE="/data/user/0/$ANDROID_PACKAGE_AND_APP_USER/files/preloaded-assets"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Prep adb
# ---------------------------------------------
adb kill-server
adb start-server
adb devices -l


# ---------------------------------------------
# -- Prep Dirs
# ---------------------------------------------
adb shell mkdir -p $TMP_DIR_ON_DEVICE
adb shell run-as $ANDROID_PACKAGE_AND_APP_USER mkdir -p $APP_IMG_DIR_ON_DEVICE


# ---------------------------------------------
# -- Copy/Sync media assets to temp
# ---------------------------------------------
echo
echo "|-- SLOW WARNING: Pushing media assets from desktop to device temp dir: [$DESKTOP_ASSETS_DIR] -> [$TMP_DIR_ON_DEVICE]"
echo
echo "adb push output log: $ADB_PUSH_OUTPUT_LOG"

# GOTCHA: `adb push` is not as simple/flexible as cp or rsync
(
  cd $DESKTOP_ASSETS_DIR >/dev/null 2>&1
  adb push --sync . $TMP_DIR_ON_DEVICE/ > $ADB_PUSH_OUTPUT_LOG
)


# ---------------------------------------------
# -- Copy/Sync to App's data dir (on device)
# ---------------------------------------------
echo
echo "|-- Moving media assets to app's data dir (on device): [$TMP_DIR_ON_DEVICE] -> [$APP_IMG_DIR_ON_DEVICE]"

# -u: skip files that aren’t newer
adb shell run-as $ANDROID_PACKAGE_AND_APP_USER cp -uR $TMP_DIR_ON_DEVICE/. $APP_IMG_DIR_ON_DEVICE


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Preloaded media assets on device in [$APP_IMG_DIR_ON_DEVICE]:"
adb shell run-as $ANDROID_PACKAGE_AND_APP_USER du -sh files/images/gallery
adb shell run-as $ANDROID_PACKAGE_AND_APP_USER ls -l files/images/gallery | wc -l
