# Overview
1. Info on [Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/)


# [Service](https://kubernetes.io/docs/concepts/services-networking/service/) (`svc`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. A single, **stable**, **constant** entry point for a group of pods (IP + ports)
    1. `Service`s convert the ephemeral lifecycle of pods into a stable IP address
1. A Load-balancing mechanism for `Pod` replicas    
1. All `Pod`s *should* have the same application
1. Has one IP address (generally)
1. Supports [multiple ports](https://kubernetes.io/docs/concepts/services-networking/service/#multi-port-services)
    1. GOTCHA: each port [requires a `name`](https://kubernetes.io/docs/concepts/services-networking/service/#multi-port-services)
    1. `kubectl explain service.spec.ports.name;` (names like `"http"` or `"https"` or `"grpc"`)
1. A facade over n-`Pod`s
    1. choose `Pod`s using (label) [`selector`](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
1. `Service`s link to `Pod`s thru `Endpoints`
    1. No need to manage `Endpoints` directly
    1. `Endpoints` **must** have same name as the `Service`
1. [Naming restrictions](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#rfc-1035-label-names)
    1. `[a-z][a-z0-9\-]{0,61}[a-z0-9]`  (63 chars max)
1. ~~You can also use the Service as an alias for an external service~~
    1. GOTCHA: This makes your application dependent on extra DNS config (when running outside kubernetes)


## Important Service fields
1. [`type`](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types):
    1. `ClusterIP`: only accessible inside the cluster (default)
    1. `NodePort`: exposes the SAME port(s) on EVERY `Node`.  Useful for non-HTTP and non-HTTPS services
    1. `LoadBalancer`: exposes using an external load balancer (eg. your cloud provider's LB)
1. [`externalIPs`](https://kubernetes.io/docs/concepts/services-networking/service/#external-ips): IP addresses managed outside Kubernetes, accessible **outside** the cluster
1. `clusterIP`: randomly assigned IP, immutable, accessible **only within** the cluster
1. `clusterIPs`: randomly assigned, immutable, accessible **only within** the cluster
    1. at most 2 values
    1. Setting to `clusterIPs="None"` creates a [Headless Service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)
        1. Useful for communicating with ALL pods and getting their IP addresses via DNS (multiple [A-record](https://support.dnsimple.com/articles/a-record/)s)


## [Discovery](https://kubernetes.io/docs/concepts/services-networking/service/#discovering-services)
1. Kubernetes assigns each `Service` a DNS entry (in the DNS maintained by the cluster)
    1. FQDN: `<serviceName>.<namespace>.svc.cluster.local`
    1. If your Container is in the same namespace, just use `<serviceName>`
        - eg. `http://myService/api/v1/...`
    1. DNS helps you with the hostname, but not with ports
    1. [Only `Pod`s and `Service`s get DNS records](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#dns-records)
1. Kubernetes exposes service IP & port(s) info via [environment variables](https://kubernetes.io/docs/concepts/services-networking/service/#environment-variables)
    1. dashes in serviceName converted to underscores
    1. all letters are upper-cased


## Networking
1. To quickly expose a `Deployment`, `ReplicaSet`, `Pod` or another `Service`:
    1. In practice, better to create a yaml file with `kind: Service`
```sh
kubectl expose $RESOURCE_TYPE $RESOURCE_NAME --port=$EXTERNAL_PORT --target-port=$PORT_IN_CONTAINER;
```


## Routing
1. Service (proxy) randomly selects one of the IPs from `endpoints.subsets.addresses`, and redirects/forwards the connection


## Debugging
1. See [cheatsheet](./cheatsheet.k8s.md) doc
1. GOTCHA: ping does NOT work in the cluster


## Help
```sh
kubectl get services;
kubectl get svc;
kubectl describe svc;

kubectl get ingress;
kubectl get ing;
kubectl describe ing;

kubectl get endpoints;
kubectl get ep;
kubectl describe ep;

kubectl help expose;

kubectl explain service.spec;
kubectl explain service.spec.clusterIP;
kubectl explain service.spec.clusterIPs;
kubectl explain service.spec.externalIPs;
kubectl explain service.spec.ports;
kubectl explain service.spec.selector;
kubectl explain service.spec.type;

kubectl explain ingress;
kubectl explain ingress.spec;
kubectl explain ingress.spec.rules;
kubectl explain ingress.spec.rules.host;
kubectl explain ingress.spec.rules.http;
kubectl explain ingress.spec.rules.http.paths;
kubectl explain ingress.spec.rules.http.paths.path;
kubectl explain ingress.spec.rules.http.paths.backend;
kubectl explain ingress.spec.rules.http.paths.backend.service;
kubectl explain ingress.spec.rules.http.paths.backend.service.name;
kubectl explain ingress.spec.rules.http.paths.backend.service.port;

kubectl explain endpoints.subsets;
kubectl explain endpoints.subsets.addresses;
kubectl explain endpoints.subsets.ports;
```


# [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) (`ing`)
1. Think: [nginx](https://www.nginx.com/)
1. Manages **external** access to services in the cluster
1. An entry point for the cluster
1. Ingress is NOT a service `type`
1. Exposes HTTP (on 80) and HTTPS (on 443) routes from outside the cluster to `Service`s
    1. Again, focused only on HTTP and HTTPS routes
    1. Other ports are handled with other mechanisms
1. Can expose multiple `Service`s thru one `Ingress`
    1. Think: [nginx reverse proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
1. Handles SSL termination
1. Handles name based virtual hosting
    1. Consolidates routing rules into 1 resource
1. This *might* be deprecated by [`Gateway`](https://kubernetes.io/docs/concepts/services-networking/gateway/) one day
    1. An `Ingress` is a simplified `Gateway`
1. Requires an ingress controller
    1. Enable: `minikube addons enable ingress;`
    1. Verify: `minikube addons list | grep -i ingress;`
1. OpenShift calls this a [Route](https://docs.openshift.com/container-platform/4.14/networking/routes/route-configuration.html)


## TLS Certificates
1. TODO: `kubectl certificate approve $CERT_NAME`


# Endpoints (`ep`)
1. The "many-to-many" join between `Service`s and `Pod`s
1. Only contains Containers that pass [Readiness probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-readiness-probes)
```sh
kubectl describe endpoints;
```
