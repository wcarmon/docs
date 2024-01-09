# Overview
1. Usage cheatsheet for [Helm](https://helm.sh/)


# Print required values for helm chart
```bash
helm show values .
```


# Expand chart locally
```bash  
cd $CHART_DIR

helm dependency build .
helm template my-release1 .

# -- or 
helm template my-release1 . > helm.output.yaml
```


# "Modify" a chart
1. Useful when 3rd party chart is not flexible enough
1. Use [Kustomize](TODO)
1. in `kustomization.yaml`:
```yaml
...
resources:
    - path/to/chart_dir
    - path/to/overlays/dir 
```
1. [`helm install $RELEASE_NAME $CHART_DIR --post-renderer kustomize`](https://helm.sh/docs/topics/advanced/#usage) 


# Applying
```bash
helm install $RELEASE_NAME $FQ_CHART_NAME \
--values=values.yaml \
--namespace $NAMESPACE \
--version 1.2.3
```


# Debugging
```bash
cd $CHART_DIR

helm show chart .
helm show chart path/to/some/chart.tgz

helm show values .

helm dependency list .

helm list --namespace $NAMESPACE
```
