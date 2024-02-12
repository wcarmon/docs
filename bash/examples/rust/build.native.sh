#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local cargo/rust
# --
# -- Assumptions:
# -- 1. Cargo installed: rustup update
# -- 2. Cross compilation targets installed  (rustup target add $TARGET_NAME)
# --    Available targets:   rustup target list
# --    Current target:      rustc -vV
# --    Interesting targets:
# --          x86_64-unknown-linux-gnu (Debian, Ubuntu, Mint, ...)
# --          x86_64-unknown-linux-musl (alpine linux)
# --          x86_64-pc-windows-msvc (windows 7)
# --          aarch64-apple-darwin (macOS with M1 chip)
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# NOTE: Binary Paths
# - Linux & Mac: $HOME/.cargo/bin/rustc
# - windows:    C:\Users\<username>\.rustup\toolchains\stable-x86_64-pc-windows-msvc\bin\*.exe

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly EXECUTABLE_CRATE_NAME="foo-main"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/Cargo.toml file must exist (root Cargo.toml)
readonly PROJ_ROOT="${PARENT_DIR}"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Building code in ${PROJ_ROOT}"

# ---------------------------------------------
# -- Docs
# ---------------------------------------------
# TODO: add rustdoc here

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See binaries in $ABSOLUTE_OUTPUT_DIR"
ls -hlt $ABSOLUTE_OUTPUT_DIR

# TODO: output in ./target/release/foo-main
# TODO: output in ./target/debug/foo-main use:   find ./target -type f -executable -name "my-proj*"

#echo
#echo "|-- Size Analysis: ..."
##cargo install cargo-bloat
#cargo bloat --release -n 15
