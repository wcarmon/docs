# Overview


# Run via container
```bash
mkdir -p $HOME/.sourcegraph;

# -- cleanup from previous runs
docker stop sourcegraph || true
docker rm --force sourcegraph || true
### sudo rm -vrf $HOME/.sourcegraph/*

# -- Run
docker run -d \
--name sourcegraph \
-e DISABLE_OBSERVABILITY=true \
--publish 127.0.0.1:3370:3370 \
--publish 7080:7080 \
--volume $HOME/.sourcegraph/config:/etc/sourcegraph \
--volume $HOME/.sourcegraph/data:/var/opt/sourcegraph \
sourcegraph/server:5.0.0;

# -- Verify
docker ps | grep sourcegraph;
docker logs sourcegraph;

# navigate to http://localhost:7080
```


# MacOS specific
1. TODO: https://docs.sourcegraph.com/admin/deploy/docker-single-container#file-system-performance-on-docker-for-mac
```
# TODO: clone the repos locally first

docker run -d \
--name sourcegraph \
--platform linux/amd64 \
--publish 127.0.0.1:3370:3370 \
--publish 7080:7080 \
--volume $HOME/.sourcegraph/config:/etc/sourcegraph \
--volume $HOME/.sourcegraph/data:/var/opt/sourcegraph:delegated \
-e DISABLE_OBSERVABILITY=true \
sourcegraph/server:5.0.0;
```


# listing all repos in your organization
```bash
brew install gh;

ORG_NAME=foo
gh list repos $ORG_NAME --limit 250 
```

# Other resources
