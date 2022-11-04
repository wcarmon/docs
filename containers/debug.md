# Overview
1. TODO


# Debug an Alpine based container
```bash
readonly IMAGE=golang:1.18-alpine

docker run --rm -it $IMAGE /bin/ash;
```

# Debug a Debian based container
```bash
readonly IMAGE=golang:1.18-bullseye

docker run --rm -it $IMAGE /bin/bash;
```


# Debugging specific images
```sh
docker run -it --rm nginx:1.17 bash;
docker run -it --rm postgres:12.1-alpine bash;
```


# Inspect a container
```bash
docker inspect wc-nginx-container;
```


# Other Resources
1. TODO