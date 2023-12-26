# Overview
1. Info on [Kubernetes Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)


# Storage options

## Container file system
1. Container Local, temporary (transient) storage (colocated with `Pod`)
1. Part of the image's file system
1. Lifespan: as long as the Pod lives
1. Maybe read-only or read-write (depends on the image)
1. Ephemeral (dropped when container stopped)
1. No way to share
1. Idiom: Prefer `EphemeralVolume` over Container file system


# [EphemeralVolume](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)
1. `Pod` Local, temporary (transient) storage (colocated with `Pod`)
    1. scratch space
1. Lifespan: as long as the Pod lives
1. No latency guarantees
1. Bound to the lifecycle of a Pod
1. Useful for cached data
1. Useful for sharing data between containers in same Pod
1. [`emptyDir`](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) is common & the simplest
    1. `kubectl explain pod.spec.volumes.emptyDir;`
1. [ConfigMap](TODO)s and secrets are exposed using EphemeralVolume (read-only)
1. TODO: how to list, create


# [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) (`pv`)
1. Cluster-level (not namespaced)
1. Persists across Pod restarts
1. Independent of Pod lifecycle
    1. NOT destroyed when Pod terminates
1. Generally created and managed by the k8s administrator
```sh
kubectl get pv;
kubectl describe pv;
```


# [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#lifecycle-of-a-volume-and-claim) (`pvc`)
1. Namespaced
1. A request for `PersistentVolume`
1. Reserves (claims) part of a `PersistentVolume`
1. See `pod.spec.volumes.persistentVolumeClaim`
1. Pod doesn't need to know the details
1. [AccessModes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes)
    1. `RWO`: single reader `Node`, single writer `Node`
    1. `ROX`: multi-reader `Node`s, no writers
    1. `RWX`: multi-reader `Node`s, multi-writer `Node`s
    1. `RWOP`: single reader `Pod`, single writer `Pod`
```sh
kubectl get pvc;
kubectl describe pvc;

kubectl explain pod.spec.volumes.persistentVolumeClaim
```


# [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) (`sc`)
1. Storage type
```sh
kubectl get StorageClass;
kubectl get sc;
kubectl describe sc;
```


# Idioms
1. `DaemonSet` might need `hostPath` volume to manage resources on the `Node`
    1. `kubectl explain pod.spec.volumes.hostPath`
1. [`hostPath`](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) is a security risk, don't use for sharing
1. [`subPath`](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath) lets you share one volume between containers in a `Pod`, but with logical isolation
1. set [`pvc.spec.storageClassName`](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#class) to empty string


## Sharing files
1. Mount the same volume to multiple containers
1. Expose the file system indirectly thru a `Service`


# Help
```sh
kubectl explain pod.spec.volumes
kubectl explain pod.spec.volumes.configMap
kubectl explain pod.spec.volumes.emptyDir
kubectl explain pod.spec.volumes.persistentVolumeClaim
kubectl explain pod.spec.volumes.secret

kubectl explain pod.spec.containers.volumeMounts
kubectl explain pod.spec.containers.volumeMounts.mountPath
kubectl explain pod.spec.containers.volumeMounts.readOnly
kubectl explain pod.spec.containers.volumeMounts.subPath

kubectl explain pvc.spec.accessModes
kubectl explain pvc.spec.storageClassName
```
