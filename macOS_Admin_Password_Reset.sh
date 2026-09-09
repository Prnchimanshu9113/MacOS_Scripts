#!/bin/bash

# Variables
new_admin="CEAdmin"
current_admin=$(stat -f %Su /dev/console)
serial="$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c -6 | rev)"
new_password="$serial""Cyb3rE@@3n1ial"

echo "Current admin: " $current_admin
echo "New Password: " $new_password

# Reset CEAdmin password
sudo dscl . -passwd /Users/CEAdmin currentpassword $new_password

# Create new admin account
# sudo sysadminctl -addUser $new_admin -fullName "CEAdmin" -password $new_password
# sudo dscl . -append /Groups/admin GroupMembership $new_admin

# Convert current admin to standard user
# sudo /usr/sbin/dseditgroup -o edit -n /Local/Default -d $current_admin -t "user" "admin"

# echo "New admin account '$new_admin' created and current admin '$current_admin' converted to standard user."
