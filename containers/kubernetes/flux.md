# Overview
1. [Flux](TODO)
1. CD tool (Continuous Deployment)


# Features
1. OpenSource
1. Declarative
1. Automate everything from Artifactory to running application
1. [Helm](./helm.md) aware
1. [K8s](./k8s.md) aware
1. [Kustomize](./kustomize.md) aware
1. GitHub aware
1. GitLab aware
1. (Mostly) removes the need to execute `kubectl`


# Input


# Output


# Concepts

## GitOps
1. Links
    1. https://about.gitlab.com/topics/gitops/
    1. https://www.weave.works/technologies/gitops/
1. Patterns for Continuous Deployment of cloud native apps
1. A git repo has the desired state of runtime (declarative) 
1. Pull-based deployment (Eventually consistent)


## [Source](TODO)
1. Contents
    1. Has desired state (or running cluster) 
    1. Has version selectors
    1. Has credentials
1. Flux checks (origin of) Source periodically (eg. every 5 minutes)
1. All Sources are [CRDs (Custom Resources)](TODO)
1. `HelmRepository`
    1. https://github.com/fluxcd/source-controller/blob/main/docs/spec/v1beta2/helmrepositories.md
    1. `index.yaml`


## [Source Controller](https://fluxcd.io/flux/components/source/)
1. 
1. [Spec](TODO)
   Validate source definitions
   Authenticate to sources (SSH, user/password, API token)
   Validate source authenticity (PGP)
   Detect source changes based on update policies (semver)
   Fetch resources on-demand and on-a-schedule
   Package the fetched resources into a well-known format (tar.gz, yaml)
   Make the artifacts addressable by their source identifier (sha, version, ts)
   Make the artifacts available in-cluster to interested 3rd parties
   Notify interested 3rd parties of source changes and availability (status conditions, events, hooks)

## Reconciliation
1. Ensures Cluster state matches desired state
1. [`HelmRelease`](TODO)
1. [`Kustomization`](TODO)
    1. [Flux Kustomization](TODO) is different from [Kubernetes Kustomization] (TODO)


- TODO: https://github.com/kubernetes/design-proposals-archive/blob/main/architecture/declarative-application-management.md


# Other resources
1. TODO


# TODO/Unorganized:
- Deployment is based on tags
- Runs in a Kubernetes cluster
- Polls a (remote) git repo (eg. gitlab) at configurable interval
- It uses Helm and Kustomize


https://fluxcd.io/flux/components/source/
https://fluxcd.io/flux/components/source/helmrepositories/
https://fluxcd.io/flux/components/
https://fluxcd.io/flux/components/helm/
https://fluxcd.io/flux/components/helm/helmreleases/
https://fluxcd.io/flux/components/kustomize/
https://fluxcd.io/flux/components/kustomize/
https://fluxcd.io/flux/components/kustomize/kustomizations/
https://fluxcd.io/flux/faq/#kustomize-questions
https://fluxcd.io/flagger/faq/
https://fluxcd.io/flux/cheatsheets/oci-artifacts/
https://fluxcd.io/flux/cheatsheets/troubleshooting/
https://fluxcd.io/flux/cmd/flux_create_image/
https://fluxcd.io/flux/faq/
https://fluxcd.io/flux/flux-e2e/
https://fluxcd.io/flux/get-started/
https://fluxcd.io/flux/gitops-toolkit/
https://fluxcd.io/flux/guides/
https://fluxcd.io/flux/monitoring/
https://fluxcd.io/flux/use-cases/
