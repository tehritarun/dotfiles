#!/bin/bash

packages=(
    alacritty
    btop
    fd
    ghostty
    git
    git-delta
    kitty
    lazygit
    neovim
    node
    ripgrep
    ruff
    shellcheck
    starship
    tmux
    yazi
    zed
    zsh
)

# install depandencies
# ./bin/depandencies.sh

install_packages=()
copy_config=()
run_script=()

# TODO: ask user to select packages
for package in "${packages[@]}"; do
    # Add package to install list
    install_packages+=("$package")

    # if configuration present add to copy_config list
    if [[ -d "$package" ]]; then
        copy_config+=("$package")
    fi

    # if setup script present add to run_script array
    script_file="./bin/setup_$package.sh"
    if [[ -f "$script_file" ]]; then
        run_script+=("$script_file")
    fi
done

printf "\n\n\nInstall Package"
printf "\n%s" "${install_packages[@]}"
printf "\n\n\nCopy Config"
printf "\n%s" "${copy_config[@]}"
printf "\n\n\nRun Script"
printf "\n%s" "${run_script[@]}"
