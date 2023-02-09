#!/bin/bash

# ---------------------------------------------
# -- Builds, lints, tests, checks formatting, pushes images to registry
# --
# -- Assumptions:
# -- 1. CI tool executes this (eg. Jenkins, GitHub Actions)
# -- 2. Docker installed: https://docs.docker.com/get-docker/
# -- 3. Docker Image repository exists (eg. AWS ECR, Google Artifact Registry)
# -- 4. Jenkins has a Shell Execution step like this:
# --    #!/bin/bash
# --    chmod +x ./scripts/*.sh
# --    ./scripts/build.ci.sh ${VERSION}
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly CURRENT_USER=$(whoami)
readonly CURRENT_USER_ID=$(id -u)
readonly DOCKER=$(which docker)
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly SCRIPTS_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

# ---------------------------------------------
# -- Script arguments
# ---------------------------------------------

# ---------------------------------------------
# -- Config
# ---------------------------------------------

# ---------------------------------------------
# -- Derived
# ---------------------------------------------

# ---------------------------------------------
# -- Validate
# ---------------------------------------------

# ---------------------------------------------
# -- Debug CI env
# ---------------------------------------------

# ---------------------------------------------
# -- Enable scripts
# ---------------------------------------------
chmod +x $SCRIPTS_DIR/*.sh

# ---------------------------------------------
# -- Build & Push
# ---------------------------------------------
cd $PARENT_DIR >/dev/null 2>&1

$SCRIPTS_DIR/test.via_docker.sh

$SCRIPTS_DIR/lint.sh

$SCRIPTS_DIR/build.image.sh

$SCRIPTS_DIR/push.image.sh ${SEMVER}
