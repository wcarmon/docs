#!/bin/bash


#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var



# ---------------------------------------------
# -- Constants
# ---------------------------------------------
readonly SCRIPT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/")
readonly KUBECTL="minikube kubectl --"


# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly OUTPUT=$HOME/tmp/kustomize.output.yaml


# ---------------------------------------------
# -- Run kustomize
# ---------------------------------------------
$KUBECTL kustomize $SCRIPT_DIR --output $OUTPUT


# ---------------------------------------------
# -- Report
# ---------------------------------------------
#echo
#echo "|-- output:"
#cat $OUTPUT
