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
readonly AWS=$(which aws)
readonly DOCKER=$(which docker)
readonly GCLOUD=$HOME/bin/gcloud
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

# AWS (Elastic Container Registry):
#   - Format: TODO
#   - eg. "ecr.us-east-1.amazonaws.com"
#
# Google Cloud (Artifact Registry):
#   - Format: HOST-NAME/PROJECT-ID
#   - eg. "us-east1-docker.pkg.dev/my-project-id"
#   - See https://console.cloud.google.com/artifacts
readonly IMAGE_REPO_URI=ecr.us-east-1.amazonaws.com

# AWS:
#  - See the name in ECR
#
# Google cloud:
#  - gcloud artifacts repositories list
readonly REPOSITORY_NAME="company/example"

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Everything before the version
readonly QUALIFIED_IMAGE_NAME="${IMAGE_REPO_URI}/${REPOSITORY_NAME}/${SHORT_IMAGE_NAME}"

readonly TAG_LATEST="latest-${TAG_SUFFIX}"
readonly TAG_NUMBERED="${SEMVER}-${TAG_SUFFIX}"

# AWS:          TODO
# Google Cloud: HOST-NAME/PROJECT-ID/REPOSITORY/IMAGE:TAG
readonly IMAGE_TO_PUSH="${QUALIFIED_IMAGE_NAME}:${TAG_NUMBERED}"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
# -- validate tag
if [ "$(echo $TAG_NUMBERED)" = "" ]; then
  echo
  echo "Error: tag must have a value"
  echo "See version file at $VERSION_FILE"
  exit 10
fi

# ---------------------------------------------
# -- Authenticate
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

#$GCLOUD auth \
#  configure-docker \
#  us-east1-docker.pkg.dev

# ---------------------------------------------
# -- Push
# ---------------------------------------------
echo
echo "|-- Related local images:"
$DOCKER image ls -a | grep ${QUALIFIED_IMAGE_NAME} | sort

echo
echo "|-- Pushing Image: $IMAGE_TO_PUSH"
$DOCKER push $IMAGE_TO_PUSH

# ---------------------------------------------
# -- Report
# ---------------------------------------------
# AWS (ECR):
# - TODO
#
# Google cloud (Artifact Registry)
# - gcloud artifacts docker images list $IMAGE_REPO_URI/$REPOSITORY_NAME
# - https://console.cloud.google.com/artifacts/docker/<my-project-id>/us-east1/
echo
echo "|-- Remote images"
$GCLOUD artifacts docker images list $IMAGE_REPO_URI/$REPOSITORY_NAME

#TODO: warn if same/existing image version pushed

# -- Cleanup
#$DOCKER rmi $IMAGE_TO_PUSH

# ---------------------------------------------
# -- Logout
# ---------------------------------------------
# $DOCKER logout
