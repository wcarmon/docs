#!/usr/bin/env bash

# ---------------------------------------------
# -- Runs an aider container with workspace as current directory
# --
# -- Copy into $HOME/bin/ (or anywhere on your $PATH)
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. git configured ($HOME/.gitconfig already setup)
# -- 3. ollama container running
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
#readonly AIDER_MODEL="codegemma:7b"
#readonly AIDER_MODEL="codellama:34b"
#readonly AIDER_MODEL="codellama:70b"
#readonly AIDER_MODEL="codestral:22b"
#readonly AIDER_MODEL="deepseek-coder-v2:16b"
#readonly AIDER_MODEL="deepseek-coder-v2:236b"
#readonly AIDER_MODEL="deepseek-coder:33b"
#readonly AIDER_MODEL="deepseek-coder:6.7b"
readonly AIDER_MODEL="qwen2.5-coder:14b"
#readonly AIDER_MODEL="qwen2.5-coder:32b"
#readonly AIDER_MODEL="qwen2.5-coder:7b"
#readonly AIDER_MODEL="qwen3-coder:30b"
#readonly AIDER_MODEL="starcoder2:15b"
#readonly AIDER_MODEL="starcoder2:7b"

readonly AIDER_CPUS="4"
readonly AIDER_HOME_HOST="$HOME/.aider"
readonly AIDER_MEM="3g"
readonly IMAGE="paulgauthier/aider:latest"
readonly OLLAMA_API_BASE="http://127.0.0.1:11434"
readonly OPENAI_API_BASE="http://127.0.0.1:11434/v1"

# dummy value; Ollama ignores it
readonly OPENAI_API_KEY="ollama"

# --subtree-only: ignore the repo outside of the directory you start in
readonly AIDER_ARGS="--no-gitignore --subtree-only"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly WORKDIR=$(pwd)

readonly CONTAINER_NAME="wc-aider-$(basename "$WORKDIR")-$(date +%H%M%S)"

# TODO: when this fails it should print a helpful message
readonly GIT_DIR_HOST="$(git rev-parse --absolute-git-dir)"


find_aiderignore_up() { d="$PWD"; while [ "$d" != "/" ]; do f="$d/.aiderignore"; [ -f "$f" ] && echo "$f" && return 0; d=$(dirname "$d"); done; return 1; }; find_aiderignore_up
readonly AIDER_IGNORE_FILE="$(find_aiderignore_up)"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
[ -d "$WORKDIR" ] || { echo "|-- Not a directory: $WORKDIR" >&2; exit 2; }


# ---------------------------------------------
# -- Cleanup
# ---------------------------------------------
#docker stop $CONTAINER_NAME || true
#docker rm $CONTAINER_NAME || true


# ---------------------------------------------
# -- Run
# ---------------------------------------------
echo
echo "|-- Aider model:  $AIDER_MODEL"
echo "|-- Working dir:  $WORKDIR"
echo "|-- Git dir:      $GIT_DIR_HOST"
echo "|-- .aiderignore: $AIDER_IGNORE_FILE"

# -- Persist tiny per-user prefs/history for aider (optional)
mkdir -p "$AIDER_HOME_HOST"

docker run -it --rm \
  --name "$CONTAINER_NAME" \
  --user "$(id -u)":"$(id -g)" \
  --network host \
  --cap-drop ALL \
  --cpus "$AIDER_CPUS" \
  --memory "$AIDER_MEM" \
  --pids-limit 512 \
  --security-opt no-new-privileges:true \
  --tmpfs /tmp:exec,nosuid,nodev,mode=1777 \
  -e HOME=/home/user \
  -e OLLAMA_API_BASE="$OLLAMA_API_BASE" \
  -e OPENAI_API_BASE="$OPENAI_API_BASE" \
  -e OPENAI_API_KEY="$OPENAI_API_KEY" \
  -v "$AIDER_HOME_HOST":/home/user \
  -v "$HOME/.gitconfig":/etc/gitconfig:ro \
  -v "$HOME/.gitconfig":/home/user/.gitconfig:ro \
  -v "$WORKDIR":/workspace \
  -v "$WORKDIR/.git":/workspace/.git \
  -w /workspace \
  $IMAGE \
  --model "$AIDER_MODEL" \
  $AIDER_ARGS


# ---------------------------------------------
# -- Report
# ---------------------------------------------
readonly OLLAMA_CONTAINER_NAME="wc-ollama-0"

echo
echo "|-- Aider container: $CONTAINER_NAME"
echo "|-- Logs:  docker logs $CONTAINER_NAME"

echo
echo "|-- models:  docker exec -it $OLLAMA_CONTAINER_NAME ollama list"
