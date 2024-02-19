#!/bin/bash

sudo pacman -S alacritty kitty git starship tmux nvim
sudo pacman -S tree fzf lazygit
git clone https://github.com/tehritarun/dotfiles.git ~/dotfiles
cd ~/dotfiles || exit
bash linkFiles.sh
git clone https://github.com/tehritarun/nvim_Config.git ~/.config/nvim
