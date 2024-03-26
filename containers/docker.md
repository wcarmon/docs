# Overview
1. TODO


# Concepts

## Image
1. A "packaged" application with all necessary libraries & files
1. contains file system, binary to execute
1. Architecture specific (eg. x86, ARM) (unlike VMs)
    1. eg. You cannot containerize an app build for x86 and run on an ARM host


### Layers
1. TODO


## Registry
1. Stores & Hosts (docker) images


## Container
1. A running process
1. Isolated from host & other running processes
1. Resource-constrained (CPU, RAM, FileSystem, etc)


# Alternatives
1. [Containerd](https://containerd.io/)
1. [Podman](https://podman.io/)
1. [rkt](https://www.redhat.com/en/topics/containers/what-is-rkt)


# Other Resources
1. https://dev.to/theyasirr/comparison-of-container-runtimes-or-managment-technologies-docker-containerd-podman-rkt-1b8b
