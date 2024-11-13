#!/bin/bash

# Define applications to quit and remove
UNWANTED_APPS=("Microsoft Teams" "Microsoft OneNote" "Microsoft Outlook" "OneDrive")

# Attempt to quit and remove each application
for app in "${UNWANTED_APPS[@]}"; do
    APP_PATH="/Applications/$app.app"
    
    # Quit the application if it's running
    osascript -e "tell application \"$app\" to quit"
    
    # Check if the application exists before removing
    if [[ -d "$APP_PATH" ]]; then
        echo "Removing $app..."
        sudo rm -rf "$APP_PATH"
        echo "$app removed."
    else
        echo "$app not found."
    fi
done


# Define preference and license files, folders, and launch daemons to remove
paths=(
    "/Users/$3/Library/Preferences/com.microsoft.OneDriveStandaloneUpdater.plist"
    "/Users/$3/Library/Preferences/com.microsoft.OneDriveUpdater.plist"
    "/Users/$3/Library/Preferences/com.microsoft.Onedrive.plist"
    "/Users/$3/Library/Preferences/com.microsoft.Teams.plist"
    "/Users/$3/Library/Application Support/OneDrive/"
    "/Users/$3/Library/Application Support/Teams/"
    "/Library/LaunchDaemons/com.microsoft.OneDriveStandaloneUpdaterDaemon.plist"
    "/Library/LaunchDaemons/com.microsoft.OneDriveUpdaterDaemon.plist"
    "/Library/Launchagents/com.microsoft.OneDriveStandaloneUpdater.plist"
    "/Users/$3/Library/Preferences/com.microsoft.outlook.databasedaemon.plist"
    "/Users/$3/Library/Preferences/com.microsoft.outlook.office_reminders.plist"
    "/Users/$3/Library/Preferences/com.microsoft.Outlook.plist"
    "/Library/LaunchDaemons/com.microsoft.teams.TeamsUpdaterDaemon.plist"
    "/Library/Preferences/com.microsoft.teams.plist"
)

# Remove all specified files and folders
for path in "${paths[@]}"; do
    sudo rm -rf "$path"
done

exit 0
