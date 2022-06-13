#!/bin/bash

# ---------------------------------------------
# --
# -- Runs tests via local go sdk
# --
# ---------------------------------------------

#set -x
set -e
set -o pipefail
set -u


# ---------------------------------------------
# -- Config
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT=$(dirname "${BASH_SOURCE[0]}")/..


# ---------------------------------------------
# -- Test
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Running tests in $(pwd)"
go test ./...
