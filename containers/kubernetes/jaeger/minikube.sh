#!/bin/bash

# -----------------------------------------------------
# -- Runs jaeger via minikube
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


# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")
readonly KUBECTL="minikube kubectl --"


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------


# ---------------------------------------------
# -- Config
# ---------------------------------------------


# ---------------------------------------------
# -- Run
# ---------------------------------------------
#echo
#echo "|-- Starting minikube ..."
#minikube start;


echo
echo "|-- Enabling required minikube addons ..."
minikube addons enable ingress;
minikube addons enable metrics-server


echo
echo "|-- Minikube Volume setup ..."
$PARENT_DIR/volume-examples/minikube.volume.sh;

echo
echo "|-- Applying local PersistentVolume  ..."
$KUBECTL apply -f $PARENT_DIR/volume-examples/local.pv.yaml

echo
echo "|-- Applying jaeger yamls ..."
$KUBECTL apply -f $SCRIPT_DIR/

sleep 1;


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Deployment:"
$KUBECTL get deploy jaeger-deploy;

echo
echo "|-- Pods:"
$KUBECTL get pod --selector app=jaeger;


# ---------------------------------------------
# -- Debug
# ---------------------------------------------
<<'DEBUGGING'
echo
echo "|-- Deployment:"
$KUBECTL describe deploy jaeger-deploy

echo
echo "|-- Pod logs:"
$KUBECTL logs "`$KUBECTL get pods -l app=jaeger --output=jsonpath={.items..metadata.name}`";
#$KUBECTL logs --selector app=jaeger

echo
echo "|-- Events:"
$KUBECTL get events --namespace=default

echo
echo "|-- Entering pod:"
$KUBECTL exec -it deploy/jaeger-deploy -- /bin/ash;


echo
echo "|-- Mounted Dir:"
PV_ROOT="$HOME/tmp/volume-for-minikube-1"
ls -hlt $PV_ROOT;
tree -L 3 $PV_ROOT;


DEBUGGING