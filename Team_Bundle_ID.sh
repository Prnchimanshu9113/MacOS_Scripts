#!/bin/sh

# Path to the application (Change this to the desired app path)
app_path="/Applications/Google Chrome.app"

# Check if the application exists
if [ ! -d "$app_path" ]; then
    echo "Application not found at: $app_path"
    exit 1
fi

# Get the Bundle ID using mdls
bundle_id=$(mdls -name kMDItemCFBundleIdentifier $app_path)

# Get the Team ID using codesign
team_id=$(codesign -dv --verbose=4 "$app_path" 2>&1 | grep "TeamIdentifier" | awk '{print $NF}')

#Get Bundle and Team id at the same time using codesign
Bundle_Team_Id=$(codesign -dv --verbose=4 "$app_path" 2>&1 | grep "Identifier")

# Get the Code Signature details
code_signature=$(codesign -dr - "$app_path" 2>&1 )

# Output the results
echo "Application Path: $app_path"
echo "Bundle ID: $bundle_id"
echo "Team ID: $team_id"
echo "Bundle and Team ID : $Bundle_Team_Id"
echo "Code Signature: $code_signature"
