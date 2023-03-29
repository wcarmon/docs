# Overview
1. How to get logs from containers


# Get logs for container by name
```bash
CONTAINER_NAME="foobar.dev"
CONTAINER_ID=$(docker ps --filter "name=$CONTAINER_NAME" --format "{{.ID}}")
docker logs $CONTAINER_ID;
```


# Other resources
1. https://docs.docker.com/engine/reference/commandline/logs/
