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

selected_packages=$(printf '%s\n' "${packages[@]}" | fzf --prompt="Select terminals> " -m)

for package in ${selected_packages}; do
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

# TODO: check os and assign install cmd
install_cmd="./bin/install.sh"

for pkg in "${install_packages[@]}"; do
    echo "installing $pkg"
    # run install script with pkg
    $install_cmd "$pkg"
done

for pkg in "${copy_config[@]}"; do
    echo "copying config for $pkg using stow"
    # stow "$pkg"
done

printf "\n\n\nRun Script"
printf "\n%s" "${run_script[@]}"
for scr in "${run_script[@]}"; do
    echo "running script $scr"
    # $scr
done
