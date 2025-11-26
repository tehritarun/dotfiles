#!/bin/bash

# Check if zsh is installed
./bin/install.sh zsh

# Set zsh as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as the default shell..."
    chsh -s "$(which zsh)"
else
    echo "zsh is already set as the default shell."
fi

# cd ..
stow zsh
# cd -
