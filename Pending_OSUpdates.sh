#!/bin/sh

# Get the list of available updates
updates=$(softwareupdate -l 2>&1)

# Check if any updates are listed as "pending"
if echo "$updates" | grep -q "restart"; then
    echo "Pending updates that require restart detected:"
    echo "$updates" | grep -i "restart"
    
    # Send an alert (You can customize this part with your preferred alert method)
    osascript -e 'display notification "Pending updates detected. A restart may be required." with title "Software Update Alert"'
else
    echo "No pending updates requiring restart found."
fi

# You can also add a log entry if needed
echo "$(date): Software update check completed." >> /var/log/update_check.log
