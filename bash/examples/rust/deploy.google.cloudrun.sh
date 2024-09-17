#!/bin/bash

# ---------------------------------------------
# -- Deploys local docker image to Google Cloud Run
# --
# -- Assumptions:
# -- 1. Docker installed: https://docs.docker.com/get-docker/
# -- 2. Setup credential helper
# --    - Created `config.json`
#           - run `gcloud auth configure-docker us-east1-docker.pkg.dev`:
# --    - Verify: cat $HOME/.docker/config.json
# --    - Docs: https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling
# -- 3. docker-credential-gcloud
# --    - `gcloud components install docker-credential-gcr`
# --    - `ln -sv ... $HOME/bin/`   <-- TODO: improve this
# -- 4. Docker Image repository exists (eg. Artifact Repository)
# --    - https://console.cloud.google.com/artifacts
# --    - Create repository
# --        - Format: Docker
# --        - Mode: Standard
# --        - Location type: Region (us-east1 or us-east5)
# --        - Encryption: Google-managed encryption key
# --        - Immutable image tags: Disabled
# --        - Cleanup policies: Dry run
# --  5. Authenticate with the container registry:
# --        gcloud auth configure-docker us-east1-docker.pkg.dev
# --        gcloud auth configure-docker us-east5-docker.pkg.dev
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
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
# Unqualified image name
# Final segment before the version
readonly SHORT_IMAGE_NAME="foo"

# Optional
# Useful as a version suffix when image repo contains multiple variants
# (eg. "-debian" or "-alpine")
readonly TAG_SUFFIX=""

# Google Cloud Artifact Registry:
#   - Format: HOST-NAME/PROJECT-ID
#   - eg. "us-east1-docker.pkg.dev/my-project-id"
#   - See https://console.cloud.google.com/artifacts
readonly IMAGE_REPO_URI=us-east1-docker.pkg.dev/foo-bar

# Google cloud: gcloud artifacts repositories list
readonly REPOSITORY_NAME=quux

# Google cloud: gcloud run services list
readonly SERVICE_NAME=foo-server

# ---------------------------------------------
# -- Derived
# ---------------------------------------------
# Everything before the version
readonly QUALIFIED_IMAGE_NAME="${IMAGE_REPO_URI}/${REPOSITORY_NAME}/${SHORT_IMAGE_NAME}"

readonly TAG_NUMBERED="${SEMVER}${TAG_SUFFIX}"

# Google Cloud: HOST-NAME/PROJECT-ID/REPOSITORY/IMAGE:TAG
readonly IMAGE_TO_DEPLOY="${QUALIFIED_IMAGE_NAME}:${TAG_NUMBERED}"

# ---------------------------------------------
# -- Validate
# ---------------------------------------------
# -- validate tag
if [ "$(echo $TAG_NUMBERED)" = "" ]; then
  echo
  echo "Error: tag must have a value"
  echo "See version file at $VERSION_FILE"
  exit 100
fi

# ---------------------------------------------
# -- Authenticate with Image registry
# ---------------------------------------------
# only need to do once, this stores into $HOME/.docker/config.json
#$GCLOUD auth \
#  configure-docker \
#  us-east1-docker.pkg.dev

# ---------------------------------------------
# -- Deploy (Run Image)
# ---------------------------------------------
# GOTCHA: don't forget to bump image version
# See https://cloud.google.com/sdk/gcloud/reference/run/deploy
echo
echo "|-- Deploying image to Cloud Run (slow): $IMAGE_TO_DEPLOY"
$GCLOUD run deploy $SERVICE_NAME \
  --allow-unauthenticated \
  --image=$IMAGE_TO_DEPLOY \
  --max-instances=2 \
  --memory=128Mi \
  --min-instances=0 \
  --no-use-http2 \
  --platform=managed \
  --region=us-east1 \
  --timeout=7m

# gRPC:           --use-http2 \
# REST over HTTP: --no-use-http2 \

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Services:"
$GCLOUD run services list

echo
echo "|-- Deployed service info:"
$GCLOUD run services describe chrono-server \
  --region=us-east1

echo
echo "|-- Revisions:"
$GCLOUD run revisions list \
  --service chrono-server \
  --region=us-east1

#NOTE: logs explorer is MUCH better than the Cloud Run logs
echo
echo "|-- Logs:"
echo "https://console.cloud.google.com/logs/query?project=my-project-id"

#curl https://something.run.app
