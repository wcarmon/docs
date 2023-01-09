#!/bin/bash

# ---------------------------------------------
# -- Generates OpenAPI documentation & code
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
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly APP_CONFIG_FILE=$PARENT_DIR/docs/openapi/example.openapi.yaml
readonly OPENAPI_IMAGE="openapitools/openapi-generator-cli:v6.2.1"
readonly OUTPUT_DIR=$PARENT_DIR/build/openapi

# See https://openapi-generator.tech/docs/generators#documentation-generators
readonly GENERATOR_NAME="html2"
readonly GENERATOR_CONFIG_FILE=$PARENT_DIR/docs/openapi/openapi-generator.html2.yaml


# ---------------------------------------------
# -- Derived
# ---------------------------------------------


# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Generate
# ---------------------------------------------
cd $PARENT_DIR >/dev/null 2>&1

mkdir -p $OUTPUT_DIR
chmod -R 775 $OUTPUT_DIR
rm -rvf $OUTPUT_DIR/*


$DOCKER run \
  --name=openapi-generator \
  --rm \
  --user $(id -u):$(id -g) \
  -v "${APP_CONFIG_FILE}":/tmp/app.config.yaml:ro \
  -v "${GENERATOR_CONFIG_FILE}":/tmp/settings.config.yaml:ro \
  -v "${OUTPUT_DIR}":/tmp/output \
  $OPENAPI_IMAGE \
  generate \
  -c /tmp/settings.config.yaml \
  -g $GENERATOR_NAME \
  -i /tmp/app.config.yaml \
  -o /tmp/output;


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See html at $OUTPUT_DIR"
