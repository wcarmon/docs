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
#readonly AIDER_MODEL="ollama/codegemma:7b"
#readonly AIDER_MODEL="ollama/codellama:34b"
#readonly AIDER_MODEL="ollama/codellama:70b"
#readonly AIDER_MODEL="ollama/codestral:22b"
#readonly AIDER_MODEL="ollama/deepseek-coder-v2:16b"
#readonly AIDER_MODEL="ollama/deepseek-coder-v2:236b"
#readonly AIDER_MODEL="ollama/deepseek-coder:33b"
readonly AIDER_MODEL="ollama/deepseek-coder:6.7b"
#readonly AIDER_MODEL="ollama/qwen2.5-coder:14b"
#readonly AIDER_MODEL="ollama/qwen2.5-coder:32b"
#readonly AIDER_MODEL="ollama/qwen2.5-coder:7b"
#readonly AIDER_MODEL="ollama/qwen3-coder:30b"
#readonly AIDER_MODEL="ollama/starcoder2:15b"
#readonly AIDER_MODEL="ollama/starcoder2:7b"

readonly AIDER_CPUS="4"
readonly AIDER_HOME_HOST="$HOME/.aider"
readonly AIDER_MEM="3g"
readonly IMAGE="paulgauthier/aider:latest"
readonly OLLAMA_API_BASE="http://127.0.0.1:11434"
readonly OLLAMA_CONTAINER_NAME="wc-ollama-0"
readonly OPENAI_API_BASE="http://127.0.0.1:11434/v1"


# dummy value; Ollama ignores it
readonly OPENAI_API_KEY="ollama"

# Gotcha: --subtree-only doesn't work well with the double bind of workspace
readonly AIDER_ARGS="--no-gitignore --edit-format whole"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly WORKDIR=$(pwd)

readonly CONTAINER_NAME="wc-aider-$(basename "$WORKDIR")-$(date +%H%M%S)"

if ! GIT_DIR_HOST="$(git rev-parse --absolute-git-dir 2>/dev/null)"; then
  echo
  echo "|-- Refusing to run aider in $(pwd)"
  echo "|-- Error: must be run inside a Git repository." >&2
  exit 3
fi

# -- .aiderignore file
find_aiderignore_up() { d="$PWD"; while [ "$d" != "/" ]; do f="$d/.aiderignore"; [ -f "$f" ] && echo "$f" && return 0; d=$(dirname "$d"); done; return 1; }; find_aiderignore_up
readonly AIDER_IGNORE_FILE="$(find_aiderignore_up)"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
[ -d "$WORKDIR" ] || { echo "|-- Not a directory: $WORKDIR" >&2; exit 4; }


echo "|-- Checking for Ollama @ $OLLAMA_API_BASE ..."
if ! curl -sS "$OLLAMA_API_BASE/api/version" >/dev/null; then
  echo "|-- ERROR: Cannot reach Ollama at $OLLAMA_API_BASE"
  echo "|-- Is your container running and bound to 127.0.0.1:11434?"
  exit 6
fi

HAVE_MODEL=$(
  curl -s "$OLLAMA_API_BASE/api/tags" \
  | grep -oE '"name":"[^"]+"' \
  | cut -d'"' -f4 \
  | grep -Fx -- "${AIDER_MODEL#ollama/}" || true
)

if [[ -z "$HAVE_MODEL" ]]; then
  echo "|-- ERROR: Model is not installed in Ollama: '${AIDER_MODEL#ollama/}'"
  echo "|-- Fix:   docker exec -it $OLLAMA_CONTAINER_NAME ollama pull ${AIDER_MODEL#ollama/}"
  echo "|-- Or pick one that exists"
  exit 7
fi


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
  --cap-drop ALL \
  --cpus "$AIDER_CPUS" \
  --memory "$AIDER_MEM" \
  --network host \
  --pids-limit 512 \
  --security-opt no-new-privileges:true \
  --tmpfs /tmp:exec,nosuid,nodev,mode=1777 \
  --user "$(id -u)":"$(id -g)" \
  -e GIT_DIR=/gitdir -e GIT_WORK_TREE=/workspace \
  -e HOME=/home/user \
  -e OLLAMA_API_BASE="$OLLAMA_API_BASE" \
  -e OPENAI_API_BASE="$OPENAI_API_BASE" \
  -e OPENAI_API_KEY="$OPENAI_API_KEY" \
  -v "$AIDER_HOME_HOST":/home/user \
  -v "$GIT_DIR_HOST":/gitdir \
  -v "$HOME/.gitconfig":/etc/gitconfig:ro \
  -v "$HOME/.gitconfig":/home/user/.gitconfig:ro \
  -v "$WORKDIR":"$WORKDIR" \
  -v "$WORKDIR":/workspace \
  -w /workspace \
  $IMAGE \
  --model "$AIDER_MODEL" \
  $AIDER_ARGS


#-v "$WORKDIR/.git":/workspace/.git \

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Aider container: $CONTAINER_NAME"
echo "|-- Logs:  docker logs $CONTAINER_NAME"

echo
echo "|-- models:  docker exec -it $OLLAMA_CONTAINER_NAME ollama list"
