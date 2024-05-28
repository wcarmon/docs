#!/bin/bash

# ---------------------------------------------
# -- Puts the installed dropbox daemon in a good state
# --
# -- Assumptions:
# -- 1. Dropbox installed: https://www.dropbox.com/install-linux
# ---------------------------------------------
#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# ---------------------------------------------
# -- Stop
# ---------------------------------------------
echo ""
echo "|-- stopping dropbox"
dropbox stop || true
pkill --ignore-case --exact dropbox || true


# ---------------------------------------------
# -- Update
# ---------------------------------------------
#echo ""
#echo "|-- updating dropbox"
#dropbox update


# ---------------------------------------------
# -- Start
# ---------------------------------------------
echo ""
echo "|-- starting dropbox"
dropbox autostart y
dropbox start
