#!/bin/bash

main_depandencies=(
    fzf
    stow
    git
)

packages=(
    alacritty
    btop
    fd # Depandency for venv Selector
    ghostty
    git-delta # Depandency for lazygit diff view
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
    go
    jq
)

INSTALL_CMD=""

if command -v pacman &>/dev/null; then
    INSTALL_CMD="pacman -S --noconfirm"
elif command -v brew &>/dev/null; then
    INSTALL_CMD="brew install"
fi

if [[ -z "$INSTALL_CMD" ]]; then
    echo "Error! No configured package manager found"
    exit 2
else
    echo "Detected Package Manager: $INSTALL_CMD"
fi

echo "------------------INSTALLING DEPANDENCIES-------------------"
$INSTALL_CMD "${main_depandencies[*]}"

install_packages=()
copy_config=()
run_script=()

selected_packages=$(printf '%s\n' "${packages[@]}" | fzf --prompt="Select terminals> " -m)

if [ ${#selected_packages[@]} -eq 0 ]; then
    echo "No package selected"
    exit 0
fi

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

printf "--------------------INSTALLING PACKAGES---------------------"
echo "${install_packages[*]}"
$INSTALL_CMD "${install_packages[*]}"

printf "-----------------------COPYING CONFIG-----------------------"
printf " %s" "${copy_config[@]}"
for pkg in "${copy_config[@]}"; do
    echo "copying config for $pkg using stow"
    stow "$pkg"
done

printf "-------------------RUNNING SETUP SCRIPTS--------------------"
for scr in "${run_script[@]}"; do
    echo "running script $scr"
    $scr
done
