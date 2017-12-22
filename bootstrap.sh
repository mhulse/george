#!/usr/bin/env bash

# https://github.com/koalaman/shellcheck/wiki/SC1090
# shellcheck source=/dev/null

#-----------------------------------------------------------------------

Message() {

  echo
  echo "---------------------------------------------"
  echo $1
  echo "---------------------------------------------"
  echo

}

Update() {

  Message "UPDATING PACKAGES"

  sudo apt-get update
  sudo apt-get upgrade

}

Reload() {
  
  source ~/.bashrc
  
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

#
# https://www.linux.com/blog/create-your-own-neural-paintings-using-deep-learning
# http://torch.ch/docs/getting-started.html
# https://github.com/jcjohnson/neural-style/blob/master/INSTALL.md
#

Message "INSTALLING TORCH"

#
# http://torch.ch/docs/getting-started.html#_
#

cd ~/ || exit
# Install all dependencies for Torch:
bash <(curl -sL https://raw.githubusercontent.com/torch/ezinstall/master/install-deps)
git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch || exit
# Install Lua and Torch, and add Torch to `$PATH` variable:
yes | ./install.sh
cd - || exit

Reload

#-----------------------------------------------------------------------

Message "INSTALLING LOADCAFFE"

# Install Google’s Protocol Buffer library as it is a Load Caffe depencency:
sudo apt-get install -y --force-yes \
  libprotobuf-dev \
  protobuf-compiler

# Install Load Caffe:
luarocks install loadcaffe

Reload

Update

#-----------------------------------------------------------------------

Message "INSTALLING NEURAL-STYLE"

cd ~/ || exit
# Clone neural-style from GitHub:
git clone https://github.com/jcjohnson/neural-style.git
cd ~/neural-style/models || exit
# Download the pre-trained neural network models:
yes | sh download_models.sh
cd - || exit

Reload

#-----------------------------------------------------------------------

Update

Message "BOOTSTRAP FINISHED!"
