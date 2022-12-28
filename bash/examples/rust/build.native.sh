#!/bin/bash

# ---------------------------------------------
# -- Builds local binary via local go sdk
# --
# -- Assumptions:
# -- 1. Rust SDK installed
# --    TODO: more here
# --
# -- 2. cargo installed (on PATH)
# --    TODO: more here
# --
# -- 3. cargo install -f cross
# --
# -- 4. cross compilation targets
# --
# -- Available targets:   rustup target list
# -- Current target:      rustc -vV
# -- Setup targets:
#                         rustup target add aarch64-apple-darwin;  # M1
#                         rustup target add x86_64-apple-darwin;
#                         rustup target add x86_64-pc-windows-gnu;
#                         rustup target add x86_64-unknown-linux-gnu;
#                         rustup target add x86_64-unknown-linux-musl; # alpine
#
# -- 5: sudo apt install -y g++-aarch64-linux-gnu libc6-dev-arm64-cross gcc-multilib
# ---------------------------------------------


#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

#TODO: rustc is at $HOME/.cargo/bin/rustc (linux & mac)

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# $PROJ_ROOT/src/go.mod file must exist
readonly PROJ_ROOT="$PARENT_DIR"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------

# ---------------------------------------------
# -- Build
# ---------------------------------------------


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
