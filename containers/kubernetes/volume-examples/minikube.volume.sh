#!/bin/bash

# -----------------------------------------------------
# -- Runs process to add extra volume to minikube
# -- See https://minikube.sigs.k8s.io/docs/handbook/mount/
# --
# -- Assumptions:
# -- 1. minikube installed and already running via:
# --      minikube start;
# -- 2. kubectl installed (automatically by minikube)
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
readonly EXTRA_VOLUME="$HOME/tmp/volume-for-minikube-1"


# ---------------------------------------------
# -- Run mount process
# ---------------------------------------------

# GOTCHA:
# -- mounting via minikube start doesn't work so well
# minikube start --mount-string="$HOME/tmp/volume-for-minikube-1:/pv" --mount

# -- Cleanup old mount processes
minikube mount --kill;

# -- create dirs
mkdir -p $EXTRA_VOLUME

# -- For Jaeger w/Badger
readonly BADGER_ROOT=$EXTRA_VOLUME/badger;
mkdir -p $BADGER_ROOT/key
mkdir -p $BADGER_ROOT/data


# -- Run mount process in background
# -- GOTCHA: if process dies, mount stops working

minikube mount $EXTRA_VOLUME:/pv &
# nohup minikube mount $EXTRA_VOLUME:/pv &


# ---------------------------------------------
# -- Print Help
# ---------------------------------------------
echo "|-- To fix permissions:"
echo "sudo chmod 777 -R $EXTRA_VOLUME;"
echo "sudo chown 10001 -R $BADGER_ROOT;"
echo "sudo chgrp 0 -R $BADGER_ROOT;"


echo
echo "|-- To verify mount:"
echo "minikube ssh;"
echo "touch /pv/foobar;"
echo "ls -hal /pv;"
echo "exit"


echo
echo "|-- To apply & verify the mount:"
echo "kubectl apply -f $SCRIPT_DIR/local.pv.yaml;"
echo "kubectl describe pv;"
echo "du -h $EXTRA_VOLUME;"
echo "ls -hal $EXTRA_VOLUME;"
