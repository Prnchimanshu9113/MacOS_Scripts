#!/bin/bash

# Check if the Find My Mac preference exists
if [[ -f /Library/Preferences/com.apple.FindMyMac.plist ]]; then
  # Read the FMMEnabled value
  FMM_STATUS=$(defaults read /Library/Preferences/com.apple.FindMyMac FMMEnabled 2>/dev/null)

  # Convert 0 to 'false' and 1 to 'true'
  if [[ "$FMM_STATUS" == "1" ]]; then
    echo "<result>Enabled</result>"
  else
    echo "<result>Disabled</result>"
  fi
else
  echo "<result>Not Available</result>"
fi


