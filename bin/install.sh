#!/bin/bash

# Check if $1 is installed
if ! command -v $1 &> /dev/null; then
    echo "$1 is not installed. Installing..."
    sudo pacman -S --noconfirm $1
else
    echo "$1 is already installed."
fi