#!/usr/bin/env bash

# TODO: convert this to rust

# ---------------------------------------------
# -- Runs an aider to review each file
# --
# -- Usage:
# --    code-review.sh path/to/file.rs
# --
# -- Assumptions:
# -- 1. aider installed (v0.86 or newer)
# -- 1. lm-studio installed
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

# -- models: lms ls
#readonly MODEL="lm_studio/deepseek/deepseek-r1-0528-qwen3-8b"
#readonly MODEL="lm_studio/deepseek/deepseek-r1-distill-llama-8b"
#readonly MODEL="lm_studio/deepseek/deepseek-r1-distill-qwen-7b"
#readonly MODEL="lm_studio/google/gemma-3-1b"
#readonly MODEL="lm_studio/google/gemma-3-4b"
#readonly MODEL="lm_studio/google/gemma-4-e2b"
#readonly MODEL="lm_studio/google/gemma-4-e4b"
readonly MODEL="lm_studio/mistralai/ministral-3-3b"
#readonly MODEL="lm_studio/mistralai/ministral-3-3b-reasoning"
#readonly MODEL="lm_studio/mistralai/ministral-3-8b"
#readonly MODEL="lm_studio/mistralai/ministral-3-8b-reasoning"
#readonly MODEL="lm_studio/qwen/qwen2.5-coder-14b"
#readonly MODEL="lm_studio/qwen/qwen3-4b"
#readonly MODEL="lm_studio/qwen/qwen3-4b-2507"
#readonly MODEL="lm_studio/qwen/qwen3-4b-thinking-2507"
#readonly MODEL="lm_studio/qwen/qwen3-8b"
#readonly MODEL="lm_studio/qwen/qwen3-coder-next"
#readonly MODEL="lm_studio/qwen/qwen3.5-2b"
#readonly MODEL="lm_studio/qwen/qwen3.5-4b"
#readonly MODEL="lm_studio/qwen/qwen3.5-9b"

export LM_STUDIO_API_KEY=dummy-api-key
export LM_STUDIO_API_BASE=http://localhost:1234/v1


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
# require exactly 1 argument
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <src-file-path>" >&2
  exit 3
fi

readonly CODE_FILE_ARG="$1"

if [[ ! -f "$CODE_FILE_ARG" ]]; then
  echo
  echo "Error: file does not exist or is not a regular file: [$CODE_FILE_ARG]" >&2
  exit 4
fi

readonly ABS_CODE_FILE="$(realpath "$CODE_FILE_ARG")"


if ! curl -s "$LM_STUDIO_API_BASE/models" >/dev/null; then
  echo
  echo "Error: LM Studio not reachable at $LM_STUDIO_API_BASE" >&2
  echo "|-- Run: lms server start"
  exit 5
fi


# ---------------------------------------------
# -- Derived: Model
# ---------------------------------------------
readonly MODEL_TAIL="${MODEL##*/}"
readonly MODEL_SIMPLE="$(printf '%s' "$MODEL_TAIL" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9._-]+/-/g')"


# ---------------------------------------------
# -- Derived: Paths
# ---------------------------------------------
readonly GIT_DIR="$(git -C "$(dirname "$ABS_CODE_FILE")" rev-parse --show-toplevel)" || {
  echo "Error: not inside a git repository: $ABS_CODE_FILE" >&2
  exit 7
}

readonly RELATIVE_CODE_PATH="$(realpath --relative-to="$GIT_DIR" "$ABS_CODE_FILE")" || {
  echo "Error: failed to relativize path" >&2
  exit 8
}

readonly ABS_REVIEWS_DIR="$GIT_DIR/reviews"
readonly RELATIVE_OUTPUT_DIR="$(dirname -- "$RELATIVE_CODE_PATH")"
readonly ABS_OUTPUT_DIR="$(realpath -m -- "$ABS_REVIEWS_DIR/$RELATIVE_OUTPUT_DIR")"


