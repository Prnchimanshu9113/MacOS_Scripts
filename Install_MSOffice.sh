#!/bin/bash

# Define variables
OFFICE_INSTALLER_URL="https://go.microsoft.com/fwlink/?linkid=525135" # Direct link to Office installer
OFFICE_INSTALLER_PATH="/tmp/Microsoft_Office_Installer.pkg"
OFFICE_APP_PATH="/Applications/Microsoft Office"
LICENSE_FILE="/path/to/your/office_license_file.plist"  # Change to your license file path
LICENSE_KEY="YOUR_LICENSE_KEY"  # Replace with your actual license key

# Function to check for errors
function check_error {
    if [[ $? -ne 0 ]]; then
        echo "Error: $1"
        exit 1
    fi
}

# Step 1: Download Microsoft Office Installer
echo "Downloading Microsoft Office installer..."
curl -L -o "$OFFICE_INSTALLER_PATH" "$OFFICE_INSTALLER_URL"
check_error "Failed to download Microsoft Office installer."

# Step 2: Install Microsoft Office
echo "Installing Microsoft Office..."
sudo installer -pkg "$OFFICE_INSTALLER_PATH" -target /
check_error "Failed to install Microsoft Office."

# Step 3: Licensing Microsoft Office
echo "Licensing Microsoft Office..."
# Replace this with your method of applying the license. For example, using a plist file:
if [[ -f "$LICENSE_FILE" ]]; then
    echo "Applying license..."
    sudo cp "$LICENSE_FILE" "/Library/Preferences/com.microsoft.office.licensing.plist"
    check_error "Failed to apply licensing plist."
else
    echo "License file not found. Please ensure it is present at $LICENSE_FILE."
    exit 1
fi

# Create or modify the licensing plist file
# sudo /usr/bin/defaults write "$LICENSE_PLIST" "LicenseKey" "$LICENSE_KEY"
# check_error "Failed to apply licensing plist."

# Alternative: If you have a command-line tool for licensing, you might use:
# echo "Entering license key..."
# sudo /path/to/office_license_tool -k "$LICENSE_KEY"
# check_error "Failed to apply license key."

# Step 4: Clean up
echo "Cleaning up..."
rm "$OFFICE_INSTALLER_PATH"

echo "Microsoft Office has been installed and licensed successfully."
