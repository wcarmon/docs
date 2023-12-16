#!/bin/bash

# ---------------------------------------------
# -- Runs Jaeger locally (stateless)
# --
# -- For memory & CPU stats:  docker stats <container-id>
# --
# --
# -- NOTES:
# -- 1. by default, jaeger container runs as user=10001
# -- 2. if you run out of memory, just restart, Span data is persisted
# -- 3. because of compression, badger is much more efficient than memstore
# --
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# --
# -- 2. user exists for container:
# --      sudo useradd --system -u 10001 jaeger_container
# --
# -- 3. container has permissions on the badger data root:
# --      chown -R 10001 $BADGER_DATA_ROOT
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
readonly JAEGER_IMAGE="jaegertracing/all-in-one:1.52"

# -- GOTCHA: -d is cross platform, --directory is not
#readonly BADGER_DATA_ROOT=$(mktemp -d)
readonly BADGER_DATA_ROOT=$HOME/tmp/badger

readonly JAEGER_CONTAINER_NAME="jaeger_badger"

# -- NOTE: when jaeger runs out of memory, the UI doesn't return any spans
# -- Just restart since span data is persistent
# -- See https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory
readonly MEMORY_LIMIT=800m
#readonly MEMORY_LIMIT=2g

# -- Format https://pkg.go.dev/time#ParseDuration
readonly SPAN_TTL=72h0m
#readonly SPAN_TTL=120h0m


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
$DOCKER stop $JAEGER_CONTAINER_NAME || true &>/dev/null
$DOCKER rm --force $JAEGER_CONTAINER_NAME || true &>/dev/null


# ---------------------------------------------
# -- Run
# ---------------------------------------------

# -- Ports: See https://www.jaegertracing.io/docs/1.52/deployment/
# - 14250 = collector: model.proto
# - 14269 = admin, health check
# - 14271 = admin, health check
# - 16685 = query service
# - 16686 = query service
# - 16686 = UI
# - 16687 = query service
# - 4317 = collector: OpenTelemetry OTLP over grpc
# - 4318 = collector: OpenTelemetry OTLP over http
# - 6831 = compact thrift
# - 6832 = binary thrift


# TODO: set TTL on badger
# TODO: set max memory on badger

mkdir -pv "$BADGER_DATA_ROOT/key"
mkdir -pv "$BADGER_DATA_ROOT/data"

$DOCKER run -d \
  --cpus=1.5 \
  --memory=$MEMORY_LIMIT \
  --name $JAEGER_CONTAINER_NAME \
  --restart always \
  -e BADGER_DIRECTORY_KEY=/badger/key \
  -e BADGER_DIRECTORY_VALUE=/badger/data \
  -e BADGER_EPHEMERAL=false \
  -e BADGER_SPAN_STORE_TTL=$SPAN_TTL \
  -e COLLECTOR_OTLP_ENABLED=true \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -e SPAN_STORAGE_TYPE=badger \
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
  -v "$BADGER_DATA_ROOT":/badger:rw \
  $JAEGER_IMAGE

# ---------------------------------------------
# -- Debug
# ---------------------------------------------
echo
echo "Debug: docker run -it $JAEGER_IMAGE"


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
echo "|-- Badger storage: $BADGER_DATA_ROOT"
echo
echo "|-- Stats: docker stats $JAEGER_CONTAINER_NAME"
