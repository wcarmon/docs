#!/bin/bash

# ---------------------------------------------
# -- Prints status of running models
# --
# -- Assumptions:
# -- 1. llama.cpp installed
# -- 2. models already installed via llama.cpp
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
readonly PORTS=(7701 7702 7703 7801 7802 7803 7901)


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------


# ---------------------------------------------
# -- Run
# ---------------------------------------------

for port in "${PORTS[@]}"; do
  echo "|-- Checking llama-server on port $port..."

  if wget -q \
      -O /dev/null \
      --timeout=2 \
      --tries=1 \
      --header='Content-Type: application/json' \
      --post-data='{"model":"test","messages":[{"role":"user","content":"ping"}]}' \
      "http://127.0.0.1:${port}/v1/chat/completions" \
      >/dev/null; then
    echo "    ✅ READY (port $port)"
  else
    echo "    ❌ NOT READY (port $port)"
  fi
done
