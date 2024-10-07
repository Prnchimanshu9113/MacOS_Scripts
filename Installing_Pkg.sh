#!/bin/bash

# Set the URL or the local path to the .pkg file
PKG_URL="https://example.com/path/to/your/package.pkg"
PKG_PATH="/tmp/package.pkg"

# Download the package (if needed)
echo "Downloading package..."
curl -L -o "$PKG_PATH" "$PKG_URL"

# Verify if the download was successful and install the package
if [[ -f "$PKG_PATH" ]]; then
    echo "Download completed. Installing package..."
    sudo installer -pkg "$PKG_PATH" -target /
    # Check if the installation was successful
    if [[ $? -eq 0 ]]; then
       echo "Package installed successfully!"
    else
       echo "Package installation failed."
       exit 1
    fi
else
    echo "Download failed.Package not Found. Exiting."
    exit 1
fi


# Post-installation: Clean up by removing the downloaded .pkg file
echo "Cleaning up..."
rm -f "$PKG_PATH"

exit 0
