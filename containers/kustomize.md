# Overview
1. Summary of [Kustomize](https://kustomize.io/)
1. Goal: reuse of [kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` files (without mutating the original)


# Features
1. apply "patches" to [kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` files
1. Mental model: intelligent [`sed`](https://www.gnu.org/software/sed/manual/sed.html) for kubernetes `*.yaml` files
1. No templates (compare to [Helm](./helm.md))
1. Declarative
1. Can **Add** or **Update** [resources](https://kubernetes.io/docs/concepts/overview/kubernetes-api/) (eg. Pod, Service, etc), (but not Delete)
1. Can use standalone or as a feature of [`kubectl`](https://kubernetes.io/docs/reference/kubectl/)
1. Optimized for small variations on shared config `*.yaml` files


# Input
1. [kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` files
1. Patches


# Output
1. A [Variant](TODO), One [kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` file


# TODO/Unorganized
- [`kubectl apply -k ...`](https://kubectl.docs.kubernetes.io/guides/config_management/introduction/)
- kustomization.yaml


# Other resources
1. https://kustomize.io/
1. https://github.com/kubernetes-sigs/kustomize
