#!/bin/bash

# -----------------------------------------------------
# -- Runs Postgres via minikube
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
readonly K8S_YAML_DIR="$SCRIPT_DIR"


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
echo "|-- Applying postgres yamls ..."
$KUBECTL apply -f $K8S_YAML_DIR/


echo "|-- waiting for cluster to update..."
sleep 3;


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Config map:"
$KUBECTL get cm --selector app=postgres;

echo
echo "|-- PersistentVolumeClaims:"
$KUBECTL get pvc --selector app=postgres;

echo
echo "|-- Service:"
$KUBECTL get svc --selector app=postgres;

echo
echo "|-- StatefulSet:"
$KUBECTL get sts postgres-sts;

echo
echo "|-- Pods:"
$KUBECTL get pod --selector app=postgres;


# ---------------------------------------------
# -- Debug
# ---------------------------------------------
<<'DEBUGGING'
echo
echo "|-- Deployment:"
$KUBECTL describe sts postgres-sts

echo
echo "|-- Pod logs:"
$KUBECTL logs "`$KUBECTL get pods -l app=postgres --output=jsonpath={.items..metadata.name}`";
#$KUBECTL logs --selector app=postgres

echo
echo "|-- Events:"
$KUBECTL get events --namespace=default

echo
echo "|-- Entering pod:"
$KUBECTL exec -it sts/postgres-sts -- /bin/bash;


echo
echo "|-- Mounted Dir:"
PV_ROOT="$HOME/tmp/volume-for-minikube-1"
ls -hlt $PV_ROOT;
tree -L 3 $PV_ROOT;

DEBUGGING