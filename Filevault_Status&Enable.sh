#!/bin/bash

# Check FileVault status
FV_STATUS=$(fdesetup status)

if [[ "$FV_STATUS" == *"FileVault is On"* ]]; then
    echo "FileVault is already enabled."
    exit 0
else
    echo "FileVault is not enabled. Enabling..."
    
    # Enable FileVault
    sudo fdesetup enable -user "$USER"
    
    # Check if it was enabled successfully
    if [[ $? -eq 0 ]]; then
        echo "FileVault enabled successfully."
    else
        echo "Failed to enable FileVault."
        exit 1
    fi
fi

exit 0
