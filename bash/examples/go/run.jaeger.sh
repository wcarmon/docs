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

# -- See https://hub.docker.com/r/jaegertracing/all-in-one/tags
#readonly JAEGER_IMAGE="jaegertracing/all-in-one:1"
#readonly JAEGER_IMAGE="jaegertracing/all-in-one:latest"
readonly JAEGER_IMAGE="jaegertracing/all-in-one:1.38"

readonly CONTAINER_NAME="jaeger"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Run Jaeger
# ---------------------------------------------
$DOCKER stop $CONTAINER_NAME || true  &> /dev/null
$DOCKER rm --force $CONTAINER_NAME || true  &> /dev/null

$DOCKER run -d \
  --name $CONTAINER_NAME \
  -e COLLECTOR_OTLP_ENABLED=true \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
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
$DOCKER ps --filter="name=$CONTAINER_NAME"

echo
echo
echo "|-- Jaeger UI: http://localhost:16686"