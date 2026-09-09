#!/bin/bash
 
# Define the target version for comparison
target_version="6.3.3-1121"
 
# Function to convert version number to a comparable format
version() {
    echo "$1" | awk -F'[-.]' '{
        printf("%d%03d%03d%04d\n", $1, $2, $3, $4)
    }'
}
 
# Get the current installed version of GlobalProtect (if it exists)
installed_version=$(mdls -name kMDItemVersion /Applications/GlobalProtect.app 2>/dev/null | awk -F '"' '{print $2}')
 
# Compare installed version with the target version
if [[ -n "$installed_version" && $(version "$installed_version") -ge $(version "$target_version") ]]; then
    echo "GlobalProtect is already at the latest version ($installed_version). No action needed."
    exit 1  # Exit with 1 to indicate installation is NOT needed
else
    echo "GlobalProtect is not installed or the version ($installed_version) is outdated. Proceeding with installation."
    exit 0  # Exit with 0 to indicate installation/update is needed
fi
