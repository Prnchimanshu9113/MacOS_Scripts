#!/bin/bash

# Read the current setting
hidden=$(defaults read com.apple.finder AppleShowAllFiles)

# Toggle the setting
if [ "$hidden" = "1" ]; then
    defaults write com.apple.finder AppleShowAllFiles -bool false
    echo "Hidden files are now hidden."
else
    defaults write com.apple.finder AppleShowAllFiles -bool true
    echo "Hidden files are now visible."
fi

# Restart Finder to apply changes
killall Finder
