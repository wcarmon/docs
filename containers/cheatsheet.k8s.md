# Overview
1. Cheatsheet of commonly used commands


# Get info
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
kubectl get po -A;

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

kubectl explain deployment;
kubectl explain deployment.spec.selector;
kubectl explain deployment.spec.template;
kubectl explain deployment.spec;

kubectl explain ingress;
kubectl explain ingress.spec;

kubectl explain pv;
kubectl explain PersistentVolume;
kubectl explain PersistentVolume.spec;

kubectl explain pvc;
kubectl explain PersistentVolumeClaim;
kubectl explain PersistentVolumeClaim.spec.resources;
kubectl explain PersistentVolumeClaim.spec.selector;
kubectl explain PersistentVolumeClaim.spec;



TODO: more interesting things

```


# Logs
```sh
kubectl logs $POD_NAME

# -- After container crashes
kubectl logs $POD_NAME --previous
kubectl describe pod $POD_NAME
```


# [Labeling](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
```sh
kubectl labels pod $POD_NAME foo=bar
kubectl labels pod $POD_NAME foo=bar --overwrite
```
1. https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#label
1. https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/


# Run
```bash
# -- Run nginx
kubectl create deployment my-deployment \
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

# Apply configuration to cluster
```sh
kubectl create -f my-conf.yaml
```
1. https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#apply



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


# Port forwarding
```sh
# <outsidePort>:<insidePort>
kubectl port-forward myPod 8888:80

kubectl help port-forward
```


# Delete/Cleanup
```sh
kubectl delete deployment foo;

kubectl help delete deployment;
```



# -- TODO
```sh
kubectl proxy
kubectl port-forward

```


# Other resources
1. TODO