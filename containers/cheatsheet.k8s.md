# Overview
1. Cheatsheet of commonly used commands


# Commands

## Get info
```sh
# -- Get info
kubectl cluster-info;
kubectl version;

kubectl cluster-info | grep dashboard;
minikube dashboard &

kubectl api-resources;

kubectl get nodes;
kubectl get no;

kubectl get namespace;
kubectl get ns;

kubectl get deployments;
kubectl get deploy;

kubectl get replicasets;
kubectl get rs;

kubectl get services;
kubectl get svc;

kubectl get endpoints;
kubectl get ep;

kubectl get ingress;
kubectl get ing;

kubectl get pods;
kubectl get po;
kubectl get po -o wide;

POD_NAME=foo
kubectl describe po $POD_NAME;


kubectl get configmap;
kubectl get cm;

kubectl get pvc;

kubectl get pv;

# -- Get detailed info
NODE_NAME=minikube;
kubectl describe node $NODE_NAME;
```


# Help
```sh
kubectl help create deployment;
kubectl help expose rs;
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


# Expose services
```sh
kubectl expose rs my-rs --port 3344 --type NodePort --name whatever
```


# Scaling

## Deployment
```sh
DEPLOYMENT_NAME=deployment-1;
kubectl scale deployment --replicas=2 $DEPLOYMENT_NAME

kubectl help scale
```


## ReplicaSet
```sh
TODO
```


# -- TODO
```sh
kubectl proxy

```


# Other resources
1. TODO