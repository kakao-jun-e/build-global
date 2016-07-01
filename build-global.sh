#!/bin/bash

# Build latest version of GNU GLOBAL, version management with stow
# OS: Ubuntu 14.04 LTS and newer
# version: 6.6.2

set -eu

readonly version="6.6.2"

# install dependencies
sudo apt-get -qq update
sudo apt-get -qq install -y stow build-essential wget libncurses5-dev \
     automake autoconf bison flex gperf \
     texinfo

# download source package
if [[ ! -d global-"$version" ]]; then
    wget http://ftp.gnu.org/pub/gnu/global/global-"$version".tar.gz
    tar xvf global-"$version".tar.gz
fi

# build and install
sudo mkdir -p /usr/local/stow
cd global-"$version"
./configure

make
sudo make \
     install \
     prefix=/usr/local/stow/global-"$version"

cd /usr/local/stow
sudo stow --override=share/info global-"$version"
