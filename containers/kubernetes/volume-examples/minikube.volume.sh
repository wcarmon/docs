#!/bin/bash

# -----------------------------------------------------
# -- Runs process to add extra volume (overlay fs) to minikube
# -- See https://minikube.sigs.k8s.io/docs/handbook/mount/
# --
# -- NOTE: rerun this to see changes from underlying/host filesystem
# --
# -- Assumptions:
# -- 1. minikube installed and already running via:
# --      minikube start;
# -- 2. kubectl installed (automatically inside minikube)
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
# -- Overlay filesystem
# -- (meaning: changes only live inside minikube and its volumes/pods/containers)
readonly EXTRA_VOLUME="$HOME/tmp/volume-for-minikube-1"


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
# GOTCHA:
# -- mounting via minikube start doesn't work so well
# minikube start --mount-string="$HOME/tmp/volume-for-minikube-1:/pv" --mount

# -- Terminate old mount processes
minikube mount --kill;


# ---------------------------------------------
# -- Preconditions
# ---------------------------------------------
# -- create dirs
mkdir -p $EXTRA_VOLUME


# ---------------------------------------------
# -- Run mount process (in background)
# -- GOTCHA: if process dies, mount stops working
# ---------------------------------------------
minikube mount $EXTRA_VOLUME:/pv &
# nohup minikube mount $EXTRA_VOLUME:/pv &


# ---------------------------------------------
# -- Print Help
# ---------------------------------------------
echo
echo "|-- To verify mount:"
echo "minikube ssh;"
echo ""
echo "# NOTE you are now userId=1000"
echo "# GOTCHA: this is an overlay fs, no changes persist"
echo ""
echo "touch /pv/foobar;"
echo "ls -hal /pv;"
echo "exit"


echo
echo "|-- To apply & verify the mount:"
echo "kubectl apply -f $SCRIPT_DIR/local.pv.yaml;"
echo "kubectl describe pv;"
echo "du -h $EXTRA_VOLUME;"
echo "ls -hal $EXTRA_VOLUME;"
