#! /usr/bin/bash

echo ":: Start setup neovim ..."

# install necessary apps
sudo pacman -S cmake make gcc npm python luarocks fzf ripgrep neovim
 
stow -v nvim

