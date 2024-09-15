#!/bin/zsh
# Populate the associative array

hestiacp_alias_list=(
    "h-backup" "/usr/local/hestia/bin/v-backup-users:HestiaCP Backup:System"
    "h-restart" "/usr/local/hestia/bin/v-restart:HestiaCP Restart:System"
    "h-list" "/usr/local/hestia/bin/v-list-users:HestiaCP List Users:System"
    "h-info" "/usr/local/hestia/bin/v-list-sys-info:HestiaCP System Info:System"
    "h-log" "/usr/local/hestia/bin/v-list-log system:HestiaCP System Log:System"
    "h-add-domain" "/usr/local/hestia/bin/v-add-domain:HestiaCP Add Domain:System"
    "h-delete-domain" "/usr/local/hestia/bin/v-delete-domain:HestiaCP Delete Domain:System"
    "h-list-domains" "/usr/local/hestia/bin/v-list-web-domains:HestiaCP List Domains:System"
    "h-add-database" "/usr/local/hestia/bin/v-add-database:HestiaCP Add Database:System"
    "h-delete-database" "/usr/local/hestia/bin/v-delete-database:HestiaCP Delete Database:System"
)

# Concatenate the new alias list to the original alias list
alias_list+=("${hestiacp_alias_list[@]}")

