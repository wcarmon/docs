# Overview
1. TODO


# [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) (`pv`)
1. Cluster-level (not namespaced)
1. Persists across Pod restarts
1. Independent of Pod lifecycle


# [EphemeralVolume](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)
1. No latency guarantees
1. Bound to the lifecycle of a Pod



# [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#lifecycle-of-a-volume-and-claim) (`pvc`)
1. Namespaced
1. TODO
1. A request for `PersistentVolume`


# [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) (`sc`)
1. Storage type



# Other resources
1. TODO
