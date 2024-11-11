#! /usr/bin/bash

echo ":: Start setup neovim ..."

# install cmake & make 
sudo pacman -S cmake make

# install gcc
sudo pacman -S gcc

# install npm
sudo pacman -S npm

# install python
sudo pacman -S python

# install luarocks
sudo pacman -S luarocks

# install fzf & ripgrep
sudo pacman -S fzf ripgrep

# install & stow neovim
sudo pacman -S neovim
 
stow -v nvim

