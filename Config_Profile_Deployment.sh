#!/bin/bash

PROFILE_ID="com.example.config"
TARGET_PROFILE=$(profiles -L | grep "$PROFILE_ID")

if [[ -z "$TARGET_PROFILE" ]]; then
    echo "Profile $PROFILE_ID is not installed."
    exit 1
else
    echo "Profile $PROFILE_ID is installed."
fi

# Check for conflicting profiles
CONFLICTS=$(profiles -C | grep "Conflict detected")

if [[ -z "$CONFLICTS" ]]; then
    echo "No conflicting profiles found."
else
    echo "Conflicting profiles detected."
    echo "$CONFLICTS"
    exit 1
fi

exit 0
