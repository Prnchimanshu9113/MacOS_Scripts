#!/bin/bash

# Define the list of unwanted Microsoft Office apps using array
apps_to_remove=(
    "Microsoft Teams.app"
    "OneDrive.app"
    "Microsoft Outlook.app"
)

# Quit each application in the list
for app in "${apps_to_remove[@]}"; do

     if pgrep -xq "$app.app"; then
        echo "Quitting $app..."
        osascript -e "tell application \"$app\" to quit"
        sleep 2  # Wait for the application to quit
    else
        echo "$app is not running."
    fi
done

# Loop through the list and remove each app if it exists
for app in "${apps_to_remove[@]}"; do
app_path="/Applications/$app.app"
    if [ -d "$app" ]; then
        echo "Removing $app..."
        sudo rm -rf "$app_path"
        echo "$app has been removed."
    else
        echo "$app not found."
    fi
done

echo "Cleanup complete!"
