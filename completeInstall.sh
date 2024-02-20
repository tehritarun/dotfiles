#!/bin/bash

sudo pacman -S --noconfirm alacritty kitty git starship tmux neovim
sudo pacman -S --noconfirm tree fzf lazygit
git clone https://github.com/tehritarun/dotfiles.git ~/dotfiles
cd ~/dotfiles || exit
bash linkFiles.sh
fc-cache -fv
git clone https://github.com/tehritarun/nvim_Config.git ~/.config/nvim
