#! /usr/bin/bash

echo ":: Start setup ..."

# prepare libraries for installation
source ./library.sh

# install & setup general packages
echo ":: Setup general packages ..."

# install & setup other packages
source ./git/setup.sh
source ./zsh/setup.sh
source ./tmux/setup.sh
source ./nvim/setup.sh
source ./alacritty/setup.sh
source ./hyprland/setup.sh
