#!/bin/zsh

# Directory to search for .zsh files (you can change this path)
search_directory="$HOME/.oh-my-zsh/custom/files/oh-my-zsh-custom"

# Use globbing to find all .zsh files in the directory and loop through them
for file in "$search_directory"/*.zsh; do
    if [[ -f "$file" ]]; then
        echo "Sourcing $file..."
        source "$file"
    fi
done