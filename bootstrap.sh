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

Reload() {
  
  source ~/.bashrc
  
}

#-----------------------------------------------------------------------

Message "STARTING BOOTSTRAP!"

Update

#-----------------------------------------------------------------------

Message "INSTALLING TOOLS AND HELPERS"

# https://serverfault.com/a/670688/277089
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install -y --force-yes \
  software-properties-common \
  vim \
  htop \
  curl \
  git

Update

#-----------------------------------------------------------------------

Message "INSTALLING DEEP STYLE"

#
# https://www.linux.com/blog/create-your-own-neural-paintings-using-deep-learning
#

bash <(curl -sL https://raw.githubusercontent.com/torch/ezinstall/master/install-deps)
git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch/ || return
yes | ./install.sh > /dev/null
cd - || return

Reload

sudo apt-get install -y --force-yes \
  libprotobuf-dev \
  protobuf-compiler

luarocks install loadcaffe

Reload

git clone https://github.com/jcjohnson/neural-style.git
cd ~/neural-style/models/ || return
yes | download_models.sh > /dev/null
cd - || return

Reload

Update

#-----------------------------------------------------------------------

Message "BOOTSTRAP FINISHED!"
