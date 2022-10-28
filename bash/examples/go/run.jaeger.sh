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
readonly ES_CONTAINER_NAME=es-for-jaeger

# -- See https://hub.docker.com/_/elasticsearch/tags
readonly ES_IMAGE="elasticsearch:7.17.7"
#readonly ES_IMAGE="elasticsearch:8.4.3"  # not supported by jaeger yet

readonly JAEGER_CONTAINER_NAME="jaeger"

# -- See https://hub.docker.com/r/jaegertracing/all-in-one/tags
#readonly JAEGER_IMAGE="jaegertracing/all-in-one:1"
#readonly JAEGER_IMAGE="jaegertracing/all-in-one:latest"
readonly JAEGER_IMAGE="jaegertracing/all-in-one:1.38"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Run ElasticSearch <-- very heavy & slow to start
# ---------------------------------------------
$DOCKER stop $ES_CONTAINER_NAME || true &>/dev/null
$DOCKER rm --force $ES_CONTAINER_NAME || true &>/dev/null

#$DOCKER run -it --rm \   <-- debugging
$DOCKER run -d \
  --name $ES_CONTAINER_NAME \
  -e "discovery.type=single-node" \
  -e "ES_JAVA_OPTS=-Xmx300m" \
  -p 9200:9200 \
  -p 9300:9300 \
  $ES_IMAGE

echo
echo "|-- Waiting for ES to start"
sleep 15

#TODO: give it time to start (20 seconds)


# ---------------------------------------------
# -- Run Filebeat
# ---------------------------------------------
#TODO:
#output.elasticsearch.index: "customname-%{[agent.version]}"
#setup.template.name: "customname"
#setup.template.pattern: "customname-%{[agent.version]}"
#
#TODO: dedupe: https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-deduplication.html

# ---------------------------------------------
# -- Run Jaeger
# ---------------------------------------------
$DOCKER stop $JAEGER_CONTAINER_NAME || true &>/dev/null
$DOCKER rm --force $JAEGER_CONTAINER_NAME || true &>/dev/null

#$DOCKER run --rm -it \   <-- debugging

$DOCKER run -d \
  --name $JAEGER_CONTAINER_NAME \
  -e COLLECTOR_OTLP_ENABLED=true \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -e ES_SERVER_URLS=http://localhost:9200 \
  -e ES_USERNAME=elastic \
  -e SPAN_STORAGE_TYPE=elasticsearch \
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
echo "|-- Started Jaeger & ElasticSearch"
$DOCKER ps --filter="name=$JAEGER_CONTAINER_NAME"
$DOCKER ps --filter="name=$ES_CONTAINER_NAME"

echo
echo
echo "|-- Jaeger UI: http://localhost:16686"
echo "|-- ElasticSearch UI: http://localhost:9200"
