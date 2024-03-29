# Overview
1. Info on [Helm](https://helm.sh/)


# Goals
1. Group related kubernetes `*.yaml` resource files
1. Sharing/Reuse
1. Parameterization of shared/reused resource files
1. Less boilerplate, less copy/paste
1. Apply k8s resources in a "smart" order (eg. a `ConfigMap` before a `Deployment` that uses it)
1. Validate the k8s cluster before


# Chart directory layout/contents
1. [`Chart.yaml`](https://helm.sh/docs/topics/charts/#the-chartyaml-file)
    1. Chart definition
1. `templates/`
    1. based on [Golang text templates](../../golang/templates.md)
1. (optional) `values.yaml`: 
    1. Has default values/config/parameters for the chart
    1. See https://helm.sh/docs/chart_template_guide/values_files/
1. (optional) `values.schema.json`
1. (optional) [`.helmignore`](https://helm.sh/docs/chart_template_guide/helm_ignore_file/)
    1. same concept as `.gitignore`, `.dockerignore` and `.npmignore`


# Setup
1. Download the [(go based) binary](https://github.com/helm/helm/releases), put on `PATH`


# Packaging
1. A package is just a `.tgz` (tar-gzip) of the directory layout + [`index.yaml`](https://helm.sh/docs/topics/chart_repository/#the-index-file) 
    1. [`helm repo index`](https://helm.sh/docs/helm/helm_repo_index/) can generate the `index.yaml` file
    1. `index.yaml` contains the contents of `Chart.yaml`


# Public charts
1. See [ArtifactHub](https://artifacthub.io/)
1. See https://helm.sh/docs/helm/helm_search/


# Authentication
1. See [`kubeconfig`](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/) file
    1. `clusters`: host, ip, certificate authority, etc
    1. `users`: username, password, token, etc
    1. [`contexts`](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/#context): binding/join of cluster, user & active [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
    1. See https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_set-cluster/
    1. See https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_view/


# Authorization
1. `cluster-admin`: like `root`, can do any action on any resource
1. `edit`: read/write on most resources in the namespace
1. `view`: readonly no modification on existing resources 


# Input
1. a helm chart
1. Your app's [values file (`foo-values.yaml`)](https://helm.sh/docs/chart_template_guide/values_files/)


# Output
1. one or more kubernetes resource `*.yaml` files


# Reusable snippets
1. https://helm.sh/docs/chart_template_guide/named_templates/#declaring-and-using-templates-with-define-and-template
1. By convention, go into `_helpers.tpl`


# [Dependencies](https://helm.sh/docs/helm/helm_dependency/)
1. dependencies listed in `Chart.yaml`
1. dependencies are conditional via [Conditions (higher priority) & tags (lower priority)](https://helm.sh/docs/chart_best_practices/dependencies/#conditions-and-tags)



# Usage
1. See [usage doc](./helm.usage.md)


# Anti-features
1. ~~Chart Inheritance~~
    1. Use [Kustomize](./kustomize.md) instead
    1. Inheritance is also an [anti-pattern in Java, c++, c#](https://en.wikipedia.org/wiki/Composition_over_inheritance)
1. ~~Chart template logic~~
    1. Logic in templates is an old antipattern
        1. See guidance from Angular, React, Velocity, Freemarker, ... 
    1. Use [Kustomize](./kustomize.md) instead
1. ~~Release Lifecycle management~~
    1. Let `flux` manage this
1. [~~Lifecycle Hooks~~](https://helm.sh/docs/topics/charts_hooks/)
1. [~~--set~~] cli flag
    1. Use `--values` instead
1. ~~Plugins~~    


# TODO/Unorganized


# Other Resources
1. TODO
