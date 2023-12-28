#!/bin/bash

# ---------------------------------------------
#
#
#
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
readonly DOCKER_SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/../docker")


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------


# ---------------------------------------------
# -- Config
# ---------------------------------------------


# ---------------------------------------------
# -- Destroy
# ---------------------------------------------

echo
echo "|-- Destroying minikube ..."
minikube stop || true;
minikube mount --kill;

# -- REALLY aggressive, but sometimes required
#minikube delete --all;
#minikube delete --purge;

#$DOCKER_SCRIPTS_DIR/cleanup.sh;
