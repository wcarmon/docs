# Overview
1. TODO


# List images
```sh
docker images --all;
```


# Delete images
```sh
IMAGE=foo
docker image rm $IMAGE;
docker image rm --force $IMAGE;
```


# Remove all stopped containers
```bash
docker rm $(docker ps -a -q)
```

# Debugging containers
1. See [debug.md](./debug.md)


# Other Resources
1. https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
