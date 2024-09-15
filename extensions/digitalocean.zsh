#!/bin/zsh

# Declare an associative array for aliases
typeset -A alias_list

# Populate the associative array
alias_list=(
    "ll" "ls -la:List all files in long format:System"
    "gs" "git status:Show git status:Git"
    "ga" "git add .:Add all changes to git:Git"
    "gp" "git push:Push changes to remote repository:Git"
    "gc" "git commit -m:Commit changes with a message:Git"
    ".." "cd ..:Move up one directory:Navigation"
    "..." "cd ../..:Move up two directories:Navigation"
    # Digital Ocean Aliases
    "do_list_keys" "doctl compute ssh-key list:List SSH keys using doctl:doctl"
    "do_list_droplets" "doctl compute droplet list:List droplets using doctl:doctl"
    "list_droplets" "doctl compute droplet list | awk '{print \"\n\" \$1 \"\t\" \$3 \"\t\" \$2 }':List droplets in a cleaner way:doctl"
)

# Function to list all aliases with descriptions and categories
show_aliases() {
    for alias_name in ${(k)alias_list}; do
        local entry="${alias_list[$alias_name]}"
        local command="${entry%%:*}"
        local description_category="${entry#*:}"
        local description="${description_category%%:*}"
        local category="${description_category##*:}"
        
        echo "Alias: $alias_name"
        echo "  Command: $command"
        echo "  Description: $description"
        echo "  Category: $category"
        echo ""
    done
}

# Function to declare the aliases
declare_aliases() {
    for alias_name in ${(k)alias_list}; do
        local command="${alias_list[$alias_name]%%:*}"
        alias "$alias_name=$command"
    done
}

# Declare aliases
declare_aliases
