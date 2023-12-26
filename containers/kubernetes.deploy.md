# Overview
1. Info on [Kubernetes Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)


# Idioms
1. Prefer `Deployment` over managing your own `ReplicaSet`s
1. Roll forward to an old image instead of rolling back to old image
    1. more control over specific version (since "previous version" is stateful)
1. Minimize image tag reuse since [`pod.spec.containers.imagePullPolicy`](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy) must make a tough choice
    1. `Always`: slower, more unnecessary IO
    1. **`IfNotPresent`**: stale versions will take precedence  <-- Prefer this for immutable image tags
    1. `Never`: stale versions will take precedence or startup fails (requires pre-fetching images)
    1. See `kubectl explain pod.spec.containers.imagePullPolicy;`


# [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) (`deploy`)
1. A [Namespaced](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) resource
1. Higher-level concept than `ReplicaSet`, ~~ReplicationController~~, `Pod`, etc
1. Automatically manages ReplicaSets and Pods
1. Allows declarative app updates
    1. Manual rolling updates are tedious and error-prone, especially with rollback scenarios
    1. Deployment prevents crazy scenarios when deployments stop part way through a rolling update
1. Can be scaled anytime
    1. Deployment "owns" one or more `ReplicaSet`s
    1. Owned `ReplicaSet` manages the lifecycle of the `Pod`s
    1. Deployment manages multiple `ReplicaSet` during rolling updates
1. `Pod` and `ReplicaSet` names contain a hash suffix, based on the pod template
    1. avoids duplicate deployments
1. `deploy.spec.strategy`:
    1. `Recreate`: kill all before creating new Pods (no live version overlap)
    1. `RollingUpdate`: gradual/incremental deployment (default)
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
kubectl explain deploy.spec.template.spec.containers;

kubectl explain pod.spec.containers.imagePullPolicy;
```


## Application Updates
1. Trigger a rollout by modifying the `Deployment`'s `Pod` template (`deploy.spec.template.spec`)
1. Change image: [`kubectl set image deployment $DEPLOYMENT_NAME $CONTAINER_NAME=$IMAGE`](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment)
1. Change one property: [`kubectl patch deployment $DEPLOYMENT_NAME -p ...`](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/update-api-object-kubectl-patch/)
```sh

# -- Status
kubectl rollout status deployment;
kubectl rollout status deployment $DEPLOYMENT_NAME;

TODO: scaling example
```
