#!/bin/bash

# ---------------------------------------------
# -- Builds debug artifact
# --
# -- Assumptions:
# -- 1. cmake installed
# -- 2. conan installed
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# In CLion:
# File | Settings | Build, Execution, Deployment | CMake
# - CMake Options: -DCMAKE_PREFIX_PATH=cmake-build-release/build/Release/generators


# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

export CC=clang
export CXX=clang++

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

rm -rf $PROJ_ROOT/build-debug/*
rm -rf $PROJ_ROOT/cmake-build-debug/*

conan install . \
--output-folder=cmake-build-debug \
--build=missing \
-s build_type=Debug

cmake . \
--preset conan-debug \
-DCMAKE_PREFIX_PATH="cmake-build-debug/build/Debug/generators"
