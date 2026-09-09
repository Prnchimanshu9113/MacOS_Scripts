#!/bin/bash

serial="$(ioreg -l | awk -F'"' '/IOPlatformSerialNumber/{print $4}')"

echo "Detected Serial Number: $serial"

response=$(curl -s -o /dev/null -w "%{http_code}" \
  --location "https://as177.awmdm.com/api/mdm/devices/commands/Lock/device/SerialNumber/${serial}" \
  --header 'aw-tenant-code: 9xCd90O1tF8/Xpam0DKQ2OnJMDoK1FAr0DNtnAPvZoo=' \
  --header 'Accept: application/json;version=2' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Basic V2luQWRtaW5BUEk6NXArciZbRytqQHh6d2x0cWdCIUQ=' \
  --data '{
    "workPasscode": true,
    "AllowPinAtStartup": true,
    "unlock_pin": 976347,
    "message": "Your computer has been locked because your Adobe account has been disabled. For assistance, contact sdesk@adobe.com"
  }')


echo "Response Code: $response"
echo "Lock command issued for Serial Number: $serial"

/usr/local/bin/hubcli sync

echo "Hubcli Sync Executed"
