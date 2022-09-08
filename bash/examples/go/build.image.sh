#!/bin/bash

# ---------------------------------------------
# -- Builds docker image for app
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
# semver: https://semver.org/
# eg. "1.2.3" or "4.5"
readonly SEMVER=$1

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# Dir contains Dockerfile
readonly PROJ_ROOT="$PARENT_DIR"

# Unqualified image name
# Final segment before the version
readonly SHORT_IMAGE_NAME="foo"

# Useful as a version suffix when image repo contains multiple variants
# (eg. debian/alpine)
readonly TAG_SUFFIX=go

readonly DOCKERFILE=./Dockerfile

# AWS Elastic Container Registry:
#   - Format: TODO
#   - eg. "ecr.us-east-1.amazonaws.com"
#
# Google Cloud Artifact Registry:
#   - Format: HOST-NAME/PROJECT-ID
#   - eg. "us-east1-docker.pkg.dev/my-project-id"
#   - See https://console.cloud.google.com/artifacts
readonly IMAGE_REPO_URI=ecr.us-east-1.amazonaws.com

# AWS:  TODO
# Google cloud: gcloud artifacts repositories list
readonly REPOSITORY_NAME=my-github-project

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Everything before the version
readonly QUALIFIED_IMAGE_NAME="${IMAGE_REPO_URI}/${REPOSITORY_NAME}/${SHORT_IMAGE_NAME}"

readonly TAG_LATEST="latest-${TAG_SUFFIX}"
readonly TAG_NUMBERED="${SEMVER}-${TAG_SUFFIX}"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
# -- validate tag
if [ "$(echo $TAG_NUMBERED)" = "" ]; then
  echo
  echo "Error: tag must have a value"
  exit 10
fi

# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Latest commit: $(git log -1 --format='%H at %ci')"

echo
echo "|-- Building & tagging docker image ..."
$DOCKER build \
  --file ${DOCKERFILE} \
  --tag "${QUALIFIED_IMAGE_NAME}:${TAG_LATEST}" \
  --tag "${QUALIFIED_IMAGE_NAME}:${TAG_NUMBERED}" \
  .

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Successfully built and tagged image"
$DOCKER images -a | grep ${QUALIFIED_IMAGE_NAME}
