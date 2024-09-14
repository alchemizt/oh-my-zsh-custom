#!/bin/zsh

#  Digital Ocean Functions

# Fetch the list of droplets with the ID, Name, and Public IP fields
raw_data=$(doctl compute droplet list --format ID,Name,PublicIPv4 --no-header)

# Function to list droplets with ID, Name, and IP Address
droplist() {
    local droplet_name="$1"
    printf "ID\tName\tIP Address\n"  # Use printf instead of echo -e
    echo "$raw_data" | awk '{print $1 "\t" $2 "\t" $3}'  # Correct the column order
}

# Function to list all droplet names
droplet_list_names() {
    echo "$raw_data" | awk '{print $2}'
}

# Function to SSH into a droplet by name
do_connect() { 
    local droplet_name="$1"
    local droplet_ip=$(echo "$raw_data" | grep -w "$droplet_name" | awk '{print $3}')
    local username="${2:-root}"  # Set 'root' as the default username if no argument is provided

    if [ -n "$droplet_ip" ]; then
        echo "Connecting to $username @ $droplet_ip"
        ssh "$username@$droplet_ip"
    else
        echo "Droplet not found with the name: $droplet_name"
    fi
}

# Function to get the IP of a droplet by name
droplet_get_ip() {
    local droplet_name="$1"
    local droplet_ip=$(echo "$raw_data" | grep -w "$droplet_name" | awk '{print $3}')
    
    if [ -n "$droplet_ip" ]; then
        echo "$droplet_ip"
    else
        echo "No IP found for droplet: $droplet_name"
    fi
}

# Function to find a droplet by name and print its details
droplet_find_by_name() {
    local droplet_name="$1"
    local droplet_info=$(echo "$raw_data" | grep -w "$droplet_name")
    
    if [ -n "$droplet_info" ]; then
        echo "Droplet found: $droplet_info"
    else
        echo "No droplet found with the name: $droplet_name"
    fi
}

# Function to delete a droplet by ID, Name, or IP
droplet_delete() {
    local identifier="$1"
    local droplet_info=$(echo "$raw_data" | grep "$identifier")
    
    if [ -z "$droplet_info" ]; then
        echo "No droplet found with the identifier: $identifier"
        return 1
    fi
    
    local droplet_id=$(echo "$droplet_info" | awk '{print $1}')
    local droplet_name=$(echo "$droplet_info" | awk '{print $2}')
    local droplet_ip=$(echo "$droplet_info" | awk '{print $3}')

    echo "Deleting droplet with ID: $droplet_id (Name: $droplet_name, IP: $droplet_ip)..."
    
    # Run the doctl command to delete the droplet
    doctl compute droplet delete "$droplet_id" --force
    echo "Droplet $droplet_name deleted successfully."
}

# Usage examples:
# droplet_list_names           # Lists all droplet names
# droplet_ssh_to_name "name"   # SSH into a droplet by name
# droplet_find_by_name "name"  # Find a droplet by name
# droplet_get_ip "name"        # Get IP of a droplet by name
# droplet_delete "identifier"  # Delete droplet by name, ID, or IP
