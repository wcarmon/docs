#!/bin/bash

set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------------------------
readonly PV_ROOT="$HOME/tmp/volume-for-minikube-1"


# ---------------------------------------------------------------
$HOME/git-repos/docs/bash/examples/minikube/destroy.sh
#rm -rfv "$PV_ROOT/*"


# ---------------------------------------------------------------
echo
echo "|-- Starting minikube ..."
minikube start;

minikube addons enable ingress;
minikube addons enable metrics-server

echo
echo "|-- Minikube Volume setup ..."
$HOME/git-repos/docs/containers/kubernetes/volume-examples/minikube.volume.sh

echo
echo "|-- Applying jaeger yamls ..."
kubectl apply -f $HOME/git-repos/docs/containers/kubernetes/jaeger/

echo
echo "|-- Deployment:"
kubectl describe deploy jaeger-deploy

echo
echo "|-- Pods:"
kubectl get pod

echo
echo "|-- Pod logs:"
kubectl logs $(kubectl get pods -l app=jaeger --output=jsonpath={.items..metadata.name});

echo
echo "|-- Dir:"
tree -L 2 $PV_ROOT;

echo
echo "|-- Entering pod:"
kubectl exec -it deploy/jaeger-deploy -- /bin/ash;
