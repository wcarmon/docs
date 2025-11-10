#!/usr/bin/env bash

# ---------------------------------------------
# -- Starts the ollama container
# --
# -- Copy into $HOME/bin/ (or anywhere on your $PATH)
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. sudo chown -Rv "$(id -u)":"$(id -g)" "$OLLAMA_DATA_DIR"
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
readonly OLLAMA_DATA_DIR="$HOME/.ollama-data"

# maximum number of parallel inference requests
readonly OLLAMA_NUM_PARALLEL=1


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
mkdir -p "$OLLAMA_DATA_DIR"


docker run -d --name "$CONTAINER_NAME" \
  --user "$(id -u):$(id -g)" \
  -e HOME=/home/ollama \
  -e OLLAMA_NUM_GPU=0 \
  -e OLLAMA_NUM_PARALLEL="$OLLAMA_NUM_PARALLEL" \
  -p 127.0.0.1:11434:11434 \
  -v "$OLLAMA_DATA_DIR":/home/ollama/.ollama \
  --cap-drop ALL \
  --cpu-shares "${OLLAMA_CPU_SHARES:-2048}" \
  --cpus="20" \
  --cpuset-cpus="0-19" \
  --memory="24g" \
  --restart unless-stopped \
  --security-opt no-new-privileges:true \
  "$IMAGE"


# TODO: get some models


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Ollama API: http://127.0.0.1:11434"
echo "|-- Ollama container: $CONTAINER_NAME"
echo "|-- Ollama data: $OLLAMA_DATA_DIR"
echo "|-- Logs:  docker logs $CONTAINER_NAME"
echo "|-- Models:  docker exec -it $CONTAINER_NAME ollama list"
