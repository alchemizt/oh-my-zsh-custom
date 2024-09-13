# oh-my-zsh-custom
Custom files to be loaded by zsh

Add this file to the custom directory, and make it point to your git repo directory

#!/bin/zsh

# Directory to search for .zsh files (you can change this path)
search_directory="./zsh-custom/oh-my-zsh-custom"

# Use globbing to find all .zsh files in the directory and loop through them
for file in "$search_directory"/*.zsh; do
    if [[ -f "$file" ]]; then
        echo "Sourcing $file..."
        source "$file"
    fi