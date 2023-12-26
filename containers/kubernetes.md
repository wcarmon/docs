# Overview
1. High-level overview of [Kubernetes](https://kubernetes.io/) (k8s)
1. See [cheatsheet](./cheatsheet.k8s.md)
1. See [Pod doc](./kubernetes.pods.md)


# Concepts

## Resource
1. A `Pod`, `Service`, `Deployment`, `ReplicaSet`, `DaemonSet`, `CronJob`, `PersistentVolume`, `ConfigMap`, etc
1. aka "api resource"
```sh
kubectl api-resources;
```


## [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) (`ns`)
1. Group of resources (the items below)
1. Provides **isolation** between unrelated applications
1. Allows multi-tenancy
```sh
kubectl get namespaces;
kubectl get ns;

kubectl describe ns;

kubectl describe namespace $NAMESPACE_NAME;
```


## [Node](https://kubernetes.io/docs/concepts/architecture/nodes/) (`no`)
1. A physical machine that Kubernetes can use
1. Has CPU, RAM, Disk, etc
1. Cluster-level (not namespaced)
1. Shared by all applications
```sh
kubectl get node;
kubectl get no;

kubectl describe no;
```


### Worker Node
1. Runs the deployed applications
1. Has a [container runtime](https://kubernetes.io/docs/setup/production-environment/container-runtimes/) (eg. crio, containerd, docker, rkt, etc)
1. Typically synonymous with `Node`


### Master Node
1. Hosts the Control Plane (manages the entire Cluster)
1. Handles [`kubectl`](https://kubernetes.io/docs/reference/kubectl/) commands


## Cluster
1. A group of `Node`s
1. All `Pod`s in a cluster share a single flat network-address space (no NAT)
    1. Communication between pods is always simple


## [Control plane](https://kubernetes.io/docs/concepts/overview/components/#control-plane-components)
1. Mostly on the master `Node`
1. Includes the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) on each worker, scheduler, etc.
1. includes [etcd](https://etcd.io/), the distributed key-value store for cluster config


## Workloads
1. TODO


## [Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
1. a key-value pair
1. Any resource can have labels (Pod, Node, Volume, Service, PersistentVolumeClaim, ...)
1. `[a-z0-9A-Z_\.\-]{1,63}`
1. you can add/modify/remove labels on existing resources
    1. use [`--overwrite`](TODO) when modifying


--------
## Execution

### [Pod](./kubernetes.pods.md) (`po`)
1. See [Pod](./kubernetes.pods.md) doc


### [ReplicaSet](./kubernetes.rs.md) & ~~ReplicationController~~ (`rs`)
1. See [ReplicaSet](./kubernetes.rs.md) doc


### [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) (`deploy`)
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

### [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) (`ds`)
1. Namespaced
1. Runs continuously (not a one-shot operation)
1. (at most) one pod per `Node`
1. Eg. Otel collector, log collector, perf analyzer, resource monitor, etc
1. Might need to mount a volume from the `Node`
1. Use `DaemonSet.spec.selector` to limit which `Node`s run the `DaemonSet`
```sh
kubectl explain ds.spec.template;

kubectl explain ds.spec.selector;
kubectl explain DaemonSet.spec.selector;

kubectl get ds;
```


### [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) (`sts`)
1. Namespaced
1. Useful for ... TODO


## Jobs & CronJobs
1. See [Jobs](./kubernetes.jobs.md) doc


--------
## Networking

### [Service](./kubernetes.services.md) (`svc`), Ingress & Endpoints
1. See [Services](./kubernetes.services.md) doc


--------
## Configuration

### [ConfigMap](TODO) (`cm`)
1. Namespaced
1. TODO

### [Secret](TODO)
1. Namespaced
1. TODO


--------
## Storage
- See [Volumes](./kubernetes.volumes.md) doc


# Architecture
- See [arch](./kubernetes.arch.md) doc
