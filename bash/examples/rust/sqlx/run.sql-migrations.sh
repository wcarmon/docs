#!/bin/bash

# ---------------------------------------------
# -- Run sql migrations against local database
# --
# -- Assumptions:
# -- 1. sql-cli installed: cargo install sqlx-cli
# --    See https://github.com/launchbadge/sqlx/tree/main/sqlx-cli
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# --------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly PROJ_ROOT="$PARENT_DIR"

# --------------------------------------------
# -- Run
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Running sql migrations ..."
sqlx migrate info
sqlx migrate run
# sqlx migrate --help

echo
echo "|-- Caching schema into $PROJ_ROOT/.sqlx (for faster compilation)"
#cargo sqlx prepare --check --workspace

# For faster builds, so cargo/rustc need not hit database on every compile
cargo sqlx prepare --workspace
# cargo sqlx prepare -- --all-targets --all-features
