#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis via local cargo/clippy
# --
# -- Assumptions:
# -- 1. Cargo installed: rustup update
# -- 2. rustup update; rustup component add clippy;
# -- 3. clippy.toml at $PROJECT_ROOT/clippy.toml
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
# Directory contains root Cargo.toml
readonly PROJ_ROOT="${PARENT_DIR}"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Lint (static analysis)
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Analyzing code in ${PROJ_ROOT}"


cargo fix \
--allow-dirty \
--allow-staged

# -- More than you want to know :-)
#cargo clippy --all -- -W clippy::pedantic -W clippy::nursery -W clippy::cargo

# cargo clippy --all


# GOTCHA: Order matters, so put allow (A) at the end
#cargo clippy --all -- \
#  -W clippy::nursery \
#  -W clippy::pedantic \
#  -A clippy::default_trait_access \
#  -A clippy::missing_errors_doc \
#  -A clippy::module_name_repetitions \
#  -A clippy::option_if_let_else \
#  -A clippy::redundant-closure-for-method-calls \
#  -A clippy::redundant-pub-crate \
#  -A clippy::redundant_closure \
#  ;
