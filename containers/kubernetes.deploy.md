# Overview
1. Info on [Kubernetes Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)


# Idioms
1. Roll forward to an old image instead of rolling back to old image
    1. more control over specific version (since "previous version" is stateful)
1. Minimize image tag reuse since [`pod.spec.containers.imagePullPolicy`](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy) must make a tough choice
    1. `Always`: slower, more unnecessary IO
    1. **`IfNotPresent`**: stale versions will take precedence  <-- Prefer this for immutable image tags
    1. `Never`: stale versions will take precedence or startup fails
    1. See `kubectl explain pod.spec.containers.imagePullPolicy;`


# [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) (`deploy`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. Higher-level concept than `ReplicaSet`, ~~ReplicationController~~, `Pod`, etc
1. Automatically manages ReplicaSets and Pods
1. Allows declarative app updates
    1. Manual rolling updates are tedious and error-prone, especially with rollback scenarios
1. Can be scaled anytime
```sh
kubectl get deployment;
kubectl get deploy;

kubectl describe deploy;
kubectl describe deploy $DEPLOYMENT_NAME;

kubectl explain deploy.metadata.name;
kubectl explain deploy.spec;

kubectl explain deploy.spec.replicas;
kubectl explain deploy.spec.selector;
kubectl explain deploy.spec.strategy;
kubectl explain deploy.spec.template.spec;

kubectl describe deploy;
kubectl describe deploy $DEPLOYMENT_NAME;
```
