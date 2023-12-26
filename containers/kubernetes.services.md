# Overview
1. Info on [Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/)


# [Service](https://kubernetes.io/docs/concepts/services-networking/service/) (`svc`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. A single, stable, **constant** entry point for a group of pods (IP + ports)
1. All `Pod`s *should* have the same application
1. Has an IP address
1. Supports multiple ports
    1. GOTCHA: each port needs a `name`
    1. `kubectl explain service.spec.ports.name;` (like `http` or `https` or `grpc`)
1. Connects to n-`Pod`s using [`selector`](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)


## Properties
1. `externalIPs`: IP managed outside Kubernetes, accessible outside the cluster
1. `clusterIP`: randomly assigned IP, immutable, accessible only within the cluster
1. `clusterIPs`: randomly assigned, immutable, accessible only within the cluster
    1. TODO: "None"
    1. at most 2 values


## Networking
1. To quickly expose a `Deployment`, `ReplicaSet`, `Pod` or another `Service`:
    1. In practice, better to create a yaml file with `kind: Service`
```sh
kubectl expose $RESOURCE_TYPE $RESOURCE_NAME --port=$EXTERNAL_PORT --target-port=$PORT_IN_CONTAINER;
```

## Discovery
1. Kubernetes assigns each `Service` a DNS entry (cluster maintains a DNS)
    1. FQDN: `<serviceName>.<namespace>.svc.cluster.local`
    1. If you're in the same namespace, just use `<serviceName>`  (eg. `http://myService/api/v1/...`)
    1. DNS helps you with the name, but not with ports
1. Kubernetes exposes service IP & port(s) info via environment variables
    1. dashes in serviceName converted to underscores
    1. all letters are upper-cased



## Debugging
1. See [cheatsheet](./cheatsheet.k8s.md) doc
1. GOTCHA: ping does NOT work in the cluster


## Help
```sh
kubectl get services;
kubectl get svc;

kubectl help expose;

kubectl explain service.spec;
kubectl explain service.spec.clusterIP;
kubectl explain service.spec.clusterIPs;
kubectl explain service.spec.externalIPs;
kubectl explain service.spec.ports;
kubectl explain service.spec.selector;
kubectl explain service.spec.type;
```

--------
# Idioms


- TODO: parse https://kubernetes.io/docs/concepts/services-networking/service/


# Other resources
1. TODO
