#!/bin/bash

required_dependencies=(
    fzf
    stow
    git
    jq
)

for dependency in "${required_dependencies[@]}"; do
    ./bin/install.sh "$dependency"
done
