#!/bin/bash

echo "----------------------SETTING UP TMUX-----------------------"

./bin/install.sh tmux

stow tmux

# Clone TPM if it doesn't exist
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Cloning Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "Tmux Plugin Manager already installed."
fi

# Setup tmux sess
git clone https://github.com/tehritarun/tmux-sess.git "${HOME}/projects/tmux-sess"
mkdir -p ~/.config/tmux-sess
cp "${HOME}/projects/tmux-sess/layouts.json" "${HOME}/.config/tmux-sess/tmux-sess.json"
