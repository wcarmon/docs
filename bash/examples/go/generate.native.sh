#!/bin/bash

# ---------------------------------------------
# -- Run generate (and tools like stringer)
# --
# -- Assumptions
# --    1. run before go build
# --    2. installed stringer
# --        go install golang.org/x/tools/cmd/stringer
# --        # verify: $HOME/go/bin/stringer
# --    3. some *.go files start with generate header
# --        //go:generate stringer -type=Foo
# --    4. you have a modern version of stringer (like 0.1.11+)
# ---------------------------------------------
#set -x # uncomment to debug
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly GO=$(which go)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT
readonly STRINGER_BINARY_PATH=$HOME/go/bin/stringer

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"
readonly SOURCES_ROOT=$PROJ_ROOT/src

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ ! -f "$STRINGER_BINARY_PATH" ]; then
  echo "|-- Failed to find binary: stringer at path=$STRINGER_BINARY_PATH"
  exit 1
fi

# ---------------------------------------------
# -- Generate and run stringer
# ---------------------------------------------
cd "$SOURCES_ROOT" >/dev/null 2>&1

echo
echo "|-- Generating code in $(pwd)"

$GO generate ./...
#$GO generate -x ./...
