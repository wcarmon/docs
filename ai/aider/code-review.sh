#!/usr/bin/env bash

# TODO: convert this to rust

# ---------------------------------------------
# -- Runs an aider to review each file
# --
# -- Usage:
# --    code-review.sh path/to/file.rs
# --
# -- Assumptions:
# -- 1. aider installed
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


# ---------------------------------------------
# -- Helpers
# ---------------------------------------------
sanitize_model_name() {
  # Turn "lm_studio/qwen2.5-coder:14b" into "lm_studio_qwen2.5-coder_14b"
  printf '%s' "$1" | sed 's#[/: ]#_#g'
}


make_prompt_file() {
  local src="$1"
  local tmp="$2"

  cat >"$tmp" <<EOF
Review exactly one source file: $src

Rules:
1. Do not edit any files.
2. Base your comments only on the provided file unless you explicitly say a point is uncertain due to missing context.
3. Be concrete and technical.
4. Prefer false negatives over hallucinations.
5. Mention exact symbols, branches, or code patterns when possible.
6. Do not suggest broad rewrites.
7. Output valid markdown only.

Output sections in this exact order:
# Summary
A 2-4 sentence overview.

# Definite bugs
Bullet list. Use "None." if empty.

# Likely bugs or edge cases
Bullet list. Use "None." if empty.

# Concurrency or state risks
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
}


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly MODEL_TAIL="${MODEL##*/}"
readonly MODEL_SIMPLE="$(printf '%s' "$MODEL_TAIL" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9._-]+/-/g')"

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


# -- output file
readonly SIMPLE_CODE_FILE_NAME="$(basename -- "$RELATIVE_CODE_PATH")"
readonly CODE_FILE_NAME_WITHOUT_EXTENSION="${SIMPLE_CODE_FILE_NAME%%.*}"

readonly OUTPUT_FILE_NAME="$CODE_FILE_NAME_WITHOUT_EXTENSION.$MODEL_SIMPLE.review.md"

readonly ABS_OUTPUT_FILE="$ABS_OUTPUT_DIR/$OUTPUT_FILE_NAME"
readonly RELATIVE_OUTPUT_FILE="$RELATIVE_OUTPUT_DIR/$OUTPUT_FILE_NAME"


# ---------------------------------------------
# -- Preflight
# ---------------------------------------------
echo
echo "|--             GIT_DIR: [$GIT_DIR]"
echo "|--       ABS_CODE_FILE: [$ABS_CODE_FILE]"
#echo "|--  RELATIVE_CODE_PATH: [$RELATIVE_CODE_PATH]"
#echo "|--     ABS_REVIEWS_DIR: [$ABS_REVIEWS_DIR]"
#echo "|-- RELATIVE_OUTPUT_DIR: [$RELATIVE_OUTPUT_DIR]"
echo "|--      ABS_OUTPUT_DIR: [$ABS_OUTPUT_DIR]"


# ---------------------------------------------
# -- Run
# ---------------------------------------------

cd "$GIT_DIR" >/dev/null 2>&1

mkdir -p "$ABS_OUTPUT_DIR"

echo
echo "|-- Working dir: [$(pwd)]"
echo "|-- Reviewing [$ABS_CODE_FILE] ..."

#
#aider --model="$MODEL" \
#--analytics-disable \
#--read TODO \
#--message TODO \


# ---------------------------------------------
# -- Report
# ---------------------------------------------
