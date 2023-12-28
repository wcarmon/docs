#!/bin/bash

set -e # exit on first error
set -o pipefail
set -u # fail on unset var


set -x
minikube stop;
minikube mount --kill;

minikube delete --all;
minikube delete --purge;

rm -rfv $HOME/tmp/volume-for-minikube-1/*

#sudo find / -name badger -type d
#sudo find / -name beagle -type d
#sudo find /var/lib/docker/overlay2/ -name badger -type d
#sudo find /var/lib/docker/overlay2/ -name beagle -type d

# ---------------------------------------------------------------
minikube start;

$HOME/git-repos/docs/containers/kubernetes/volume-examples/minikube.volume.sh

kubectl apply -f $HOME/git-repos/docs/containers/kubernetes/jaeger/

kubectl get deploy jaeger-deploy
kubectl get pod

kubectl describe deploy jaeger-deploy

# kubectl exec -it deploy/jaeger-deploy -- /bin/ash;
