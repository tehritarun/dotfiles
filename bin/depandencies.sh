#!/bin/bash

required_dependencies=(
    fzf
    stow
    git
)

for dependency in "${required_dependencies[@]}"; do
    ./bin/install.sh "$dependency"
done
