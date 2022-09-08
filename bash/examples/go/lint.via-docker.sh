#!/bin/bash

# ---------------------------------------------
# -- Runs static analysis via docker container
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# See https://hub.docker.com/r/golangci/golangci-lint/tags
readonly GOLANGCI_IMAGE=golangci/golangci-lint:v1.48-alpine
#readonly GOLANGCI_IMAGE=golangci/golangci-lint:v1.46.2

# See https://hub.docker.com/r/returntocorp/semgrep
readonly SEMGREP_IMAGE=returntocorp/semgrep

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Dir contains go.mod file
readonly PROJ_ROOT="$PARENT_DIR"

#readonly CERT_FILE="${PROJ_ROOT}/foo.crt"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Lint (static analysis)
# ---------------------------------------------
echo
echo "|-- Analyzing code in ${PROJ_ROOT}/src"

# NOTE: mount volume for cert if required
#  eg.  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt:ro \

<<'SEMGREP_EXAMPLE'
echo
echo "|-- Running semgrep ..."
$DOCKER run \
  --rm \
  -v "${PROJ_ROOT}/src:/src":ro \
  $SEMGREP_IMAGE \
  semgrep scan \
  --config "p/ci" \
  --config "p/docker" \
  --config "p/golang" \
  --config "p/jwt" \
  --config "p/r2c-ci" \
  --config "p/trailofbits" \
  --disable-version-check \
  --jobs 4 \
  --metrics=off \
  --timeout 30 \
  --use-git-ignore
SEMGREP_EXAMPLE

echo
echo "|-- Running golangci-lint ..."
# NOTE: mount volume for cert if required
#  eg.  -v "${CERT_FILE}":/usr/local/share/ca-certificates/extra.crt:ro \
$DOCKER run \
  --rm \
  -v "${PROJ_ROOT}/src":/app:ro \
  --workdir /app \
  $GOLANGCI_IMAGE \
  /bin/ash -c "
    update-ca-certificates

    golangci-lint run ./... \
    --color auto \
    --concurrency 4 \
    --max-same-issues 5 \
    --print-linter-name \
    --sort-results \
    --tests true \
    --timeout 1m30s
  "
