#!/bin/zsh

export ALC_ZSH_DIR=$(pwd)

echo "ALC_ZSH_DIR=$ALC_ZSH_DIR" >> ~/.zshrc

# Function to detect if Zsh is installed
zsh_setup() {
    apt update && sudo apt dist-upgrade -y
    apt install build-essential curl file git -y
    apt install git-core curl fonts-powerline -y
    apt install zsh -y
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "plugins=(python pip composer doctl dotenv)" >> ~/.zshrc
}


# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    zsh_setup -y
fi


# Define the linker file path
LINKER_FILE_PATH="$PWD/files/linker.zsh"

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
