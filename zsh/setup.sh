#! /usr/bin/bash

yay -S curl zsh fzf unzip

if [ ! -d "~/.oh-my-zsh" ]
then  
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

rm ~/.zshrc

stow -vR zsh 

if [ ! -d "~/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
then 
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi


if [ ! -d "~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
fi

yay -S oh-my-posh


