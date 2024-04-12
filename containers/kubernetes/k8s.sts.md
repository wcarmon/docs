# Overview
1. TODO


# Similarities to [`Deployment`](./k8s.deploy.md)
1. Creates 1 or more [`Pod`s](./k8s.pod.md)
1. `Pod`s are allocated/scheduled on any available `Node`


# Comparison to [`Deployment`](./k8s.deploy.md), `Job`, etc
1. Requires [`PersistentVolume`](TODO)
1. Adding/Removing pods does NOT affect PersistentVolume (Data safety)
1. `SatefulSet` does **NOT** guarantee pod termination when StatefulSet is deleted
1. Rolling updates are significantly more complex
1. `SatefulSet` creates a mapping between a `Pod` and Persistent storage


# Other resources
1. TODO
