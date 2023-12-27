# Overview
1. Cheatsheet of commonly used commands


# Get info
```sh
# -- Get info
kubectl cluster-info;
kubectl version;

kubectl cluster-info | grep dashboard;

# -- Browser UI
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
```


# [Logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
```sh
kubectl logs $POD_NAME
kubectl logs --selector app=jaeger

# -- After container crashes
kubectl logs $POD_NAME --previous;
kubectl describe pod $POD_NAME;
```


# Debugging
- GOTCHA: ping does NOT work in the cluster
- [`kubectl exec -it $POD_NAME -- bash`](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) (or `... -- /bin/bash`)
    - add `--container $CONTAINER_NAME` flag when Pod has multiple containers
- ssh into any `Node` in the cluster, then `curl` a cluster IP
    - [`kubectl exec $POD_NAME -- curl -s http://$SVC_IP`](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec)
- List env vars: `kubectl exec $POD_NAME -- env`
```sh
# -- example output:
...
<serviceName>_PORT_443_TCP_ADDR=10.96.0.1
<serviceName>_PORT_443_TCP_PORT=443
<serviceName>_SERVICE_HOST=10.96.0.1
<serviceName>_SERVICE_PORT=443
<serviceName>_SERVICE_PORT_HTTPS=443
...
```


# Resource Usage
- `kubectl exec $POD_NAME -- df -h`
- `kubectl exec $POD_NAME -- ps aux`
- `kubectl top pod $POD_NAME`  # Depends on Metrics API
- See https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-pod-em-


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
kubectl scale deployment --replicas=2 $DEPLOYMENT_NAME;

kubectl help scale;
```


# Editing/Mutating Resources
|Method|Meaning|
|---|---|
|`kubectl apply -f ...`|Apply a full yaml to the existing definition|
|`kubectl edit ...`|Open object's manifest in default editor|
|`kubectl patch ...`|Modify one or two properties on in the config|
|`kubectl set image ...`|replace container image on `Pod`|


# Port forwarding
```sh
# <outsidePort>:<insidePort>
kubectl port-forward myPod 8888:80

kubectl help port-forward
```
1. See https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#port-forward



# Delete/Cleanup
```sh
kubectl delete deployment $DEPLOYMENT_NAME;

kubectl help delete deployment;
```


# -- TODO
```sh

# -- expoes api server
kubectl proxy --port=1234

kubectl port-forward ...

```
