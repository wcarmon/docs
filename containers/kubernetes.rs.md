# Overview
1. Info on Kubernetes [`ReplicaSets`](TODO) & [~~ReplicationController~~](TODO)



# [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) (`rs`)
1. Namespaced
1. Ensures 1+ identical pods running somewhere in the cluster
1. Allows Horizontal scaling
1. Can be scaled anytime
1. Constantly monitors list of running Pods
1. Creates & removes Pods to match target count
1. Never reuses terminated Pods, just creates new Pod (somewhere) in the cluster
1. Never moves a Pod, just creates new Pod (somewhere) in the cluster
```sh
kubectl explain rs.spec.replicas;
kubectl explain rs.spec.selector;
kubectl explain rs.spec.template;
```


# ~~ReplicationController~~ (`rc`)
1. Namespaced
1. Legacy version of `ReplicaSet`



# Idioms
1. TODO:


# Other resources
1. TODO
