#!/bin/bash

# ---------------------------------------------
# -- Runs the local models
# --
# -- Assumptions:
# -- 1. models already installed via llama.cpp
# -- 2. models added as providers in $HOME/.config/opencodeopencode.json
# -- 3. TODO: more here
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


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Run
# ---------------------------------------------
killall -v llama-server || true

mkdir "$HOME/llm"


# llama-server \
#   -hf Qwen/Qwen2.5-Coder-7B-Instruct-GGUF \
#   -m $HOME/llm/qwen2.5-coder-7b-instruct-q4_k_m.gguf \
#   --port 7701 \
#   --host 127.0.0.1 &

llama-server \
  -hf Qwen/Qwen2.5-Coder-14B-Instruct-GGUF \
  -m $HOME/llm/qwen2.5-coder-14b-instruct-q4_k_m.gguf \
  --port 7702 \
  --host 127.0.0.1 &

# llama-server \
#   -hf Qwen/Qwen2.5-Coder-32B-Instruct-GGUF \
#   -m $HOME/llm/qwen2.5-coder-32b-instruct-q4_k_m.gguf \
#   --port 7703 \
#   --host 127.0.0.1 &


# ------------------------------------------
llama-server \
  -hf bartowski/DeepSeek-Coder-V2-Lite-Instruct-GGUF \
  -m $HOME/llm/DeepSeek-Coder-V2-Lite-Instruct-Q4_K_M.gguf \
  --port 7801 \
  --host 127.0.0.1 &


# ------------------------------------------
# llama-server \
#   -hf bartowski/starcoder2-15b-instruct-v0.1-GGUF \
#   -m $HOME/llm/starcoder2-15b-instruct-v0.1-Q6_K.gguf \
#   --port 7901 \
#   --host 127.0.0.1 &


# ---------------------------------------------
# -- Report
# ---------------------------------------------

echo
echo "|-- Available local models:"
ls -lh $HOME/llm/*.gguf
find $HOME/.cache/llama.cpp -name "*.gguf"

echo
echo "|-- For Qwen models, navigate to:"
echo "|--   http://localhost:7701"
echo "|--   http://localhost:7702"
echo "|--   http://localhost:7703"

echo
echo "|-- For DeepSeek models, navigate to:"
echo "|--   http://localhost:7801"

echo
echo "|-- For StarCoder models, navigate to:"
echo "|--   http://localhost:7901"
