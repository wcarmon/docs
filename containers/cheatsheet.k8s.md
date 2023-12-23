# Overview
1. Cheatsheet of commonly used commands


# Commands

## Get info
```sh
# -- Get info
kubectl cluster-info;

kubectl get deployments;
kubectl get nodes;

kubectl get namespace;
kubectl get ns;

kubectl get pods;
kubectl get po;

kubectl get services;
kubectl get svc;

kubectl get endpoints;
kubectl get ep;

kubectl get ingress;
kubectl get ing;

kubectl get configmap;
kubectl get cm;

# -- Get detailed info
NODE_NAME=minikube;
kubectl describe node $NODE_NAME;
```


# Help
```sh
kubectl help create deployment;
kubectl help run;
```


# Run
```bash
# -- Run nginx
kubectl create deployment deployment-1 \
--image=nginx \
--replicas=1 \
--port=9090;

# -- Run postgress
kubectl run pg-deployment \
--image="postgres:15" \
--env="POSTGRES_DB=foo" \
--env="POSTGRES_PASSWORD=quux123" \
--env="POSTGRES_USER=sa" \
--port=4433;


```


# -- TODO
```sh
kubectl proxy

```


# Other resources
1. TODO