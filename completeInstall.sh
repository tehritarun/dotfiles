#!/bin/bash

ask(){
    read -rp "$1 (Y/n): " resp
    [ -z "$resp" ] || [ "$resp" = "y" ]
}

if ask "Install mendatory tools?"
then
    sudo pacman -S --noconfirm alacritty kitty git starship tmux neovim
fi

if ask "Install optional tools?"
then
    sudo pacman -S --noconfirm tree fzf lazygit
fi

if ask "Install configuration?"
then
    git clone https://github.com/tehritarun/dotfiles.git ~/dotfiles
    cd ~/dotfiles || exit
    bash linkFiles.sh
    fc-cache -fv
fi

if ask "Install nvim configuration?"
then
    git clone https://github.com/tehritarun/nvim_Config.git ~/.config/nvim
fi
