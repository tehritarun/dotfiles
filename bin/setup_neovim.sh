#!/bin/bash

echo "---------------------SETTING UP NEOVIM----------------------"

branch_name="feature/personlised_changes-070726"

# Clone nvim config if not exists
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "Cloning Neovim Configuration..."
    git clone https://github.com/tehritarun/kickstart.nvim.git ~/.config/nvim
    cd ~/.config/nvim || exit 2
    git checkout --track "origin/$branch_name"
else
    echo "Neovim configuration already exists."
fi
