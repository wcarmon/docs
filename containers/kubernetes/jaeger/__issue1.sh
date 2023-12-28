#!/bin/bash

#set -x
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------------------------
readonly PV_ROOT="$HOME/tmp/volume-for-minikube-1"
#rm -rfv "$PV_ROOT/*"


# ---------------------------------------------------------------
$HOME/git-repos/docs/bash/examples/minikube/destroy.sh


# ---------------------------------------------------------------
#echo
#echo "|-- Starting minikube ..."
minikube start;

$HOME/git-repos/docs/containers/kubernetes/jaeger/minikube.sh