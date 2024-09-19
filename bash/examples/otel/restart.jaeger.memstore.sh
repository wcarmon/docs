#!/bin/bash

# ---------------------------------------------
# -- Runs Jaeger locally (stateless)
# --
# -- For memory & CPU stats:  docker stats <container-id>
# --
# -- GOTCHAS:
# -- 1. Memory store is hard to manage at scale
# -- 2. you can limit total spans, but they can have wildly different sizes
# -- 3. there are no ttl features
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
# -- See https://hub.docker.com/r/jaegertracing/all-in-one/tags
readonly JAEGER_IMAGE="jaegertracing/all-in-one:1.60"

#GOTCHA: -d is cross platform, --directory is not
readonly TEMP_DIR=$(mktemp -d)

readonly JAEGER_CONTAINER_NAME="jaeger_memstore"

# -- NOTE: when jaeger runs out of memory, the UI doesn't return any spans
# -- See https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory
#readonly MEMORY_LIMIT=500m
readonly MEMORY_LIMIT=2g

readonly MAX_TRACES=1000000


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
$DOCKER stop $JAEGER_CONTAINER_NAME || true &>/dev/null
$DOCKER rm --force $JAEGER_CONTAINER_NAME || true &>/dev/null

# -- Stop containers with port conflicts
$DOCKER stop jaeger_badger || true &>/dev/null
$DOCKER stop jaeger_custom_storage || true &>/dev/null
#$DOCKER stop jaeger_memstore || true &>/dev/null


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

# TODO: These seem to do nothing
#  -e LOG_LEVEL='debug' \
#  -e OTEL_EXPORTER_OTLP_PROTOCOL='http/json' \
#  -e OTEL_EXPORTER_OTLP_TRACES_PROTOCOL='http/json' \
#  -e OTEL_LOG_LEVEL='debug' \
#  -e COLLECTOR_OTLP_ENABLED=true \

# NOTE: executes as user 10001
$DOCKER run -d \
  --cpus=1.5 \
  --memory=$MEMORY_LIMIT \
  --name $JAEGER_CONTAINER_NAME \
  --restart always \
  -e COLLECTOR_OTLP_ENABLED=true \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -e MAX_TRACES=$MAX_TRACES \
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
