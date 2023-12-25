# Overview
1. High-level overview of [Kubernetes](https://kubernetes.io/) (k8s)
1. See [cheatsheet](cheatsheet.k8s.md)


# Concepts

## [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) (ns)
1. Group of resources (the items below)
1. Provides **isolation** between unrelated applications


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
1. A group of Nodes
1. All `Pod`s in a cluster share a single flat network-address space (no NAT)
    1. Communication between pods is always simple


## [Control plane](https://kubernetes.io/docs/concepts/overview/components/#control-plane-components)
1. Mostly on the master node
1. Includes the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) on each worker, scheduler, etc.
1. includes [etcd](https://etcd.io/), the distributed key-value store for cluster config


## Workloads
1. TODO


--------
## Execution

### [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) (`po`)
1. Namespaced
1. One or more co-located containers
    1. Containers in a `Pod` always run on the same `Node`
1. The "Atomic" unit for Kubernetes
    1. Kubernetes doesn't deal with containers directly
    1. `Pod` never spans two `Nodes`
1. A Deployable unit
1. Like a single, logical machine (multiple processes/containers)
1. Good Visualizations: [a](https://assets-global.website-files.com/61897bbb80b04406f137091a/618c37679af7c9a2c0a9f138_kubernetes-overview.png), [b](https://matthewpalmer.net/kubernetes-app-developer/articles/networking-overview.png), [c](https://k21academy.com/wp-content/uploads/2020/09/Screenshot-258.png), [d](https://www.altexsoft.com/static/blog-post/2023/11/f5f62de4-31f0-48c9-bb14-3935512789cd.webp), [e](https://www.wallarm.com/assets/external/6386e85a745e454610c5de96_kubernetes20pod20architecture.jpg),
1. Scaling: Everything in the Pod scales together (same cardinality, same lifecycle)
1. Idiom: one process per Container


#### Networking
1. Containers (in a `Pod`) share network (`localhost`),
1. Containers (in a `Pod`) share [Linux namespace](https://man7.org/linux/man-pages/man7/namespaces.7.html)
1. Containers can reach each other via `localhost`
1. One IP address per `Pod` (shared port space for all containers in the `Pod`)

#### Storage
1. Containers have isolated filesystems by default
    1. They can share using a `Volume`

#### Friends
1. [Init containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) run on startup
    1. init containers must terminate before the "main" container can run
    1. Useful for container preconditions/dependencies, but better to make container handle outages via [readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
1. [Sidecar Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/) TODO



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
1. TODO


# Other resources
1. TODO
