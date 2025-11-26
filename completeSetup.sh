#!/bin/bash

options=(
    Yes
    No
)

ask(){
    resp=$(echo "$options" | fzf --prompt="$1 ")
    [ "$resp" = "Yes" ]
}

is_terminal=ask "Install and setup terminal?"
is_zsh=ask "Install and setup zsh?"
is_tmux=ask "Install and setup tmux?"
is_nvim=ask "Install and setup Neovim?"

echo "Installing dependencies..."
./bin/depandencies.sh

if is_terminal; then
    ./bin/setup_terminal.sh
fi

if is_zsh; then
    ./bin/setup_zsh.sh
fi

if is_tmux; then
    ./bin/setup_tmux.sh
fi

if is_nvim; then
    ./bin/install.sh neovim

    # Clone nvim config if not exists
    if [ ! -d "$HOME/.config/nvim" ]; then
        echo "Cloning Neovim Configuration..."
        git clone https://github.com/tehritarun/nvim_Config.git ~/.config/nvim
    else
        echo "Neovim configuration already exists."
    fi
fi
