# Overview
1. [Flux](TODO)
1. CD tool (Continuous Deployment)


# Features
1. Open-source
1. Declarative
1. Automate everything from Artifactory to running application
1. [Helm](./helm.md) aware
1. [K8s](./k8s.md) aware
1. [Kustomize](./kustomize.md) aware
1. GitHub aware
1. GitLab aware
1. (Mostly) removes the need to execute `kubectl`
1. Supports an arbitrary number of git repos
1. Sends notifications 


# Flux Input
1. One or more [Source](./flux.sources.md)s
1. Desired state
1. eg. kubernetes `*.yaml` files in some git repository or helm charts in some git repository


# Flux Output
1. An application running in a k8s cluster


-------- 
# Concepts
1. Flux is a set of [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)

## GitOps
1. Links
    1. https://about.gitlab.com/topics/gitops/
    1. https://www.weave.works/technologies/gitops/
1. Patterns for Continuous Deployment of cloud native apps
1. A git repo has the desired state of runtime (declarative) 
1. Pull-based deployment (Eventually consistent)


## Source and Source Controller 
1. See [doc](./flux.sources.md)


## HelmController (Kubernetes operator)
1. Helps auto manage helm chart releases
1. Consumes source (eg. `HelmRepository`) 
1. https://github.com/fluxcd/helm-controller/
1. Watches `HelmRelease`s (fetched by SourceController)
1. Generates `HelmChart`s
1. Executes helm actions/operations against the k8s cluster
1. Reports events to [`NotificationController`](https://github.com/fluxcd/notification-controller)
1. Includes a [Kustomize](https://kustomize.io/) [post renderer](https://helm.sh/docs/topics/advanced/#post-rendering)
1. https://fluxcd.io/flux/guides/helmreleases/
1. https://github.com/fluxcd/helm-controller/blob/main/docs/spec/README.md
1. https://github.com/fluxcd/helm-controller/blob/main/docs/spec/v2beta2/README.md


## KustomizationController
1. Consumes source (eg. `HelmRepository`)
1. https://github.com/fluxcd/kustomize-controller/


## Reconciliation
1. Ensures Cluster state matches desired state
1. [`HelmRelease`](https://fluxcd.io/flux/components/helm/helmreleases/) Custom Resource
     1. The desired state of a Helm release
1. [`Kustomization`](TODO)
    1. [Flux Kustomization](TODO) is different from [Kubernetes Kustomization] (TODO)
1. [`flux reconcile source helm <repository-name>`](https://fluxcd.io/flux/cmd/flux_reconcile/)


- TODO: https://github.com/kubernetes/design-proposals-archive/blob/main/architecture/declarative-application-management.md


--------
# UI
1. [Weave gitops](https://github.com/weaveworks/weave-gitops)


# Flagger
1. https://fluxcd.io/flagger/faq/
1. Progressive Delivery (gradual rollout)
1. eg. A/B testing


# Alternatives
1. ~~argo CD~~ lost this war (see [gitlab article](https://about.gitlab.com/blog/2023/02/08/why-did-we-choose-to-integrate-fluxcd-with-gitlab/)) 


# Other resources
1. TODO


# TODO/Unorganized:
- Deployment is based on tags
- [Image Automation Controller](https://fluxcd.io/flux/components/image/)
   - scans container images
   - auto-tagging
- [Notification Controller](https://fluxcd.io/flux/components/notification/)
   - Input: events from git repo, Jenkins
   - Output: Slack, ...
- https://fluxcd.io/flux/components/source/helmrepositories/  <-- now
- https://fluxcd.io/flux/components/helm/helmreleases/

https://fluxcd.io/flux/components/kustomize/
- https://fluxcd.io/flux/components/kustomize/kustomizations/
- https://fluxcd.io/flux/faq/#kustomize-questions

- https://fluxcd.io/flux/flux-e2e/
- https://fluxcd.io/flux/faq/
  
- https://fluxcd.io/flux/components/source/
- https://fluxcd.io/flux/components/
- https://fluxcd.io/flux/cheatsheets/troubleshooting/
- https://fluxcd.io/flux/cmd/flux_create_image/
- https://fluxcd.io/flux/get-started/
- https://fluxcd.io/flux/gitops-toolkit/
- https://fluxcd.io/flux/guides/
- https://fluxcd.io/flux/monitoring/
- https://fluxcd.io/flux/use-cases/
