#!/usr/bin/env zsh

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed. Please install fzf first."
    exit 1
fi

# Present options to user using fzf
echo "Select your editor:"
selected=$(echo "VS-Code\nVS-Codium\nCursor" | fzf --prompt="Select editor: " --height=10 --border)

# Check if user made a selection
if [ -z "$selected" ]; then
    echo "No selection made. Exiting."
    exit 1
fi

# Set variables based on selection
case "$selected" in
    "VS-Code")
        cmd="code"
        folder_name="Code"
        ;;
    "VS-Codium")
        cmd="codium"
        folder_name="VSCodium"
        ;;
    "Cursor")
        cmd="cursor"
        folder_name="Cursor"
        ;;
    "Antigravity")
        cmd="antigravity"
        folder_name="Antigravity"
        ;;
    *)
        echo "Invalid selection: $selected"
        exit 1
        ;;
esac

# Display the selected values
echo "Selected: $selected"
echo "Command: $cmd"
echo "Folder name: $folder_name"
echo ""

# Call vs-code.sh with the selected parameters
"./vs-code.sh" "$cmd" "$folder_name"
