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
#readonly DOCKER=$(which docker)
readonly DOCKER=docker
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")


# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------
# semver: https://semver.org/
# eg. "1.2.3" or "4.5"
set +u
readonly SEMVER=$1
set -u

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

# Dir contains Dockerfile
readonly PROJ_ROOT="$PARENT_DIR"

readonly DOCKERFILE=./Dockerfile

# Optional
# Useful as a version suffix when image repo contains multiple variants
# (eg. "-debian" or "-alpine")
readonly TAG_SUFFIX="-java"

# -- Everything before the version
#
# AWS (Elastic Container Registry):
#   - Format: TODO
#   - eg. "ecr.us-east-1.amazonaws.com", then your package name

# Google Cloud (Artifact Registry):
#   - Format: HOST-NAME/PROJECT-ID
#   - eg. "us-east1-docker.pkg.dev/my-project-id", then your package name
#   - See https://console.cloud.google.com/artifacts

readonly QUALIFIED_IMAGE_NAME="todo-a"

# -- Optional
# -- Path to write git info as html
# -- Ensure this path is in .gitignore
readonly GIT_INFO_HTML_FILE="src/git-info.html"

# -- Optional
# -- Path to write git info as property file
# -- Ensure this path is in .gitignore
readonly GIT_INFO_PROPERTY_FILE="src/git-info.properties"
#readonly GIT_INFO_PROPERTY_FILE="src/main/resources/git-info.properties"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly TAG_LATEST="latest${TAG_SUFFIX}"
readonly TAG_NUMBERED="${SEMVER}${TAG_SUFFIX}"

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
# -- Write git info
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
#echo "|-- Latest commit: $(git log -1 --format='%H')"
echo "|-- Latest commit: $(git rev-parse HEAD)"
echo "|-- Latest commit ts: $(git log -1 --format='%ci')"

if [ -n "$GIT_INFO_HTML_FILE" ]; then
  SINK="$GIT_INFO_HTML_FILE"

  # -- truncate
  :> $SINK

  echo '<!doctype html>
  <html lang="en">
  <body>
    <ul>' >> $SINK

#  echo "    <li>gitHash: $(git log -1 --format='%H')</li>" >> $SINK
  echo "    <li>gitHash: $(git rev-parse HEAD)</li>" >> $SINK
  echo "    <li>buildTS: $(git log -1 --format='%ci')</li>" >> $SINK

  echo '  </ul>
  </body>
  </html>' >> $SINK

  echo "|-- Wrote git info as html to $SINK"
fi


if [ -n "$GIT_INFO_PROPERTY_FILE" ]; then
  SINK="$GIT_INFO_PROPERTY_FILE"

  # -- truncate
  :> $SINK

  echo "git.hash=$(git log -1 --format='%H')" >> $SINK
  echo "git.ts=$(git log -1 --format='%ci')" >> $SINK

  echo "|-- Wrote git info as property file to $SINK"
fi


# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

echo
echo "|-- Building & tagging docker image into local registry ..."
$DOCKER build \
  --file ${DOCKERFILE} \
  --tag "${QUALIFIED_IMAGE_NAME}:${TAG_LATEST}" \
  --tag "${QUALIFIED_IMAGE_NAME}:${TAG_NUMBERED}" \
  .


# ---------------------------------------------
# -- Load image to minikube
# ---------------------------------------------
#if command -v minikube &> /dev/null; then
#  # -- See https://minikube.sigs.k8s.io/docs/handbook/pushing/#7-loading-directly-to-in-cluster-container-runtime
#
#  echo
#  echo "|-- Loading images into minikube ..."
#  minikube image load "${QUALIFIED_IMAGE_NAME}:${TAG_NUMBERED}"
#  #minikube image load "${QUALIFIED_IMAGE_NAME}:${TAG_LATEST}"
#  echo "|-- Successfully loaded images into minikube"
#
#  echo
#  echo "|-- Verify: minikube image ls | grep -i docker"
#
#else
#    echo
#    echo "|-- To load images into minikube:"
#    echo "minikube image load ${QUALIFIED_IMAGE_NAME}:${TAG_LATEST}"
#    echo "minikube image load ${QUALIFIED_IMAGE_NAME}:${TAG_NUMBERED}"
#fi


# ---------------------------------------------
# -- Load all related images into minikube
# ---------------------------------------------
#readonly IMAGES=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep $QUALIFIED_IMAGE_NAME | sort --reverse)
#
#for IMAGE in $IMAGES; do
#
#  echo
#  echo "Loading image into Minikube: $IMAGE"
#  minikube image load "$IMAGE"
#done
#
#echo "|-- Successfully loaded docker images into minikube"


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Successfully built and tagged image"
$DOCKER images -a | grep ${QUALIFIED_IMAGE_NAME}

echo
echo "|-- Debug using:"
echo "$DOCKER run --rm -it $QUALIFIED_IMAGE_NAME:latest /bin/ash"
echo
echo "|-- Show effective configuration (inside container)"
echo "nginx -T"


readonly CONTAINER_NAME=my_svr
echo
echo "|-- Run using:"
echo "$DOCKER stop $CONTAINER_NAME"
echo "$DOCKER run --name $CONTAINER_NAME -d -p 13000:3000 -p 13001:3001 $QUALIFIED_IMAGE_NAME:latest"
echo "$DOCKER ps -a | grep $CONTAINER_NAME"
echo "$DOCKER logs $CONTAINER_NAME"


# -- Cleanup
# docker container prune --force
# docker image prune --force
