#!/bin/bash

# ---------------------------------------------
# --
# -- Builds docker image for app
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# ---------------------------------------------

#set -x # uncomment to debug script
set -e
set -o pipefail
set -u


# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER_BINARY=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------
#TODO: document docker tag syntax
readonly TAG_NAME=$1


# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

readonly APP_NAME=foo-service
readonly DOCKERFILE=./Dockerfile
readonly IMAGE_REPO_URI=ecr.us-east-1.amazonaws.com
readonly REPOSITORY_NAME=my-github-project

# Dir contains Dockerfile
readonly PROJ_ROOT=$PARENT_DIR


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly QUALIFIED_REPOSITORY_NAME=myorg/${REPOSITORY_NAME}/${APP_NAME}


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
# TODO: more here


# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Building docker image ..."
$DOCKER_BINARY build \
  --file ${DOCKERFILE}\
  --tag ${QUALIFIED_REPOSITORY_NAME}:${TAG_NAME}\
  --tag ${QUALIFIED_REPOSITORY_NAME}:latest \
  .

echo
echo "|-- Tagging docker image for Remote image repo ..."
$DOCKER_BINARY tag ${QUALIFIED_REPOSITORY_NAME}:${TAG_NAME} ${IMAGE_REPO_URI}/${QUALIFIED_REPOSITORY_NAME}:${TAG_NAME}
$DOCKER_BINARY tag ${QUALIFIED_REPOSITORY_NAME}:latest ${IMAGE_REPO_URI}/${QUALIFIED_REPOSITORY_NAME}:latest


# ---------------------------------------------
# -- Verify
# ---------------------------------------------
echo
echo "|-- Successfully built and tagged image"
$DOCKER_BINARY images -a | grep ${QUALIFIED_REPOSITORY_NAME}
