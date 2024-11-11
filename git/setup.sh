#! /usr/bin/bash

echo ":: Setup git ... "
# Install packages
# git, github-cli, gnupg
sudo pacman -S git github-cli gnupg

# stow git
stow -v git

# Login through github
gh auth login