# ---------------------------------------------
# -- Derived: output files
# ---------------------------------------------
readonly SIMPLE_CODE_FILE_NAME="$(basename -- "$RELATIVE_CODE_PATH")"
readonly CODE_FILE_NAME_WITHOUT_EXTENSION="${SIMPLE_CODE_FILE_NAME%%.*}"

readonly OUTPUT_FILE_NAME="$CODE_FILE_NAME_WITHOUT_EXTENSION.$MODEL_SIMPLE.review.md"

readonly ABS_OUTPUT_FILE="$ABS_OUTPUT_DIR/$OUTPUT_FILE_NAME"
readonly RELATIVE_OUTPUT_FILE="$RELATIVE_OUTPUT_DIR/$OUTPUT_FILE_NAME"

readonly ERR_OUTPUT="$ABS_OUTPUT_FILE.err"


# ---------------------------------------------
# -- Derived: prompt
# ---------------------------------------------
readonly TMP_PROMPT_FILE="$(mktemp)"
trap 'rm -f "$TMP_PROMPT_FILE"' EXIT

cat >"$TMP_PROMPT_FILE" <<EOF
Review exactly one source file.

Filename: $RELATIVE_CODE_PATH

Rules:
1. Do not edit any files.
2. Base your comments only on the provided file unless you explicitly say a point is uncertain due to missing context.
3. Be concrete and technical.
4. Prefer false negatives over hallucinations.
5. Mention exact symbols, branches, or code patterns when possible.
6. Do not suggest broad rewrites.
7. Output valid markdown only.
8. If unsure, explicitly say "insufficient context" instead of guessing.
9. Do not repeat the entire code or large excerpts.

Output sections in this exact order:
# Summary
A 1-3 sentence overview.

# Definite bugs
Bullet list. Use "None." if empty.

# Likely bugs or edge cases
Bullet list. Use "None." if empty.

# Concurrency or state risks
Bullet list. Use "None." if empty.

# Security risks
Bullet list. Use "None." if empty.

# API, naming, or maintainability issues
Bullet list. Use "None." if empty.

# Unnecessary complexity
Bullet list. Use "None." if empty.

# Missing tests
Bullet list of specific test cases. Use "None." if empty.

# Minimal patch ideas
Bullet list of the smallest worthwhile code changes. No full rewrite. Use "None." if empty.

# Confidence
Overall confidence: High / Medium / Low
Reason: one sentence.
EOF
readonly AIDER_PROMPT="$TMP_PROMPT_FILE"

# TODO: maturity idioms
# TODO: performance considerations
# TODO: error handling considerations


# ---------------------------------------------
# -- Preflight
# ---------------------------------------------
echo
echo "|--        GIT_DIR: [$GIT_DIR]"
echo "|--  ABS_CODE_FILE: [$ABS_CODE_FILE]"
echo "|-- ABS_OUTPUT_DIR: [$ABS_OUTPUT_DIR]"

mkdir -p "$ABS_OUTPUT_DIR"


# ---------------------------------------------
# -- Run
# ---------------------------------------------

cd "$GIT_DIR" >/dev/null 2>&1

echo
echo "|-- Working dir: [$(pwd)]"
echo "|-- Reviewing [$ABS_CODE_FILE] ..."

if [[ -f "$ABS_OUTPUT_FILE" ]]; then
  # They are version controlled so it's fine
  echo
  echo "WARN: overwriting existing review: $ABS_OUTPUT_FILE"
fi

