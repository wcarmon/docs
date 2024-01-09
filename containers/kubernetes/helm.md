# Overview
1. TODO


# Chart directory layout
1. `Chart.yaml`
1. `templates/`
1. (optional) `values.yaml`: default values (placefillers for template)
1. (optional) `values.schema.json`


# Print required values for helm chart
```bash
helm show values .
```


# Expand chart locally
```bash

# -- The dir containing  
cd CHART_DIR
helm template myRelease .

# -- or 
helm template myRelease . > helm.output.yaml
```


# "Modify" a chart
1. use [Kustomize](TODO)
1. in `kustomization.yaml`:
```yaml
...
resources:
    - path/to/chart_dir
    - path/to/overlays/dir 
```



# TODO/Unorganized


# Other resources
1. TODO
