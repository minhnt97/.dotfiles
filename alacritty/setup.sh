#! /usr/bin/bash

echo ":: Setup alacritty ... "
# Install packages
sudo pacman -S alacritty

# We use Alacritty's default Linux config directory as our storage location here.
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# Install config files
stow -v alacritty
