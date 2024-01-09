# Overview
1. Summary of [Kustomize](https://kustomize.io/)
1. Useful for ...
    1. reuse of [Kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` files (without mutating the original)
    1. helps introduce env specific changes


# Features
1. `apply` "patches" to [Kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` files
1. Mental model: declarative intelligent [`sed`](https://www.gnu.org/software/sed/manual/sed.html) for kubernetes `*.yaml` files
1. No Templates (compare to [Helm](./helm.md))
1. Can **Add** or **Update** [resources](https://kubernetes.io/docs/concepts/overview/kubernetes-api/) (eg. Pod, Service, etc), (but not Delete)
    1. Resource `name` links them
1. Can use standalone or as a feature of [`kubectl`](https://kubernetes.io/docs/reference/kubectl/)
    `kustomize build /path/to/dir-with-kustomization-yaml/`
1. Optimized for small variations on shared config `*.yaml` files


# Idioms
1. Generally used AFTER [helm](./helm.md)


# Input
1. [Kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` files (called ["Base" files](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#base))
1. Patches
    - [`kustomization.yaml`](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#kustomization) ... TODO
    - [`patch.yaml`](TODO) ... TODO

# Output
1. A [Variant](TODO), One [Kubernetes](https://kubernetes.io/docs/concepts/overview/) `*.yaml` file


# Directory layout
1. [`kustomization.yaml`](TODO)


# Usage
1. `kubectl kustomize <KUSTOMIZATION_DIR>`  <-- this runs `build`
1. [or download and put binary on path](https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/) and run `kustomize build . > kustomize.output.yaml`


# Concepts

## Base
1. Original (possibly shared) k8s `*.yaml` files
1. Never mutated by Kustomize


## Generator
1. TODO


## [Transformer](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#transformer)
1. TODO


## [Variant](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#variant)
1. The final output after applying `overlay` to `base`


## [Overlay](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#overlay)
1. Applies to some base `*.yaml` file
1. An Overlay can be a base for another Overlay
1. `kustomization.yaml` + `patches.yaml`


## [Patch](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#patch)
1. instructions for modifying a resource


# TODO/Unorganized
- [`kubectl apply -k ...`](https://kubectl.docs.kubernetes.io/guides/config_management/introduction/)
- TODO: https://testingclouds.wordpress.com/2018/07/20/844/


# Other resources
1. https://kustomize.io/
1. https://github.com/kubernetes-sigs/kustomize
1. https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#kustomize
