#!/bin/bash

# -----------------------------------------------------
# TODO
#
#
#
# -----------------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# --------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/")


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------


# ---------------------------------------------
# -- Config
# ---------------------------------------------


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
docker system prune --all --force;
docker system prune --volumes --force;


# ---------------------------------------------
# -- Verify
# ---------------------------------------------
# sudo tree /var/lib/docker/overlay2/
