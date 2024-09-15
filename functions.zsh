#!/bin/zsh

function findfast() {
    sudo find . -name "*$1*"
}

function findlogs() {
    sudo find / -type f -name "*.log"
}

function find_ssh_keys() {
    sudo find /home/$1/.ssh -type f -name "*.pub"
}

function acp() {
    git add .       
    git commit -m "$1"
    git push
}


find_webserver_logs() {
    local server_type="$1"  # First argument: nginx or apache
    local log_type="$2"     # Second argument: access or error

    # Define search paths for Apache and Nginx
    local apache_log_dir="/var/log/apache2"
    local nginx_log_dir="/var/log/nginx"
    local search_dir="/"

    # Check if both arguments are provided
    if [[ -z "$server_type" || -z "$log_type" ]]; then
        echo "Usage: find_webserver_logs <apache|nginx> <access|error>"
        return 1
    fi

    # Determine the log file name based on the log type
    case "$log_type" in
        access)
            log_file="access.log"
            ;;
        error)
            log_file="error.log"
            ;;
        *)
            echo "Invalid log type. Please choose 'access' or 'error'."
            return 1
            ;;
    esac

    # Search for Apache logs
    if [[ "$server_type" == "apache" ]]; then
        if [[ -d "$apache_log_dir" ]]; then
            echo "Searching for Apache $log_type logs in $apache_log_dir..."
            sudo find "$apache_log_dir" -type f -name "$log_file" | while read -r log_file; do
                echo "=== Last 10 lines of: $log_file ==="
                tail -n 10 "$log_file"
                echo ""
            done
        else
            echo "Apache log directory not found, searching entire system..."
            sudo find "$search_dir" -type f -name "$log_file" -path "*/apache2/*" 2>/dev/null | while read -r log_file; do
                echo "=== Last 10 lines of: $log_file ==="
                tail -n 10 "$log_file"
                echo ""
            done
        fi

    # Search for Nginx logs
    elif [[ "$server_type" == "nginx" ]]; then
        if [[ -d "$nginx_log_dir" ]]; then
            echo "Searching for Nginx $log_type logs in $nginx_log_dir..."
            find "$nginx_log_dir" -type f -name "$log_file" | while read -r log_file; do
                echo "=== Last 10 lines of: $log_file ==="
                tail -n 10 "$log_file"
                echo ""
            done
        else
            echo "Nginx log directory not found, searching entire system..."
            find "$search_dir" -type f -name "$log_file" -path "*/nginx/*" 2>/dev/null | while read -r log_file; do
                echo "=== Last 10 lines of: $log_file ==="
                tail -n 10 "$log_file"
                echo ""
            done
        fi
    else
        echo "Invalid server type. Please choose 'apache' or 'nginx'."
        return 1
    fi
}