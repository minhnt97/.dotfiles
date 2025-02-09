#! /usr/bin/bash

echo ":: Start setup ..."

# install yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# prepare libraries for installation
source ./library.sh

# install & setup general packages
echo ":: Setup general packages ..."

# install & setup other packages
source ./hyprland/setup.sh
source ./kitty/setup.sh
source ./zshrc/setup.sh
source ./tmux/setup.sh
source ./nvim/setup.sh
