#!/bin/bash

# ---------------------------------------------
# --
# -- Builds local binary via local go sdk
# --
# -- Assumes godoc installed:
# --   go install golang.org/x/tools/cmd/godoc
# ---------------------------------------------

#set -x # uncomment to debug script
set -e
set -o pipefail
set -u

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
readonly PROJ_ROOT=$PARENT_DIR
readonly SOURCES_ROOT=$PROJ_ROOT/src

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

echo
echo "|-- Hosting docs on localhost:$PORT"

$GODOC \
  -http=":$PORT" \
  -index \
  -play=true \
  -timestamps=true \
  -goroot=$PROJ_ROOT &

echo
echo "|-- godoc process info:"
ps -ax | grep -i godoc | grep -v grep
#killall godoc
