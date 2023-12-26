# Overview
1. TODO


# [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) (`deploy`)
1. Namespaced
1. Higher-level concept than ReplicaSet, ReplicationController, ...
1. Automatically manages some ReplicaSets and Pods
1. Can be scaled anytime
```sh
kubectl get deploy;
kubectl get deployment;

kubectl describe deploy;
kubectl describe deploy $DEPLOYMENT_NAME;
```
