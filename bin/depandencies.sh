#!/bin/bash

required_dependencies=(
    fzf
    stow
    git
)

for dependency in "${required_dependencies[@]}"; do
    ./install.sh "$dependency"
done
