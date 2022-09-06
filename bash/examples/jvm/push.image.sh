#!/bin/bash

# ---------------------------------------------
# -- Push docker images to registry (eg. ECR)
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. Executed by CI tool (eg. Jenkins)
# -- 3. awscli (or equivalent) is installed
# -- 4. Previously ran `aws configure`
# -- 5. Previously created an image repo (eg. on ECR)
# --
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
# alphanumeric, dot, dash
# eg. "1.0.0"
# eg. "1.0.1-hotfix"
# eg. "1.2.3-debug"
readonly VERSION=$1

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT
readonly APP_NAME=go-rest-server
readonly IMAGE_REPO_URI=ecr.us-east-1.amazonaws.com

# See the name in ECR
readonly REPOSITORY_NAME="company/example"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# format: https://docs.docker.com/engine/reference/commandline/tag/#description
readonly TAG=${VERSION}-${APP_NAME}

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
#TODO: validate $VERSION

# ---------------------------------------------
# -- Login to Image registry
# ---------------------------------------------
echo
echo "|-- Logging into image registry thru Docker ..."
aws \
  ecr \
  get-login-password \
  --region us-east-1 |
  docker \
    login \
    --username AWS \
    --password-stdin \
    ${IMAGE_REPO_URI}

echo
echo "|-- "
$DOCKER_BINARY image ls -a | grep ${REPOSITORY_NAME} | sort

# ---------------------------------------------
# -- Push
# ---------------------------------------------
echo
echo "|-- Pushing image to AWS ECR"
$DOCKER_BINARY push ${IMAGE_REPO_URI}/${REPOSITORY_NAME}:${TAG}

# Cleanup
$DOCKER_BINARY rmi ${REPOSITORY_NAME}:${TAG}

# ---------------------------------------------
# -- Logout
# ---------------------------------------------
# $DOCKER_BINARY logout
