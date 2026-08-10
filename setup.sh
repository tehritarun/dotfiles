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
    go
    jq
    kitty
    lazygit
    neovim
    ripgrep
    ruff
    shellcheck
    starship
    tmux
    yazi
    zed
    zoxide
    zsh
)

echo "
------------------------------------------------------------
 Before running this script please make sure you have run
 system upgrade
 For arch based system:    sudo pacman -Syu
 For MacOS:                brew update && brew upgrade
------------------------------------------------------------
"

INSTALL_CMD=""

if command -v pacman &>/dev/null; then
    sudo pacman -Sy
    # install arch specific packages
    sudo pacman -S ttf-firacode-nerd tree-sitter-cli npm
    INSTALL_CMD="sudo pacman -S --noconfirm"
elif command -v brew &>/dev/null; then
    brew update
    brew install tree-sitter
    # install macos specific packages
    brew install --cask force font-fira-code-nerd-font node
    INSTALL_CMD="brew install"
fi

if [[ -z "$INSTALL_CMD" ]]; then
    echo "Error! No configured package manager found"
    exit 2
else
    echo "Detected Package Manager: $INSTALL_CMD"
fi

echo "------------------INSTALLING DEPANDENCIES-------------------"
cmd="$INSTALL_CMD ${main_depandencies[*]}"
echo "$cmd"
$cmd || (echo "Error: Failed to download depandencies" && exit 2)

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

install-individual-package() {
    for pkg in "${selected_packages[@]}"; do
        if ! command -v "$pkg" &>/dev/null; then
            echo "$pkg is not installed. Installing..."
            cmd="$INSTALL_CMD $pkg"
            $cmd
        else
            echo "$pkg is already installed."
        fi
    done
}

echo "--------------------INSTALLING PACKAGES---------------------"
echo "${install_packages[*]}"
cmd="$INSTALL_CMD ${install_packages[*]}"
echo "$cmd"
$cmd || (echo "Error: Failed to download packages. Trying individually" && install-individual-package)

echo "-----------------------COPYING CONFIG-----------------------"
printf " %s" "${copy_config[@]}"
for pkg in "${copy_config[@]}"; do
    echo "copying config for $pkg using stow"
    stow "$pkg"
done

echo "-------------------RUNNING SETUP SCRIPTS--------------------"
for scr in "${run_script[@]}"; do
    echo "running script $scr"
    $scr
done

echo "
------------------------------------------------------------
----------------AUTOMATED SET UP COMPLETED.-----------------

  To finish mannual setup please follow below setps in
  new terminal:
    1. run 'tmux' and then press ctrl+b then shift+i. Then
  allow it to install plugin in background. Once downloaded
  tmux appearence will automatically get updated.

    2. Run nvim and allow it to download plugins and lsp

    3. Reboot system so that change shell take effect
------------------------------------------------------------
"
