#!/bin/bash

# ---------------------------------------------
# -- Runs Jaeger locally (stateless, with custom storage server)
# --
# -- For memory & CPU stats:  docker stats <container-id>
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# -- Cannot use `localhost` nor `127.0.0.1`
# -- For [jaeger container] -> [storage server on docker host]:
#
# docker network inspect bridge -f '{{range .IPAM.Config}}{{.Gateway}}{{end}}'
readonly CUSTOM_STORAGE_HOST="172.17.0.1"

# -- Align with the custom storage server
readonly CUSTOM_STORAGE_PORT=7555

# -- See https://hub.docker.com/r/jaegertracing/all-in-one/tags
readonly JAEGER_IMAGE="jaegertracing/all-in-one:1.61"

#GOTCHA: -d is cross platform, --directory is not
readonly TEMP_DIR=$(mktemp -d)

readonly JAEGER_CONTAINER_NAME="jaeger_custom_storage"

# -- NOTE: when jaeger runs out of memory, the UI doesn't return any spans
# -- See https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory
#readonly MEMORY_LIMIT=500m
readonly MEMORY_LIMIT=2g


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
$DOCKER stop $JAEGER_CONTAINER_NAME || true &>/dev/null
$DOCKER rm --force $JAEGER_CONTAINER_NAME || true &>/dev/null

# -- Stop containers with port conflicts
$DOCKER stop jaeger_badger || true &>/dev/null
#$DOCKER stop jaeger_custom_storage || true &>/dev/null
$DOCKER stop jaeger_memstore || true &>/dev/null


# ---------------------------------------------
# -- Run
# ---------------------------------------------

# -- Ports: See https://www.jaegertracing.io/docs/1.59/deployment/
# - 14250 = collector: model.proto
# - 14269 = admin, health check
# - 14271 = admin, health check
# - 16685 = query service
# - 16686 = query service
# - 16686 = UI
# - 16687 = query service
# - 4317 = collector: OpenTelemetry OTLP over grpc
# - 4318 = collector: OpenTelemetry OTLP over http
# - 6831 = compact thrift     <-- Deprecated
# - 6832 = binary thrift      <-- Deprecated



# NOTE: executes as user 10001
$DOCKER run -d \
  --cpus=1.5 \
  --memory=$MEMORY_LIMIT \
  --name $JAEGER_CONTAINER_NAME \
  --restart always \
  -e COLLECTOR_OTLP_ENABLED=true \
  -e GRPC_STORAGE_SERVER="$CUSTOM_STORAGE_HOST:$CUSTOM_STORAGE_PORT" \
  -e SPAN_STORAGE_TYPE=grpc \
  -p 14250:14250 \
  -p 14268:14268 \
  -p 14269:14269 \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  -p 5778:5778 \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 9411:9411 \
  $JAEGER_IMAGE


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Started Jaeger"
$DOCKER ps --filter="name=$JAEGER_CONTAINER_NAME"

echo
echo
echo "|-- Jaeger UI: http://localhost:16686"
echo
echo "|-- Stats: docker stats $JAEGER_CONTAINER_NAME"

echo
echo "|-- print logs: docker logs $JAEGER_CONTAINER_NAME"
echo "|-- tail logs: docker logs -f $JAEGER_CONTAINER_NAME"

# -- Most apps should send traces thru grpc to port 4317
#sudo netstat -pant | grep -i 4317
