# Overview
1. High-level overview of kubernetes

# Concepts

## Namespace (ns)
1. Group of resources below
1. Provides isolation between unrelated applications


## Pod (po)
1. "Atomic" unit for K8s
1. A Deployable unit
1. Like a single machine
1. 1+ co-located containers


## ReplicaSet (rs)
1. Ensures 1+ pods running somewhere in the cluster


## ~~ReplicationController~~
1. Legacy version of `ReplicaSet`


## Job
1. Runs completable task (unlike a Pod/Server which run forever)


## CronJob
1. Run once or periodically

## DaemonSet (ds)
1. (at most) one pod per node
1. Eg. Otel collector, log collector, perf analyzer, etc


## StatefulSet


## Deployment


## Net/Service (svc)


## Net/Endpoint

## Net/Ingress

## Conf/ConfigMap

## Conf/Secret

## Storage/PersistentVolume
1. Cluster-level (not in a namespace)

## Storage/PersistentVolumeClaim

## Storage/StorageClass

#


# Other resources
1. TODO
