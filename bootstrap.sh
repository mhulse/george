#!/usr/bin/env bash

# https://github.com/koalaman/shellcheck/wiki/SC1090
# shellcheck source=/dev/null

#-----------------------------------------------------------------------

Message() {

  echo "---------------------------------------------"
  echo $1
  echo "---------------------------------------------"

}

Update() {

  Message "UPDATING PACKAGES"

  sudo apt-get update
  sudo apt-get upgrade

}

#-----------------------------------------------------------------------

Message "STARTING BOOTSTRAP!"

Update

#-----------------------------------------------------------------------

Message "INSTALLING TOOLS AND HELPERS"

# https://github.com/mhulse/george/issues/1
export DEBIAN_FRONTEND=noninteractive
sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile

sudo apt-get install -y --force-yes \
  software-properties-common \
  vim \
  htop \
  curl \
  git

Update

#-----------------------------------------------------------------------

Message "INSTALLING TORCH"

# Make sure we’re home:
cd $HOME || exit
# Install all dependencies for Torch:
bash <(curl -sL https://raw.githubusercontent.com/torch/ezinstall/master/install-deps)
# Remove previous install:
rm -rf torch
# Install Lua and Torch, (adds Torch `th` to `$PATH`):
git clone https://github.com/torch/distro.git torch --recursive
cd torch || exit
# Set env to use lua (is this needed?):
TORCH_LUA_VERSION=LUA52
yes | ./install.sh
# Go back to previous directory:
cd - || exit

#-----------------------------------------------------------------------

Message "INSTALLING LOADCAFFE"

# Google’s Protocol Buffer library is a Load Caffe depencency:
sudo apt-get install -y --force-yes \
  libprotobuf-dev \
  protobuf-compiler

source .bashrc

# Install Load Caffe:
luarocks install loadcaffe

Update

#-----------------------------------------------------------------------

Message "INSTALLING NEURAL-STYLE"

# Make sure we’re home:
cd $HOME || exit
# Remove previous install:
rm -rf neural-style/*
rm -rf neural-style/.* 2> /dev/null
# Clone neural-style from GitHub:
git clone https://github.com/jcjohnson/neural-style.git
cd neural-style || exit
# Download the pre-trained neural network models:
yes | sh models/download_models.sh
# Go back to previous directory:
cd - || exit

Update

#-----------------------------------------------------------------------

Message "BOOTSTRAP FINISHED!"
