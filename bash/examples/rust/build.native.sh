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
# --          x86_64-pc-windows-msvc (windows 7)  <-- requires visual studio installed
# --          x86_64-pc-windows-gnu (windows 7)
# --          aarch64-apple-darwin (macOS with M1 chip)
# -- 3. All binary crates referenced in root Cargo.toml [workspace]
# -- 4. (Compiling for windows from linux) sudo apt-get install -y mingw-w64
# -- 5. (For binary sizes): cargo install cargo-bloat
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
readonly LINUX_TARGET="x86_64-unknown-linux-gnu"
readonly WINDOWS_TARGET="x86_64-pc-windows-gnu"

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

# -- NOTE: [profile.dev] is default for `cargo build`
# -- NOTE: [profile.release] runs for `cargo build --release`

# for fast local build with useful debugger info, run `cargo build`

echo
echo "|-- Release build for native target (all executable crates in ${PROJ_ROOT}) ..."
cargo build \
  --release
#  --quiet \


echo
echo "|-- Release build for windows (all executable crates in ${PROJ_ROOT}) ..."
cargo build \
  --release \
  --target=$WINDOWS_TARGET


# ---------------------------------------------
# -- Docs
# ---------------------------------------------
# TODO: add rustdoc here

# ---------------------------------------------
# -- Report
# ---------------------------------------------
readonly NATIVE_BINARIES_DIR="${PROJ_ROOT}/target/release"
readonly WIN_BINARIES_DIR="${PROJ_ROOT}/target/${WINDOWS_TARGET}/release"
readonly LINUX_BINARIES_DIR="${PROJ_ROOT}/target/${LINUX_TARGET}/release"

echo
echo "|-- See native binaries in ${NATIVE_BINARIES_DIR}"
find ${NATIVE_BINARIES_DIR} -maxdepth 1 -executable -type f

echo
echo "|-- See windows binaries in ${WIN_BINARIES_DIR}"
find ${WIN_BINARIES_DIR} -maxdepth 1 -executable -type f -name *.exe

#echo
#echo "|-- Size Analysis: ..."
#cargo install cargo-bloat
#cargo bloat --release -n 15
