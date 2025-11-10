#!/usr/bin/env bash

# TODO: fix from here down

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



# Use:
#   opencode-ollama.sh                -> launch TUI in $PWD
#   opencode-ollama.sh "your prompt"  -> non-interactive 'run' in $PWD
#
# Requires opencode installed, e.g.:
#   curl -fsSL https://opencode.ai/install | bash
# Docs: https://opencode.ai/docs/  (install, CLI, providers)
# (stored creds live at ~/.local/share/opencode/auth.json)

#WORKDIR="${WORKDIR:-$PWD}"
#[ -d "$WORKDIR" ] || { echo "Not a directory: $WORKDIR" >&2; exit 2; }
#
## Ensure OpenCode is installed
#if ! command -v opencode >/dev/null 2>&1; then
#  echo "OpenCode not found. Install with:  curl -fsSL https://opencode.ai/install | bash" >&2
#  exit 127
#fi
#
## Ensure project config advertises local Ollama as OpenAI-compatible provider
#CFG="$WORKDIR/opencode.json"
#if [ ! -f "$CFG" ]; then
#  cat > "$CFG" <<'JSON'
#{
#  "$schema": "https://opencode.ai/config.json",
#  "provider": {
#    "ollama": {
#      "npm": "@ai-sdk/openai-compatible",
#      "name": "Ollama (local)",
#      "options": { "baseURL": "http://127.0.0.1:11434/v1" },
#      "models": {
#        "qwen2.5-coder-16k": { "name": "Qwen2.5 Coder 16k (local)" }
#      }
#    }
#  }
#}
#JSON
#fi
#
## Default model mapping for this project (provider/model form)
#MODEL_ID="${MODEL_ID:-ollama/qwen2.5-coder-16k}"
#
#cd "$WORKDIR"
#
#if [ "$#" -eq 0 ]; then
#  # TUI (interactive)
#  exec opencode
#else
#  # Non-interactive CLI
#  exec opencode run -m "$MODEL_ID" "$@"
#fi
