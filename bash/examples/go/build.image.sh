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
readonly VERSION=$1

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

readonly APP_NAME=foo-service
readonly DOCKERFILE=./Dockerfile
readonly IMAGE_REPO_URI=ecr.us-east-1.amazonaws.com
readonly REPOSITORY_NAME=my-github-project

# Dir contains Dockerfile
readonly PROJ_ROOT="$PARENT_DIR"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly QUALIFIED_REPOSITORY_NAME=${IMAGE_REPO_URI}/${REPOSITORY_NAME}
readonly TAG_LATEST="latest-${APP_NAME}"
readonly TAG_NUMBERED="${VERSION}-${APP_NAME}"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

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
  --tag "${QUALIFIED_REPOSITORY_NAME}:${TAG_LATEST}" \
  --tag "${QUALIFIED_REPOSITORY_NAME}:${TAG_NUMBERED}" \
  .

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Successfully built and tagged image"
$DOCKER images -a | grep ${QUALIFIED_REPOSITORY_NAME}
