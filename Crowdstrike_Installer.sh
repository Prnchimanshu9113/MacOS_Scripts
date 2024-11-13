#!/bin/bash

# Define variables
PKG_PATH="/path/to/falcon-sensor.pkg"  # Replace with the actual path to the downloaded installer package
CID="YOUR_CUSTOMER_ID_HERE"            # Replace with your CrowdStrike Customer ID

# Check if the installer package exists
if [[ ! -f "$PKG_PATH" ]]; then
    echo "Installer package not found at $PKG_PATH. Exiting."
    exit 1
fi

# Install the CrowdStrike Falcon Sensor
echo "Installing CrowdStrike Falcon Sensor..."
sudo installer -pkg "$PKG_PATH" -target /

# Verify installation
if [[ $? -ne 0 ]]; then
    echo "Installation failed. Exiting."
    exit 1
fi

# Configure the Falcon Sensor with the Customer ID
echo "Configuring Falcon Sensor with Customer ID..."
sudo /Library/CS/falconctl license "$CID"

# Verify the license
if [[ $? -eq 0 ]]; then
    echo "CrowdStrike Falcon Sensor successfully installed and configured."
else
    echo "Failed to configure the Falcon Sensor with the Customer ID."
fi

exit 0
