#!/bin/bash

# Create a temporary directory for the Slack installation files
mkdir /tmp/slackinstallation

# Download the Slack DMG file to the temporary directory
curl --location "https://slack.com/ssb/download-osx-universal" --output /tmp/slackinstallation/slack.dmg

# Mount the Slack DMG file without showing it in Finder (nobrowse) and in read-only mode
hdiutil attach /tmp/slackinstallation/slack.dmg -nobrowse -readonly

# Copy the Slack application from the mounted volume to the Applications directory
cp -R /Volumes/Slack/Slack.app /Applications/

# Unmount the Slack DMG volume forcefully to ensure it detaches
hdiutil detach /Volumes/Slack/ -force

# Remove the temporary directory and the downloaded DMG file to clean up
rm -rf /tmp/slackinstallation