# -- Run aider
# - --map-tokens 0:       no repo map, tighter scope
# - --message-file:       safer than trying to shell-escape a big prompt
# - --no-git / --no-auto-commits: no repo changes
# - --no-pretty / --no-stream: easier to capture clean markdown
# - --read:               give the source file as read-only
# - --yes:                skip confirmations in scripts
if ! aider \
  --add-gitignore-files \
  --analytics-disable \
  --map-tokens 0 \
  --message-file "$AIDER_PROMPT" \
  --model "$MODEL" \
  --no-analytics \
  --no-auto-commits \
  --no-git \
  --no-pretty \
  --no-stream \
  --no-verify-ssl \
  --read "$RELATIVE_CODE_PATH" \
  --yes \
  > "$ABS_OUTPUT_FILE" 2> "$ABS_OUTPUT_FILE.err"; then

  echo
  echo "|-- Aider failed for $ABS_CODE_FILE" >&2
  echo "|-- See error output at [$ERR_OUTPUT]"
  exit 13
fi

# TODO: set --thinking-tokens 1500
# TODO: set --reasoning-effort

# TODO: [--add-gitignore-files | --no-add-gitignore-files]
# TODO: [--aiderignore AIDERIGNORE] [--subtree-only]
# TODO: [--assistant-output-color ASSISTANT_OUTPUT_COLOR]
# TODO: [--auto-accept-architect | --no-auto-accept-architect]
# TODO: [--auto-commits | --no-auto-commits]
# TODO: [--cache-keepalive-pings CACHE_KEEPALIVE_PINGS]
# TODO: [--cache-prompts | --no-cache-prompts]
# TODO: [--chat-history-file CHAT_HISTORY_FILE]
# TODO: [--check-model-accepts-settings | --no-check-model-accepts-settings]
# TODO: [--code-theme CODE_THEME] [--show-diffs] [--git | --no-git]
# TODO: [--commit-language COMMIT_LANGUAGE] [--yes-always] [-v]
# TODO: [--detect-urls | --no-detect-urls] [--editor EDITOR]
# TODO: [--dirty-commits | --no-dirty-commits]
# TODO: [--edit-format EDIT_FORMAT] [--architect]
# TODO: [--editor-edit-format EDITOR_EDIT_FORMAT]
# TODO: [--fancy-input | --no-fancy-input] [--multiline | --no-multiline]
# TODO: [--file FILE] [--read FILE] [--vim]
# TODO: [--gitignore | --no-gitignore]
# TODO: [--input-history-file INPUT_HISTORY_FILE]
# TODO: [--just-check-update] [--check-update | --no-check-update]
# TODO: [--light-mode] [--pretty | --no-pretty] [--stream | --no-stream]
# TODO: [--lint] [--lint-cmd LINT_CMD] [--auto-lint | --no-auto-lint]
# TODO: [--llm-history-file LLM_HISTORY_FILE] [--dark-mode]
# TODO: [--load LOAD_FILE] [--encoding ENCODING]
# TODO: [--map-multiplier-no-files MAP_MULTIPLIER_NO_FILES]
# TODO: [--map-refresh {auto,always,files,manual}]
# TODO: [--max-chat-history-tokens MAX_CHAT_HISTORY_TOKENS]
# TODO: [--message COMMAND] [--message-file MESSAGE_FILE]
# TODO: [--restore-chat-history | --no-restore-chat-history]
# TODO: [--shell-completions SHELL] [--opus] [--sonnet] [--haiku] [--4]
# TODO: [--show-model-warnings | --no-show-model-warnings]
# TODO: [--show-prompts] [--voice-format VOICE_FORMAT]
# TODO: [--show-release-notes | --no-show-release-notes]
# TODO: [--skip-sanity-check-repo] [--watch-files | --no-watch-files]
# TODO: [--suggest-shell-commands | --no-suggest-shell-commands]
# TODO: [--tool-error-color TOOL_ERROR_COLOR]
# TODO: [--tool-output-color TOOL_OUTPUT_COLOR]
# TODO: [--tool-warning-color TOOL_WARNING_COLOR]
# TODO: [--user-input-color USER_INPUT_COLOR]
# TODO: [--weak-model WEAK_MODEL] [--editor-model EDITOR_MODEL]


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See review at [$ABS_OUTPUT_FILE]"
