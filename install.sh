#!/bin/zsh

export ALC_ZSH_DIR=$(pwd)
# Define the global installation directory
GLOBAL_DIR="/usr/local/alc_zsh"

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

# Download the repository
REPO_URL="https://github.com/yourusername/yourrepository/archive/refs/heads/main.zip"
TEMP_ZIP="/tmp/alc_zsh.zip"

if command -v wget &> /dev/null; then
    wget -O $TEMP_ZIP $REPO_URL
elif command -v curl &> /dev/null; then
    curl -L -o $TEMP_ZIP $REPO_URL
else
    echo "Error: wget or curl is required to download the repository."
    exit 1
fi

# Extract the repository to the global directory
mkdir -p $GLOBAL_DIR
unzip -o $TEMP_ZIP -d $GLOBAL_DIR
rm $TEMP_ZIP

# Move the extracted files to the global directory
mv $GLOBAL_DIR/yourrepository-main/* $GLOBAL_DIR
rm -rf $GLOBAL_DIR/yourrepository-main

# Define the linker file path
LINKER_FILE_PATH="$GLOBAL_DIR/files/linker.zsh"

# Function to update .zshrc
update_zshrc() {
    local ZSHRC_FILE=$1
    if [ ! -f "$ZSHRC_FILE" ]; then
        touch "$ZSHRC_FILE"
    fi
    if ! grep -q "source $LINKER_FILE_PATH" "$ZSHRC_FILE"; then
        echo "source $LINKER_FILE_PATH" >> "$ZSHRC_FILE"
    fi
}

# Update .zshrc for the root user
update_zshrc "/root/.zshrc"

# Update .zshrc for the local user
update_zshrc "$HOME/.zshrc"


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
