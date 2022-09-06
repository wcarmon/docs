#!/bin/bash

# ---------------------------------------------
# -- Deploys to Google Cloud Run
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. setup credential helper
# --      create `config.json` via `gcloud auth configure-docker us-east1-docker.pkg.dev`:
# --    - https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling
# -- 3. docker-credential-gcloud
# --    - `gcloud components install docker-credential-gcr`
# --    - `ln -sv ... $HOME/bin/`
# ---------------------------------------------
#set -x # uncomment to debug
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly DOCKER=$(which docker)
readonly GCLOUD=$HOME/bin/gcloud
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly IMAGE_TO_PUSH=us-east1-docker.pkg.dev/foo/bar/quux:latest
readonly SERVICE_NAME=foo-server

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Authenticate
# ---------------------------------------------
#$GCLOUD auth \
#  configure-docker \
#  us-east1-docker.pkg.dev

# ---------------------------------------------
# -- Push image
# ---------------------------------------------
echo
echo "|-- Pushing $IMAGE_TO_PUSH"
$DOCKER push $IMAGE_TO_PUSH

# ---------------------------------------------
# -- Verify
# ---------------------------------------------
# See https://console.cloud.google.com/artifacts/docker/foo/bar/quux?project=my-project

echo
echo "|-- Images on Artifact Registry"
$GCLOUD artifacts docker images list \
  us-east1-docker.pkg.dev/foo/bar

# ---------------------------------------------
# -- Deploy (Run Image)
# ---------------------------------------------
# See https://cloud.google.com/sdk/gcloud/reference/run/deploy
echo
echo "|-- Deploying image to Cloud Run (slow)"
$GCLOUD run deploy $SERVICE_NAME \
  --allow-unauthenticated \
  --image=$IMAGE_TO_PUSH \
  --max-instances=2 \
  --memory=128Mi \
  --min-instances=0 \
  --platform=managed \
  --region=us-east1 \
  --timeout=3m

#TODO: for grpc: --use-http2 \

# ---------------------------------------------
# -- Report
# ---------------------------------------------
#TODO: get dynamically (already printed after successful deploy)
#echo
#echo "|-- Service URL:"
#echo "https://something.run.app"

#NOTE: logs explorer is MUCH better than the Cloud Run logs
echo
echo "|-- Logs:"
echo "https://console.cloud.google.com/logs/query?project=my-project"

echo
echo "|-- Images:"
echo "https://console.cloud.google.com/artifacts/docker/foo/us-east1/baz?project=my-project"

#curl https://something.run.app
