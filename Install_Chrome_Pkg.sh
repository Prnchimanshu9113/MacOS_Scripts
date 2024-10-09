#!/bin/bash

# Define variables
CHROME_URL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
CHROME_MOUNT_POINT="/Volumes/Google Chrome"
CHROME_APP_PATH="/Applications/Google Chrome.app"
PKG_NAME="GoogleChrome.pkg"
HOMEPAGE_URL="https://www.facebook.com"
PLIST_FILE="com.google.Chrome.plist"

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

# Step 5: Create a plist file for homepage settings
echo "Creating plist file for homepage settings..."
cat <<EOF > "/tmp/$PLIST_FILE"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Homepage</key>
    <string>$HOMEPAGE_URL</string>
    <key>NewTabPage</key>
    <string>$HOMEPAGE_URL</string>
</dict>
</plist>
EOF

# Step 6: Create a package using pkgbuild
echo "Creating package..."
pkgbuild --root "$CHROME_APP_PATH" \
         --identifier "com.google.Chrome" \
         --version "1.0" \
         --install-location "/Applications" \
         "$PKG_NAME"

# Step 7: Install the package
echo "Installing the package..."
sudo installer -pkg "$PKG_NAME" -target /

# Step 8: Set Facebook as the homepage
echo "Setting Facebook as the homepage..."
sudo cp "/tmp/$PLIST_FILE" "/Library/Preferences/com.google.Chrome.plist"

# Clean up
echo "Cleaning up..."
rm /tmp/googlechrome.dmg
rm "$PKG_NAME"
rm "/tmp/$PLIST_FILE"

echo "Google Chrome has been installed and Facebook has been set as the homepage."
