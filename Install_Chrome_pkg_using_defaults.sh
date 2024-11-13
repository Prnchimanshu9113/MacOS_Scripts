#!/bin/bash

# Define variables
CHROME_URL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
CHROME_MOUNT_POINT="/Volumes/Google Chrome"
CHROME_APP_PATH="/Applications/Google Chrome.app"
PKG_NAME="GoogleChrome.pkg"
HOMEPAGE_URL="https://www.facebook.com"

# Step 1: Download Google Chrome DMG
echo "Downloading Google Chrome..."
curl -o /tmp/googlechrome.dmg "$CHROME_URL"

# Step 2: Mount the DMG
echo "Mounting the DMG..."
hdiutil mount /tmp/googlechrome.dmg

# Step 3: Copy Google Chrome to Applications
echo "Installing Google Chrome..."
cp -R "$CHROME_MOUNT_POINT/Google Chrome.app" "$CHROME_APP_PATH"

# Step 4: Unmount the DMG
echo "Unmounting the DMG..."
hdiutil unmount "$CHROME_MOUNT_POINT"

# Step 5: Create a package using pkgbuild
echo "Creating package..."
pkgbuild --root "$CHROME_APP_PATH" \
         --identifier "com.google.Chrome" \
         --version "1.0" \
         --install-location "/Applications" \
         "$PKG_NAME"

# Step 6: Install the package
echo "Installing the package..."
sudo installer -pkg "$PKG_NAME" -target /

# Step 7: Set Facebook as the homepage using defaults
echo "Setting Facebook as the homepage..."
defaults write com.google.Chrome Homepage "$HOMEPAGE_URL" # com.google.Chrome specifies that this command targets Chrome's settings (preference domain).Homepage is the specific preference being set.
defaults write com.google.Chrome NewTabPageOverride "$HOMEPAGE_URL" # NewTabPageOverride is the preference that determines which page loads when a new tab is opened.
defaults write com.google.Chrome NewTabPageOverrideEnabled -bool true # -bool true sets the value to true, enabling the override so that Chrome will use the URL set in NewTabPageOverride for new tabs.

# Clean up
echo "Cleaning up..."
rm /tmp/googlechrome.dmg
rm "$PKG_NAME"

echo "Google Chrome has been installed and Facebook has been set as the homepage."
