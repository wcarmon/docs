#!/bin/bash

# ---------------------------------------------
# -- Pull OpenTelemetry span *.ndjson files from device
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

readonly LOCAL_DEST_DIR="$HOME/tmp/android-app-otel-spans"

# -- App must be configured to write spans here
# -- Relative to app root dir
readonly RELATIVE_SPANS_DIR="files/otel-spans"


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


echo
echo "|-- Cleanup & dir setup ..."
mkdir -p "$LOCAL_DEST_DIR"
rm -vf "$LOCAL_DEST_DIR"/*.ndjson


# ---------------------------------------------
# -- Pull *.ndjson files from device
# ---------------------------------------------
echo
echo "|-- Checking remote dir exists..."
adb shell "run-as $ANDROID_PACKAGE_AND_APP_USER sh -c 'test -d \"$RELATIVE_SPANS_DIR\"'"

echo
echo "|-- Counting *.ndjson..."
COUNT="$(adb shell "run-as $ANDROID_PACKAGE_AND_APP_USER sh -c 'ls -1 \"$RELATIVE_SPANS_DIR\"/*.ndjson 2>/dev/null | wc -l'" | tr -d '\r')"
if [[ "$COUNT" -eq 0 ]]; then
  echo "|-- No .ndjson spans on device at $RELATIVE_SPANS_DIR"
  exit 1
fi

echo
echo "|-- Pulling $COUNT *..ndjson files..."
adb exec-out "run-as $ANDROID_PACKAGE_AND_APP_USER sh -c 'cd \"$RELATIVE_SPANS_DIR\" && tar -cf - -- *.ndjson'" \
  | tar -xf - -C "$LOCAL_DEST_DIR"


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Wrote local *.ndjson files from device [$RELATIVE_SPANS_DIR] to [$LOCAL_DEST_DIR]"
ls -lh "$LOCAL_DEST_DIR"/*.ndjson 2>/dev/null
