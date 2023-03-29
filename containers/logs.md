# Overview
1. How to get logs from containers


# Get logs for container by name
```bash
CONTAINER_NAME="foobar.dev"
CONTAINER_ID=$(docker ps --filter "name=$CONTAINER_NAME" --format "{{.ID}}")
docker logs $CONTAINER_ID;
```


# Login to another box and get logs
```bash
HOST=127.0.0.1
SERVER_USER=$(whoami)

ssh -T ${SERVER_USER}@${HOST} << EOF
  ls
  pwd
  docker ps > /tmp/foo.log
EOF
```


# Other resources
1. https://docs.docker.com/engine/reference/commandline/logs/
