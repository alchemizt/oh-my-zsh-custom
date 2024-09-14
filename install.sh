#!/bin/zsh

# Define the linker file path
LINKER_FILE_PATH="$PWD/files/linker_file.sh"

# Check if .zshrc exists, if not create it
if [ ! -f "$HOME/.zshrc" ]; then
    touch "$HOME/.zshrc"
fi

# Add the linker file to .zshrc if it's not already present
if ! grep -q "$LINKER_FILE_PATH" "$HOME/.zshrc"; then
    echo "source $LINKER_FILE_PATH" >> "$HOME/.zshrc"
    echo "Linker file added to .zshrc"
else
    echo "Linker file already present in .zshrc"
fi
