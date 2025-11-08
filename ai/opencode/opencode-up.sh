#!/usr/bin/env bash

# ---------------------------------------------
# -- TODO
# --
# -- Copy into $HOME/bin/ (or anywhere on your $PATH)
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. TODO
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------
# -- Constants
# ---------------------------------------------


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------


# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly CONTAINER_NAME="wc-ollama-0"
readonly IMAGE="ollama/ollama:latest"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true


# ---------------------------------------------
# -- Run
# ---------------------------------------------
#mkdir -p "$OLLAMA_DATA_DIR"
#
#
#docker run -d --name "$CONTAINER_NAME" \
#  --user "$(id -u):$(id -g)" \
#  -e HOME=/home/ollama \
#  -e OLLAMA_NUM_GPU=0 \
#  -e OLLAMA_NUM_PARALLEL="$OLLAMA_NUM_PARALLEL" \
#  -p 127.0.0.1:11434:11434 \
#  -v "$OLLAMA_DATA_DIR":/home/ollama/.ollama \
#  --cap-drop ALL \
#  --cpu-shares "${OLLAMA_CPU_SHARES:-2048}" \
#  --cpus="20" \
#  --cpuset-cpus="0-19" \
#  --memory="24g" \
#  --restart unless-stopped \
#  --security-opt no-new-privileges:true \
#  "$IMAGE"
#
#echo
#echo "|-- Ollama API: http://127.0.0.1:11434"
#echo "|-- Ollama container: $CONTAINER_NAME"
#echo "|-- Ollama data: $OLLAMA_DATA_DIR"
#echo "|-- Logs:  docker logs $CONTAINER_NAME"
