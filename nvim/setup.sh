#! /usr/bin/bash

echo ":: Start setup neovim ..."

# install necessary apps
yay -S cmake make gcc npm python luarocks fzf ripgrep neovim
 
stow -vR nvim

