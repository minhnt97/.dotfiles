#! /usr/bin/bash

echo ":: Start setup tmux ..."

# install & stow tmux
yay -S tmux

stow -v tmux

# install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
