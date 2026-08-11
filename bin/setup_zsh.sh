#!/bin/bash

echo "------------------------SETTING ZSH-------------------------"
# Set zsh as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    # install zsh if not installed
    ./bin/install.sh zsh
    # Change default shell to zsh
    echo "Setting zsh as the default shell..."
    sudo chsh -s "$(which zsh)"
else
    echo "zsh is already set as the default shell."
fi

stow zsh
