#!/bin/bash

# Define available terminals
terminals="kitty
alacritty
ghostty"

# Prompt user to select terminals using fzf (multi-select enabled)
selected_terminals=$(echo "$terminals" | fzf --prompt="Select terminals> " -m)

# Check if any terminal was selected
if [ -z "$selected_terminals" ]; then
    echo "No terminal selected."
    exit 0
fi

# Loop through selected terminals
echo "$selected_terminals" | while read -r terminal; do
    if [ -n "$terminal" ]; then
        echo "Setting up $terminal..."
        
        # Install the terminal
        ./bin/install.sh "$terminal"
        
        # Stow the configuration
        # Assuming the config folder is in the parent directory (../)
        # cd ..
        stow $terminal
        # cd -
        
        echo "$terminal setup complete."
    fi
done
