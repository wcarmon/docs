#!/bin/bash

# ---------------------------------------------
# -- Builds all dirs that contain Cargo.toml
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
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")


cd "$PARENT_DIR" >/dev/null 2>&1

echo
echo "|-- Building all dirs containing Cargo.toml under ${PARENT_DIR}"

for DIR in $(find . -type f -name "Cargo.toml" -exec dirname {} \; | sort -u); do

  # # -- Conditionally skip some dirs
  # if [[ "$DIR" == ./old/* ]]; then
  #   echo
  #   echo "|-- Skipping $DIR"
  #   continue
  # fi

  echo
  echo "|-- Building in directory: $DIR"

  # -- Release build, include warnings
  (cd "$dir" && cargo build --release)

  # # -- Release build, no warnings
  # (cd "$dir" && RUSTFLAGS=-Awarnings cargo build --release)
  #
  # # -- Clean, then Release build, no warnings
  # (cd "$dir" && cargo clean && RUSTFLAGS=-Awarnings cargo build --release)
  #
  # # -- Debug build, include warnings
  # (cd "$DIR" && cargo build)
  #
  # # -- Debug build, no warnings
  # (cd "$DIR" && RUSTFLAGS=-Awarnings cargo build)
  #
  # # -- Clean, then Debug build, no warnings
  # (cd "$DIR" && cargo clean && RUSTFLAGS=-Awarnings cargo build)
done

echo
echo "|-- Successfully built all projects"
