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


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly EXTRA_VOLUME="/tmp/volume-for-minikube-1"


# ---------------------------------------------
# -- Run mount process
# ---------------------------------------------


# GOTCHA:
# mounting via minikube start doesn't work so well
# minikube start --mount-string="/tmp/volume-for-minikube-1:/pv" --mount


# -- Cleanup old mounts
minikube mount --kill;

# -- Make room
mkdir -p $EXTRA_VOLUME


# -- Run mounter in background
# -- if process dies, mount stops working
# -- cleanup: minikube mount --kill

# nohup minikube mount $EXTRA_VOLUME:/pv &
minikube mount $EXTRA_VOLUME:/pv &


# ---------------------------------------------
# -- Print Help
# ---------------------------------------------
echo "|-- To verify mount:"
echo "minikube ssh;"
echo "touch /pv/foobar"
echo "ls -hal /pv"
echo "exit"


# ---------------------------------------------
# --
# ---------------------------------------------

echo "kubectl apply -f $PARENT_DIR/volume-examples/local.pv.yaml"
#
# kubectl describe pv
# du -h /tmp/volume-for-minikube-1
#
# kubectl delete deploy jaeger-deploy;
# kubectl delete pvc jaeger-pvc;
# kubectl delete pv my-volume-1;
