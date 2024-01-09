# Overview
1. Info on [Kubernetes ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) and [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)


# Idioms
1. Use same name for configMap across envs (dev.cm.yaml, qa.cm.yaml, prod.cm.yaml all contain a `ConfigMap` with same `name`)
1. Don't rely on command line args
    1. They conflict with too many other things (like `delve`, junit, java debugger protocol, etc)
1. You can combine multiple configs into 1 `ConfigMap`
    1. [`kubectl create configmap my-config --from-file=/some/parent/dir`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#create-configmaps-from-directories)
1. GOTCHA: k8s will ignore keys [containing a dash (with a warning in events)](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#restrictions)
    1. so prefer camelCase or snake_case
1. Don't use env variables for Secrets (only use `Volume`s)
    1. env variables are easily exposed accidentally
1. Use `immutable` for Config and Secrets (`cm.immutable` and `secrets.immutable`)


# [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) (`cm`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. Decouples configuration from code   
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
    1. camelCase
    1. a.b.c.d.property
    1. ~~kebab-case~~  <-- supported, but avoid because k8s will do the wrong thing when using as env var ([`envFrom`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#restrictions))
```sh
kubectl get configMap;
kubectl get cm;

kubectl describe cm;

kubectl explain cm.metadata.name;
kubectl explain cm.data;
kubectl explain cm.immutable;

kubectl explain pod.spec.containers.envFrom;
kubectl explain pod.spec.volumes.configMap;

kubectl help create configmap;
kubectl help edit configmap;
```


## Config environment vars example
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: foo-container
      image: registry.k8s.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      envFrom:
      - configMapRef:
          name: my-config-name
```


## Config Volume example
1. See https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#populate-a-volume-with-data-stored-in-a-configmap
1. Useful for exposing app specific conf files (like [`nginx.conf`](https://www.nginx.com/resources/wiki/start/topics/examples/full/#nginx-conf), `postgresql.conf`, etc)
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
     - name: my-config-volume
       configMap:
          name: myconfigmap   # <-- already defined in separate file
```


--------
# [Secret](https://kubernetes.io/docs/concepts/configuration/secret/)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. For confidential/sensitive data
    1. eg. database credentials, external service credentials, private keys, etc
1. Always stored in memory, (never written to disk)
    1. etcd stores **unencrypted**
1. [Best practices](https://kubernetes.io/docs/concepts/security/secrets-good-practices/)
1. `imagePullSecrets` lets you Authenticate with Docker Registry (eg. Artifactory, DockerHub, etc)
```sh
kubectl get secrets;

kubectl describe secrets;

kubectl explain secrets
kubectl explain secrets.metadata.name;

kubectl explain secrets.data;
kubectl explain secrets.immutable;
kubectl explain secrets.stringData;

kubectl explain pod.spec.volumes;
kubectl explain pod.spec.volumes.secret;
kubectl explain pod.spec.volumes.secret.secretName;

kubectl explain pod.spec.imagePullSecrets;

kubectl help create secret;
kubectl help edit secret;
```
