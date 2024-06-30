#!/bin/bash

# ---------------------------------------------
# -- Runs the application with profiler
# --
# -- Assumptions:
# -- 1. Cargo installed: rustup update
# -- 2. cargo install --locked samply
# -- 3. cargo install --locked tokio-console
# -- 4. Cargo.toml has a block like this
#       [profile.release]
#       codegen-units = 1
#       debug = 1
#       lto = true
#       opt-level = 3
#       panic = "abort"
#
#       [profile.profiling]
#       inherits = "release"
#       debug = true
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


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"


# ---------------------------------------------
# -- Grant profiler access
# ---------------------------------------------
# -- Grant temporary access
#echo '1' | sudo tee /proc/sys/kernel/perf_event_paranoid

# -- Grant permanent access
#sudo sysctl kernel.perf_event_paranoid=1


# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

#cargo build --workspace
cargo build --workspace --profile profiling
#cargo build --workspace --profile profiling --release


# ---------------------------------------------
# -- Profile
# ---------------------------------------------
# See binary in $PROJ_ROOT/target/release/*
# See binary in $PROJ_ROOT/target/debug/*

echo
echo "|-- Profiling app"
samply record $PROJ_ROOT/target/debug/app

#tokio-console


# ---------------------------------------------
# -- View
# ---------------------------------------------
# NOTE: samply auto opens the profiler output file

#echo
#echo "|-- Open https://profiler.firefox.com/"
#echo "|-- Load a profile from file (lower left)"
#
#echo
#echo "|-- Upload from TODO file"
