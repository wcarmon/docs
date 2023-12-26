# Overview
1. Info on [Kubernetes ConfigMap](TODO) and [Secrets](TODO)


# [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) (`cm`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. key-value pairs (Think: `Map<String, String>` or `map[string]string`)
1. For non-confidential data
    1. certificates, server urls, timeouts, jwt expiration, min/max/limit values, etc
1. (Mostly) For environment-specific configuration
1. Keeps your app generic/reusable
1. Limit: 1 mb max
    1. If you need more, mount a volumne or access a separate config database
1. Applications are **NOT** ConfigMap or Secret aware
    1. Applications just read env variables or on the mounted volume
    1. `Pod` definition just references ConfigMap by `name`
1. Key naming: (be consistent)
    1. snake_case
    1. kebab-case
    1. a.b.c.d.property
```sh
kubectl get configMap;
kubectl get cm;

kubectl describe cm;

kubectl explain cm.metadata.name;
kubectl explain cm.data;
kubectl explain cm.immutable;

kubectl help create configmap;
```
1. Example
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: demo
      image: alpine
      ...
      volumeMounts:
      - name: config
        mountPath: "/etc/app/config"
        readOnly: true

  volumes:
     - name: my-config-map
       configMap:
          name: myconfigmap
```


# [Secret](https://kubernetes.io/docs/concepts/configuration/secret/)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. For confidential data
    1. eg. database credentials, external service credentials, private keys, etc
1. TODO
```sh
```


# Idioms
1. Use same name for configMap across envs (dev.cm.yaml, qa.cm.yaml, prod.cm.yaml all contain a `ConfigMap` with same `name`)
1. Don't rely on command line args
    1. They conflict with too many other things (like `delve`, junit, java debugger protocol, etc)


- TODO: https://kubernetes.io/docs/concepts/storage/volumes/#secret

