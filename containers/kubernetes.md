# Overview
1. High-level overview of [Kubernetes](https://kubernetes.io/) (k8s)
1. See [cheatsheet](./cheatsheet.k8s.md)
1. See [pod doc](./kubernetes.pods.md)


# Concepts

## [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) (ns)
1. Group of resources (the items below)
1. Provides **isolation** between unrelated applications
1. Allows multi-tenancy


## [Node](https://kubernetes.io/docs/concepts/architecture/nodes/)
1. A physical machine that Kubernetes can use
1. Has CPU, RAM, Disk, etc
1. Cluster-level (not namespaced)
1. Shared by all applications


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

### [Pod](./kubernetes.pods.md)
1. See [Pod](./kubernetes.pods.md) doc


### [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) (`rs`)
1. Namespaced
1. Ensures 1+ identical pods running somewhere in the cluster
1. Allows Horizontal scaling
1. Can be scaled anytime


### ~~ReplicationController~~ (`rc`)
1. Namespaced
1. Legacy version of `ReplicaSet`


### [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) (`deploy`)
1. Namespaced
1. Higher-level concept than ReplicaSet, ReplicationController, ...
1. Automatically manages some ReplicaSets and Pods
1. Can be scaled anytime


### [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) (`ds`)
1. Namespaced
1. (at most) one pod per node
1. Eg. Otel collector, log collector, perf analyzer, etc


### [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) (`sts`)
1. Namespaced
1. Useful for ... TODO


### [Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
1. Namespaced
1. Runs completable task (unlike a Pod/Server which run forever)


### [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) (`cj`)
1. Namespaced
1. Run once or periodically
1. one line of a crontab


--------
## Networking
### [Service](TODO) (`svc`)
1. Namespaced
1. TODO


### [Endpoint](TODO) (`ep`)
1. Namespaced?  TODO
1. TODO


### [Ingress](TODO) (`ing`)
1. Namespaced
1. TODO


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

### [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) (`pv`)
1. Cluster-level (not namespaced)
1. Persists across Pod restarts
1. Independent of Pod lifecycle


### [EphemeralVolume](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)
1. No latency guarantees
1. Bound to the lifecycle of a Pod



### [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#lifecycle-of-a-volume-and-claim) (`pvc`)
1. Namespaced
1. TODO
1. A request for `PersistentVolume`


### [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) (`sc`)
1. Storage type


--------
# Architecture
- See [arch doc](./kubernetes.arch.md)


--------



# Other resources
1. TODO
