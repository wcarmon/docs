#!/bin/bash

# ---------------------------------------------
# -- Installs conan, clang (via pipx) on linux
# --
# -- Assumptions:
# -- 1. debian based Linux
# ---------------------------------------------

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


sudo apt install -y \
build-essential \
clang \
clang-tidy \
libfontenc-dev \
libgl-dev \
libgl1-mesa-dev \
libice-dev \
libsm-dev \
libx11-dev \
libx11-xcb-dev \
libxau-dev \
libxaw7-dev \
libxcb-composite0-dev \
libxcb-cursor-dev \
libxcb-dri2-0-dev \
libxcb-dri3-dev \
libxcb-ewmh-dev \
libxcb-glx0-dev \
libxcb-icccm4-dev \
libxcb-image0-dev \
libxcb-keysyms1-dev \
libxcb-present-dev \
libxcb-randr0-dev \
libxcb-render-util0-dev \
libxcb-render0-dev \
libxcb-res0-dev \
libxcb-shape0-dev \
libxcb-sync-dev \
libxcb-util-dev \
libxcb-util0-dev \
libxcb-xfixes0-dev \
libxcb-xinerama0-dev \
libxcb-xkb-dev \
libxcomposite-dev \
libxcursor-dev \
libxdamage-dev \
libxfixes-dev \
libxi-dev \
libxinerama-dev \
libxkbfile-dev \
libxmuu-dev \
libxrandr-dev \
libxres-dev \
libxtst-dev \
libxv-dev \
libxxf86vm-dev \
pipx \
python3-full \
python3-pip \
;


pipx ensurepath;
pipx install conan;


conan profile detect --force
conan profile path default
