#!/bin/bash

# ---------------------------------------------
# -- Push docker images to registry (eg. ECR or Artifact Registry)
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. Docker Image repository exists (eg. AWS ECR, Google Artifact Registry)
# -- 3. Image already built locally (see ./build.image.sh)
# -- 4. awscli or gcloud (or equivalent) is installed
# -- 5. cli tool authenticated with cloud provider
# --    AWS:
# --      - Previously ran `aws configure`
# --    GCloud:
# --      - create `config.json` via `gcloud auth configure-docker us-east1-docker.pkg.dev`:
# --      - https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling
# -- 6. Docker can login to image registry
# --    AWS:
# --    - TODO
# --    GCloud:
# --    - `gcloud components install docker-credential-gcr`
# --    - `ln -sv ... $HOME/bin/`
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
$DOCKER image ls -a | grep ${REPOSITORY_NAME} | sort

# ---------------------------------------------
# -- Push
# ---------------------------------------------
echo
echo "|-- Pushing image to AWS ECR"
$DOCKER push ${IMAGE_REPO_URI}/${REPOSITORY_NAME}:${TAG}

# Cleanup
$DOCKER rmi ${REPOSITORY_NAME}:${TAG}

# ---------------------------------------------
# -- Logout
# ---------------------------------------------
# $DOCKER logout
