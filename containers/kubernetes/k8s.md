# Overview
1. High-level overview of [Kubernetes](https://kubernetes.io/) (k8s)
1. See [cheatsheet](./cheatsheet.k8s.md)
1. See [Pod doc](./k8s.pod.md)

# Goals
1. To run containers efficiently on a pool of machines with the resources they need
1. HA, prevent downtime


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
1. A group/pool of `Node`s (computers)
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

### [Pod](./k8s.pod.md) (`po`)
1. See [Pod](./k8s.pod.md) doc


### [ReplicaSet](./k8s.rs.md) & ~~ReplicationController~~ (`rs`)
1. See [ReplicaSet](./k8s.rs.md) doc


### Deployments (`deploy`)
1. See [Deployments](./k8s.deploy.md) doc


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
1. Useful for stateful containers like Databases
1. maintains a sticky identity for each Pod replica


## Jobs & CronJobs
1. See [Jobs](./k8s.jobs.md) doc



## Networking, Services (`svc`), Ingress (`ing`) & Endpoints (`ep`)
1. See [Services](./k8s.svc.md) doc


## ConfigMaps, Secrets
1. See [ConfigMap](./k8s.cm.md) doc


## Storage
1. See [Volumes](./k8s.volumes.md) doc


## Auth

### Role
1. Permissions allows on some K8s API


### RoleBinding
1. "Join" between `Role` and `User` (or set of users) 


# Architecture
1. See [arch](./k8s.arch.md) doc
