#!/bin/bash

# ---------------------------------------------
# -- Runs an OTEL Collector locally (stateless)
# -- See https://opentelemetry.io/docs/collector/configuration/
# -- See https://opentelemetry.io/docs/collector/
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
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# -- See https://hub.docker.com/r/otel/opentelemetry-collector/tags
#readonly COLLECTOR_IMAGE="otel/opentelemetry-collector:latest"
readonly COLLECTOR_IMAGE="otel/opentelemetry-collector:0.74.0"

readonly COLLECTOR_CONTAINER_NAME="otel-web-collector"

# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
$DOCKER stop $COLLECTOR_CONTAINER_NAME || true &>/dev/null
$DOCKER rm --force $COLLECTOR_CONTAINER_NAME || true &>/dev/null

# ---------------------------------------------
# -- Run
# ---------------------------------------------
# port 4318:    OTLP http receiver
# port 13133:   Health check
$DOCKER run -d \
--name $COLLECTOR_CONTAINER_NAME \
-v $SCRIPTS_DIR/otel.collector.yaml:/etc/otelcol-contrib/config.yaml:ro \
-p 4318:4318 \
-p 13133:13133 \
$COLLECTOR_IMAGE


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Started OTel Web Collector"
$DOCKER ps --filter="name=$COLLECTOR_CONTAINER_NAME"

echo
echo "|-- see logs with:"
echo "$DOCKER logs $COLLECTOR_CONTAINER_NAME"
