#!/bin/bash

# ---------------------------------------------
# -- Runs godoc server binary via local go sdk
# --
# -- Assumes godoc installed:
# --   go install golang.org/x/tools/cmd/godoc
# --   Verify: See `$HOME/go/bin/godoc`
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
# NOTE: all paths relative to $PROJ_ROOT
readonly GODOC=$HOME/go/bin/godoc
readonly PORT=6060

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ ! -f "$GODOC" ]; then
  echo "|-- cannot find godoc at path=$GODOC"
  exit 1
fi

# ---------------------------------------------
# -- Host docs
# ---------------------------------------------
# TODO: only where there is port conflict
killall godoc --quiet || true
#    netstat -pant | grep -i godoc

cd "$PROJ_ROOT/src" >/dev/null 2>&1

echo
echo "|-- Hosting docs on localhost:$PORT"

$GODOC \
  -http=":$PORT" \
  -index \
  -play=true \
  -timestamps=true \
  -goroot="$PROJ_ROOT" &

echo
echo "|-- godoc process info:"
#TODO: consider pgrep
ps -ax | grep -i godoc | grep -v grep
#killall godoc

echo
echo "|-- to terminate:"
echo "killall godoc"
