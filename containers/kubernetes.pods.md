# Overview
1. Info on [Kubernetes Pods](https://kubernetes.io/docs/concepts/workloads/pods/)


# [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) (`po`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. One or more co-located containers
    1. Containers in a `Pod` always run on the same `Node`
1. A collection of containers that can run on a host
1. The "Atomic" unit for Kubernetes
    1. Kubernetes doesn't deal with containers directly
    1. `Pod` never spans two `Nodes`
1. A Deployable unit
1. Like a single, logical machine (multiple processes/containers)
1. Pods are ephemeral (can be restart at any time)
1. Good Visualizations: [a](https://assets-global.website-files.com/61897bbb80b04406f137091a/618c37679af7c9a2c0a9f138_kubernetes-overview.png), [b](https://matthewpalmer.net/kubernetes-app-developer/articles/networking-overview.png), [c](https://k21academy.com/wp-content/uploads/2020/09/Screenshot-258.png), [d](https://www.altexsoft.com/static/blog-post/2023/11/f5f62de4-31f0-48c9-bb14-3935512789cd.webp), [e](https://www.wallarm.com/assets/external/6386e85a745e454610c5de96_kubernetes20pod20architecture.jpg),
1. Maybe a continuous running service (eg. `Deployment`, `ReplicaSet`) or a single-shot job (eg. `CronJob`, `Job`)
    1. See [`ReplicaSet`](./kubernetes.rs.md) doc
    1. See [Job](./kubernetes.jobs.md)s doc


## Networking
1. Containers (in a `Pod`) share network (`localhost`),
1. Containers (in a `Pod`) share [Linux namespace](https://man7.org/linux/man-pages/man7/namespaces.7.html)
1. Containers can reach each other via `localhost`
1. One IP address per `Pod` (shared port space for all containers in the `Pod`)
    1. Virtual IP, only routable/accessible inside the cluster
1. K8s assigns the IP to the Pod after scheduling to a node


## Storage
1. Containers have isolated filesystems by default
    1. They can share using a `Volume`


## Friends
1. [Init containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) run on startup
    1. init containers must terminate before the "main" container can run
    1. Useful for container preconditions/dependencies, but better to make container handle outages via [readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
1. [Sidecar Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/) TODO


## Help
```sh
kubectl explain pod;
kubectl explain pod.metadata;
kubectl explain pod.metadata.labels;
kubectl explain pod.spec.containers.ports;
kubectl explain pod.spec.containers.volumeMounts;
kubectl explain pod.spec.containers;
kubectl explain pod.spec.readinessGates;
kubectl explain pod.spec.volumes;
kubectl explain pod.spec;
kubectl explain pod.status;
```


--------
# Idioms
1. One process per Container
1. Only include containers which scale together (same cardinality, same lifecycle)
1. Pods are rarely created directly in practice
    - higher level concepts like [`Deployment`](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) manage lifecycle & rolling upgrades better

## Liveness Probe
1. **Always** define a [liveness probe](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes)
1. Always set an initial delay on the liveness probe to allow init time
1. Keep liveness probe light, they are executed relatively often


--------
# Probes

## [Liveness Probe](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes)
1. Allows app to communicate to Kubernetes it is alive
1. Kubernetes will restart the container if probe fails "enough" times
    1. Contrast with Readiness Probe
1. Mechanism:
    1. [HTTP GET](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-http-request), success on a `2xx` or `3xx`
        1. `/health` is a good url
        1. Spring boot uses `/actuator/health` & `/actuator/health/liveness`
        1. No auth required
    1. [gRPC probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-grpc-liveness-probe), success on [status=`SERVING`](https://grpc.github.io/grpc/core/md_doc_health-checking.html)
    1. [Exec](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-command) command, success on exit code of `0`
        1. Never use for JVM, JVM restart is relatively expensive
    1. (less common) [TCP probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-tcp-liveness-probe)
1. Should fail if restarting the Pod might help
    1. Contrast with Readiness Probe


### Help
```sh
kubectl explain pod.spec.containers.livenessProbe;

kubectl explain pod.spec.containers.livenessProbe.httpGet;
kubectl explain pod.spec.containers.livenessProbe.exec.command;
kubectl explain pod.spec.containers.livenessProbe.grpc;

kubectl explain pod.spec.containers.livenessProbe.failureThreshold;
kubectl explain pod.spec.containers.livenessProbe.initialDelaySeconds;
kubectl explain pod.spec.containers.livenessProbe.periodSeconds;
kubectl explain pod.spec.containers.livenessProbe.timeoutSeconds;
```


## Readiness Probe
1. Allows application to communicate it can handle requests
1. A container **WON'T** be killed for failing a Readiness Probe
    1. Contrast with Liveness Probe
1. Only "ready" `Pod`s are added to the `Service` `Endpoints`
1. Use [HTTP Probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#http-probes) or gRPC
1. Should fail if requests would fail anyway (eg. cannot reach database or an upstream service)
    1. Contrast with Liveness Probe


### Help
```sh
kubectl explain pod.spec.containers.readinessProbe;

kubectl explain pod.spec.containers.readinessProbe.httpGet;

kubectl explain pod.spec.containers.readinessProbe.failureThreshold;
kubectl explain pod.spec.containers.readinessProbe.initialDelaySeconds;
kubectl explain pod.spec.containers.readinessProbe.periodSeconds;
kubectl explain pod.spec.containers.readinessProbe.timeoutSeconds;
```


# Debugging
1. See ... TODO