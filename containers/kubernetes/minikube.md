# Overview
1. How to run [minikube](https://minikube.sigs.k8s.io/docs/start/) locally
1. See [kubernetes](./k8s.md) doc


# Install
1. https://minikube.sigs.k8s.io/docs/start/
1. A single binary
1. Works on Linux, windows, macos
1. NOTE: minikube will auto install the correct version of `kubectl`


# [Choose a driver](https://minikube.sigs.k8s.io/docs/drivers/)

## Linux
1. [docker](https://minikube.sigs.k8s.io/docs/drivers/docker/) (easier) or [kvm2](https://minikube.sigs.k8s.io/docs/drivers/kvm2/)

## windows
1. [Hyper-V](https://minikube.sigs.k8s.io/docs/drivers/hyperv/) or [VirtualBox](https://minikube.sigs.k8s.io/docs/drivers/virtualbox/) or [Docker](https://minikube.sigs.k8s.io/docs/drivers/docker/)


# Run
```sh
minikube start;
minikube start --memory 5000 --cpus=4;

minikube status;
minikube version;
minikube ip;
minikube logs;
```


# Enable addonds
```sh
minikube addons enable ingress;
minikube addons enable metrics-server
```


# Stop
```sh
minikube stop;

#minikube delete;
```


# Convenience
1. Add to `~/.bashrc`
```sh
# -- Shorter aliases
...
alias d="docker"
alias g="git"

alias k="minikube kubectl --"
alias kubectl="minikube kubectl --"
alias mk="minikube"

# -- Tab completion
source <(kubectl completion bash | sed s/kubectl/k/g)
source <(kubectl completion bash)
```


# Command cheatsheet
1. See also [./cheatsheet.k8s.md]
```sh
minikube ip;
minikube service --all;

# -- Run the dashboard (browser based) UI
minikube dashboard &;
```


# Other Resources
1. TODO
