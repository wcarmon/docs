# Overview
1. Info on Kubernetes [`ReplicaSets`](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) & ~~ReplicationController~~


# Idioms
1. Use a [`Deployment`](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) to auto-manage `ReplicaSets`
1. **Don't** set `selector` on `ReplicaSet`, let it auto-manage from Pod template


# Cheatsheet
```sh
kubectl get rs;
kubectl get replicasets;
kubectl describe rs;

kubectl scale rs $RS_NAME --replicas=2
kubectl describe rs;

kubectl delete rs $RS_NAME;

kubectl get rc; # legacy
```


# [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) (`rs`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. Ensures 1+ identical pods running somewhere in the cluster
1. Allows Horizontal scaling
1. Can be scaled anytime
1. Constantly monitors list of running `Pod`s
1. Creates & removes Pods to match target count
1. `ReplicaSet` never reuses terminated a `Pod`, just creates new Pod (somewhere) in the cluster
1. `ReplicaSet` never moves a `Pod`, just creates new `Pod` (somewhere) in the cluster
```sh
kubectl explain rs.spec.replicas;
kubectl explain rs.spec.template;

kubectl explain rs.spec.selector;  # <-- Idiom: don't set this, it will take from Pod `template`
```


# ~~ReplicationController~~ (`rc`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. Legacy version of `ReplicaSet`, completely replaced with `ReplicaSet`
1. Don't use this, use `ReplicaSet`, or better, Use a `Deployment`
1. `ReplicaSet` has more expressive pod selectors (eg. pods lacking a label)
