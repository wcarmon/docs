#!/bin/bash

# ---------------------------------------------
# -- Runs Jaeger locally
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
readonly JAEGER_CONTAINER_NAME="jaeger"

# -- See https://hub.docker.com/r/jaegertracing/all-in-one/tags
#readonly JAEGER_IMAGE="jaegertracing/all-in-one:1"
#readonly JAEGER_IMAGE="jaegertracing/all-in-one:latest"
readonly JAEGER_IMAGE="jaegertracing/all-in-one:1.38"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
#GOTCHA: -d is cross platform, --directory is not
readonly TEMP_DIR=$(mktemp -d)


# ---------------------------------------------
# -- Run Jaeger
# ---------------------------------------------
$DOCKER stop $JAEGER_CONTAINER_NAME || true &>/dev/null
$DOCKER rm --force $JAEGER_CONTAINER_NAME || true &>/dev/null

#TODO: change user to non-root

#$DOCKER run --rm -it \   <-- debugging

$DOCKER run -d \
  --name $JAEGER_CONTAINER_NAME \
  -e BADGER_DIRECTORY_KEY=/badger/key \
  -e BADGER_DIRECTORY_VALUE=/badger/data \
  -e BADGER_EPHEMERAL=false \
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
  -v $TEMP_DIR:/badger:rw \
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
echo "|-- Badger storage: $TEMP_DIR"
