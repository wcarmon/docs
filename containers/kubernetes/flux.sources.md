# Overview
1. Info on flux Sources
1. See [flux doc](./flux.md)


# [Source](https://fluxcd.io/flux/concepts/#sources)
1. The "input" side of flux 
1. Contents
    1. Has desired state (or running cluster)
    1. Has version selectors
    1. Has credentials
1. Flux checks (origin of) Source periodically (eg. every 5 minutes)
1. All Sources are [CRDs (Custom Resources)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)


## [`HelmRepository` (`source.toolkit.fluxcd.io/v1beta2`) Custom Resource](https://github.com/fluxcd/source-controller/blob/main/docs/spec/v1beta2/helmrepositories.md)
1. [Custom Resource Definition](https://github.com/fluxcd/source-controller/blob/main/docs/spec/v1beta1/helmrepositories.md)
1. `index.yaml`
1. [Example](https://github.com/fluxcd/source-controller/blob/main/docs/spec/v1beta2/helmrepositories.md#examples)
1. `kubectl get helmrepository`
1. [`.spec.interval`](TODO) controls how often flux checks for diffs



# [Source Controller](https://fluxcd.io/flux/components/source/)
1. Uses one or more `Source`s
1. Validates source definitions
1. Authenticates to sources (SSH, user/password, API token)
1. Detects source changes based on update policies (semver, sha256 difference)
1. Fetchs resources on-demand and on-a-schedule (eg. HelmRepository's `index.yaml`, chart, etc)
1. Packages the fetched resources into tar.gz
1. Triggers notifications (status conditions, events, hooks)
1. https://github.com/fluxcd/source-controller/
