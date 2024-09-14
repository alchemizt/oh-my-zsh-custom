# Declare an associative array for environment variables
typeset -A env_var_list

# Populate the associative array
env_var_list=(
    "OMZ_CUSTOM" "~/.oh-my-zsh/custom:Custom Oh My Zsh folder:Environment"
    # Add more variables here if needed
)

# Function to list all variables with descriptions and categories
# and export them to the environment
show_variables() {
    for varname in ${(k)env_var_list}; do
        local entry="${env_var_list[$varname]}"
        local value="${entry%%:*}"
        local description_category="${entry#*:}"
        local description="${description_category%%:*}"
        local category="${description_category##*:}"

        # Export the variable into the environment
        export $varname="$value"
        
        # Display the details
        echo "Variable: $varname"
        echo "  Value: $value"
        echo "  Description: $description"
        echo "  Category: $category"
        echo ""
    done
}

# Call the function to display and export the variables
show_variables
