#!/bin/bash

# ---------------------------------------------
# -- Builds docker image for app
# --
# -- Assumptions:
# -- 1. Docker 27+ installed: https://docs.docker.com/get-docker/
# --    See Linux Mint instructions in gdocs
# -- 2. Docker buildx installed - https://docs.docker.com/go/buildx/
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
#
# If present, SEMVER overrides whatever is in $PARENT_DIR/last-version.txt
# If absent, attempts to read from $PARENT_DIR/last-version.txt
set +u
SEMVER=$1
set -u


# ---------------------------------------------
# -- Config
# ---------------------------------------------
# NOTE: all paths relative to $PROJ_ROOT

# Dir contains Dockerfile
readonly PROJ_ROOT="$PARENT_DIR"

readonly DOCKER_BUILD_ROOT=.
readonly DOCKERFILE=./Dockerfile

readonly VERSION_FILE=./last-version.txt


# Optional
# Useful as a version suffix when image repo contains multiple variants
# (eg. "-debian" or "-alpine")
readonly TAG_SUFFIX="-alpine"


# -- Everything before the version
#
# AWS (Elastic Container Registry):
#   - Format: TODO
#   - eg. "ecr.us-east-1.amazonaws.com", then your package name

# Google Cloud (Artifact Registry):
#   - Format: HOST-NAME/PROJECT-ID
#   - eg. "us-east1-docker.pkg.dev/my-project-id", then your package name
#   - See https://console.cloud.google.com/artifacts
# TODO: fix this
readonly QUALIFIED_IMAGE_NAME="todo-a"


# ---------------------------------------------
# -- Derived
# ---------------------------------------------
readonly ABS_VERSION_FILE=$(realpath "$VERSION_FILE")
readonly TAG_LATEST="latest${TAG_SUFFIX}"


# ---------------------------------------------
# -- Version bumps
# ---------------------------------------------

# -- Remove all spaces, check for value
if [[ -z "${SEMVER// }" ]]; then

  # -- Require version file exists
  if [[ ! -f "$ABS_VERSION_FILE" ]]; then
    echo
    echo "|-- Failed to find version file at $ABS_VERSION_FILE"
    exit 20
  fi

  echo "|-- Found version file at $ABS_VERSION_FILE"

  VERSION_FILE_CONTENT=$(grep -v '^\s*#' $ABS_VERSION_FILE | sed '/^\s*$/d' | xargs)
  echo "|-- Version file contents: $VERSION_FILE_CONTENT (old)"

  #-- Parse version
  MAJOR=$(echo "$VERSION_FILE_CONTENT" | cut -d. -f1)
  MINOR=$(echo "$VERSION_FILE_CONTENT" | cut -d. -f2)
  PATCH=$(echo "$VERSION_FILE_CONTENT" | cut -d. -f3)

  #-- Bump version
  NEW_PATCH=$((PATCH + 1))
  SEMVER="$MAJOR.$MINOR.$NEW_PATCH"
fi

readonly TAG_NUMBERED="${SEMVER}${TAG_SUFFIX}"


# ---------------------------------------------
# -- Validate
# ---------------------------------------------
if [ "$(echo $SEMVER)" = "" ]; then
  echo
  echo "Error: pass one argument for version in semver format"
  exit 10
fi

if [ "$(echo $TAG_NUMBERED)" = "" ]; then
  echo
  echo "Error: tag must have a value"
  exit 11
fi


# ---------------------------------------------
# -- Write gitinfo.rs
# ---------------------------------------------
cd "$PROJ_ROOT" >/dev/null 2>&1

readonly BUILD_TS="$(git log -1 --format='%ci')";
readonly GIT_HASH="$(git log -1 --format='%H')";

function write_git_info() {
  local LOCAL_SINK=$(realpath "$1")
  local LOCAL_BUILD_TS="$2"
  local LOCAL_GIT_HASH="$3"

  # -- truncate
  :> $LOCAL_SINK

  cat > $LOCAL_SINK <<EOF
// NOTE: Commit this file.
// NOTE: Build process overwrites this file.
//
// Build process last modified at $(date)
#[allow(dead_code)]
pub(crate) const BUILD_TS: &str = "$LOCAL_BUILD_TS";

#[allow(dead_code)]
pub(crate) const GIT_HASH: &str = "$LOCAL_GIT_HASH";
EOF

echo "|-- Wrote gitinfo.rs file to $LOCAL_SINK"

: '
### Example usage in main.rs:
------------------------------------
...
use crate::gitinfo::BUILD_TS;
use crate::gitinfo::GIT_HASH;

mod gitinfo;

info!("GIT_HASH={GIT_HASH}");

// info!("BUILD_TS={BUILD_TS}");
let build_ts = chrono::DateTime::parse_from_str(BUILD_TS, "%Y-%m-%d %H:%M:%S %z")
    .expect("Failed to parse build timestamp")
    .to_utc();
info!("build_ts: {build_ts}");
'
}

echo
echo "|-- Latest commit ts: '$BUILD_TS'"
echo "|-- Latest commit hash: '$GIT_HASH'"

write_git_info "my-binary-crate-1/src/gitinfo.rs" "$BUILD_TS" "$GIT_HASH"
write_git_info "my-binary-crate-2/src/gitinfo.rs" "$BUILD_TS" "$GIT_HASH"


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
  $DOCKER_BUILD_ROOT


# ---------------------------------------------
# -- Update version file
# ---------------------------------------------
echo "$SEMVER" > $ABS_VERSION_FILE;
echo ""
echo "|-- Overwrote version in $ABS_VERSION_FILE"


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
#    echo "minikube image load ${QUALIFIED_IMAGE_NAME}:${TAG_NUMBERED}"
#    #echo "minikube image load ${QUALIFIED_IMAGE_NAME}:${TAG_LATEST}"
#fi


# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- Successfully built and tagged image"
$DOCKER images -a | grep ${QUALIFIED_IMAGE_NAME}

echo
echo "|-- Debug using:"
echo "$DOCKER run --rm -it $QUALIFIED_IMAGE_NAME:$TAG_LATEST /bin/ash"
echo "$DOCKER run --rm -it $QUALIFIED_IMAGE_NAME:$TAG_LATEST /bin/bash"

# TODO: change this
readonly CONTAINER_NAME=my_svr
echo
echo "|-- Run using:"
echo "$DOCKER stop $CONTAINER_NAME"
echo "$DOCKER run --name $CONTAINER_NAME -d -p 13000:3000 -p 13001:3001 $QUALIFIED_IMAGE_NAME:$TAG_LATEST"
echo "$DOCKER ps -a | grep $CONTAINER_NAME"
echo "$DOCKER logs $CONTAINER_NAME"


# -- Cleanup
echo
echo "|-- Cleanup:"
echo "docker container prune --force"
echo "docker image prune -a --force"
