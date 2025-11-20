#!/usr/bin/env zsh

# Check if Homebrew's bin exists and if it's not already in the PATH
# if [ -x "/opt/homebrew/bin/brew" ] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
#     export PATH="/opt/homebrew/bin:$PATH"
# fi

# Install VS Code Extensions
extensions=(
    ms-python.mypy-type-checker
    ms-python.python
    batisteo.vscode-django
    charliermarsh.ruff
    golang.go
    esbenp.prettier-vscode
    foxundermoon.shell-format
    mechatroner.rainbow-csv
    ms-toolsai.jupyter
    ms-azuretools.docker
    ms-azuretools.container-tools
    mtxr.sqltools
    mtxr.sqltools-driver-sqlite
    ritwickdey.liveServer
    tamasfe.even-better-toml
    teabyii.ayu
    arcticicestudio.nord
)

# Get a list of all currently installed extensions.
installed_extensions=$(codium --list-extensions)

for extension in "${extensions[@]}"; do
    if echo "$installed_extensions" | grep -qi "^$extension$"; then
        echo "$extension is already installed. Skipping..."
    else
        echo "Installing $extension..."
        codium --install-extension "$extension"
    fi
done

echo "VS Code extensions have been installed."

# Define the target directory for VS Code user settings on macOS
# VSCODE_USER_SETTINGS_DIR="${HOME}/Library/Application Support/Code/User"
VSCODE_USER_SETTINGS_DIR="${HOME}/.config/VSCodium/User"

# Check if VS Code settings directory exists
if [ -d "$VSCODE_USER_SETTINGS_DIR" ]; then
    # Copy your custom settings.json and keybindings.json to the VS Code settings directory
    ln -sf "${HOME}/dotfiles/vscode/VSCode-Settings.json" "${VSCODE_USER_SETTINGS_DIR}/settings.json"
    # ln -sf "${HOME}/dotfiles/settings/VSCode-Keybindings.json" "${VSCODE_USER_SETTINGS_DIR}/keybindings.json"

    echo "VS Code settings and keybindings have been updated."
else
    echo "VS Code user settings directory does not exist. Please ensure VS Code is installed."
fi

echo "VS Code Setup completed"
codium .
