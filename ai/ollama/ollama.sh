#!/usr/bin/env bash

# ---------------------------------------------
# -- Starts the ollama container
# --
# -- Copy into $HOME/bin/ (or anywhere on your $PATH)
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. sudo chown -Rv "$(id -u)":"$(id -g)" "$OLLAMA_DATA_DIR"
# -- 3. jq installed
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


# TODO: # create a 16k-context variant for large diffs:
# See https://aider.chat/docs/llms/ollama.html#setting-the-context-window-size


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Ollama API: http://127.0.0.1:11434"
echo "|-- Ollama container: $CONTAINER_NAME"
echo "|-- Ollama data: $OLLAMA_DATA_DIR"
echo "|-- Logs:  docker logs $CONTAINER_NAME"

echo
echo "|-- List Models:  docker exec -it $CONTAINER_NAME ollama list"
echo "|-- List Models:  curl -s http://127.0.0.1:11434/api/tags | jq"
echo "|-- List Aider compatible Models:  curl -s http://127.0.0.1:11434/v1/models | jq"
echo
echo "|-- Get a model:    docker exec -it $CONTAINER_NAME ollama pull qwen2.5-coder:7b"
echo "|-- Get a model:    docker exec -it $CONTAINER_NAME ollama pull qwen2.5-coder:14b"
