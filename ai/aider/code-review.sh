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

export LM_STUDIO_API_KEY=dummy-api-key
export LM_STUDIO_API_BASE=http://localhost:1234/v1


# -- models:
# lms ls
readonly MODEL="lm_studio/TODO"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
# TODO: require one param for the file


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
# TODO: derive git root based on nearest .git directory
# TODO: print derived repo root

# TODO: derive the output dir for review md files (similar to the input file structure)

# TODO:

# ---------------------------------------------
# -- Run
# ---------------------------------------------

aider --model="$MODEL" \
--analytics-disable \
--read TODO \
--message TODO \


# ---------------------------------------------
# -- Report
# ---------------------------------------------
