# Overview
1. High-level overview of kubernetes

# Concepts

## [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) (ns)
1. Group of resources below
1. Provides isolation between unrelated applications


## [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) (po)
1. "Atomic" unit for K8s
1. A Deployable unit
1. Like a single machine
1. 1+ co-located containers
1. [Init containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) run on startup
    1. init containers must terminate before the "main" container can run
1. [Sidecar Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/) TODO


## [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) (rs)
1. Ensures 1+ identical pods running somewhere in the cluster


## ~~ReplicationController~~
1. Legacy version of `ReplicaSet`


## [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) (ds)
1. (at most) one pod per node
1. Eg. Otel collector, log collector, perf analyzer, etc


## [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)


## [Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
1. Runs completable task (unlike a Pod/Server which run forever)


## [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
1. Run once or periodically
1. one line of a crontab


## [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
1. Optional
1. Higher-level concept
1. Automatically manages some ReplicaSets and Pods


## [Net/Service](TODO) (`svc`)


## [Net/Endpoint](TODO) (`ep`)


## [Net/Ingress](TODO) (`ing`)


## [Conf/ConfigMap](TODO) (`cm`)


## [Conf/Secret](TODO)


## [Storage/PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) (`pv`)
1. Cluster-level (not in a namespace)


## [Storage/EphemeralVolume](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)



## [Storage/PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#lifecycle-of-a-volume-and-claim) (`pvc`)
1. A request for PersistentVolume


## [Storage/StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) (`sc`)
1. Storage type



# Other resources
1. TODO
