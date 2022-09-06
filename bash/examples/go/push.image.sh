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
readonly APP_NAME=go-rest-server
readonly IMAGE_REPO_URI=ecr.us-east-1.amazonaws.com

# See the name in ECR
readonly REPOSITORY_NAME="company/example"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly QUALIFIED_REPOSITORY_NAME="${IMAGE_REPO_URI}/${REPOSITORY_NAME}"
readonly TAG_LATEST="latest-${APP_NAME}"
readonly TAG_NUMBERED="${VERSION}-${APP_NAME}"

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

# ---------------------------------------------
# -- Push
# ---------------------------------------------
echo
echo "|-- Available images:"
$DOCKER image ls -a | grep ${REPOSITORY_NAME} | sort

echo
echo "|-- Pushing image to AWS ECR"
$DOCKER push ${QUALIFIED_REPOSITORY_NAME}/${TAG_NUMBERED}
#$DOCKER push ${QUALIFIED_REPOSITORY_NAME}/${TAG_LATEST}

# Cleanup
#$DOCKER rmi ${QUALIFIED_REPOSITORY_NAME}/${TAG_NUMBERED}
#$DOCKER rmi ${QUALIFIED_REPOSITORY_NAME}/${TAG_LATEST}

# ---------------------------------------------
# -- Logout
# ---------------------------------------------
# $DOCKER logout
