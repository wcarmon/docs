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
readonly AIDER_MODEL="${AIDER_MODEL:-ollama/qwen2.5-coder-16k}"  # switch to :7b for speed

readonly CONTAINER_NAME="wc-aider-0"
#readonly IMAGE="ollama/ollama:latest"

readonly OPENAI_API_BASE="http://127.0.0.1:11434/v1"

# dummy value; Ollama ignores it
readonly OPENAI_API_KEY="ollama"


# TODO: choose defaults for these envs: AIDER_MODEL, AIDER_CPUS, AIDER_MEM, AIDER_ARGS


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
WORKDIR="${1:-$PWD}"
[ -d "$WORKDIR" ] || { echo "|-- Not a directory: $WORKDIR" >&2; exit 2; }


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

# Persist tiny per-user prefs/history for aider (optional)
#AIDER_HOME_HOST="${AIDER_HOME_HOST:-$HOME/.aider-home}"
#mkdir -p "$AIDER_HOME_HOST"
#
## Gentle limits so you can run many sessions
#AIDER_CPUS="${AIDER_CPUS:-4}"
#AIDER_MEM="${AIDER_MEM:-3g}"
#
#docker run -it --rm \
#  --name "aider-$(basename "$WORKDIR")-$(date +%H%M%S)" \
#  --user "$(id -u)":"$(id -g)" \
#  --network host \
#  -w /workspace \
#  -v "$WORKDIR":/workspace \
#  -v "$WORKDIR/.git":/workspace/.git \
#  -v "$HOME/.gitconfig":/home/user/.gitconfig:ro \
#  -v "$AIDER_HOME_HOST":/home/user \
#  --tmpfs /tmp:exec,nosuid,nodev,mode=1777 \
#  --cap-drop ALL --security-opt no-new-privileges:true \
#  --pids-limit 512 \
#  --cpus "$AIDER_CPUS" --memory "$AIDER_MEM" \
#  -e OPENAI_API_BASE="$OPENAI_API_BASE" \
#  -e OPENAI_API_KEY="$OPENAI_API_KEY" \
#  paulgauthier/aider:latest \
#  --model "$AIDER_MODEL" \
#  ${AIDER_ARGS:-}



# ---------------------------------------------
# -- Report
# ---------------------------------------------
#echo
#echo "|-- Ollama API: http://127.0.0.1:11434"
#echo "|-- Ollama container: $CONTAINER_NAME"
#echo "|-- Ollama data: $OLLAMA_DATA_DIR"
#echo "|-- Logs:  docker logs $CONTAINER_NAME"
