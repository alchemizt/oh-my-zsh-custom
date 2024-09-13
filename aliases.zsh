#!/bin/zsh

# Enable associative arrays in Zsh
typeset -A alias_list

# Define the associative array
alias_list=(
    "ll" "ls -la:List all files in long format:System"
    "gs" "git status:Show git status:Git"
    "ga" "git add .:Add all changes to git:Git"
    "gp" "git push:Push changes to remote repository:Git"
    "gc" "git commit -m:Commit changes with a message:Git"
    ".." "cd ..:Move up one directory:Navigation"
    "..." "cd ../..:Move up two directories:Navigation"
    "do_list_keys" "doctl compute ssh-key list:List SSH keys using doctl:doctl"
    "do_list_droplets" "doctl compute droplet list:List droplets using doctl:doctl"
)

# Function to print colored headings
print_heading() {
    echo "\033[1;34m$1\033[0m"
    echo "\033[1;34m==================\033[0m"
}

# Function to show aliases, grouped by category
show_aliases() {
    local categories=()
    local sorted_aliases=()

    # Extract categories
    for alias in ${(k)alias_list}; do
        category="${alias_list[$alias]##*:}"
        if [[ ! " ${categories[@]} " =~ " ${category} " ]]; then
            categories+=("$category")
        fi
    done

    # Show aliases for each category
    for category in "${categories[@]}"; do
        print_heading "$category Aliases"
        for alias in ${(k)alias_list}; do
            if [[ "${alias_list[$alias]##*:}" == "$category" ]]; then
                # Extract command and description
                command="${alias_list[$alias]%%:*}"
                description="${alias_list[$alias]#*:}"
                description="${description%:*}"
                # Pretty print the alias
                echo -e "\033[1;32m$alias\033[0m: \033[0;36m$command\033[0m - $description"
            fi
        done
        echo ""
    done
}

# Function to declare the aliases
declare_aliases() {
    echo "Declaring aliases..."
    for alias in ${(k)alias_list}; do
        command="${alias_list[$alias]%%:*}"
        eval "alias $alias='$command'"
    done
    echo "Aliases declared!"
}

# Usage examples:
# To show the list of aliases grouped by category:
# show_aliases

declare_aliases
