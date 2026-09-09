#!/bin/bash

# Check FileVault enabled/disabled status
FV_STATUS=$(/usr/bin/fdesetup status)

if echo "$FV_STATUS" | /usr/bin/grep -q "FileVault is On"; then
    FV_ENABLED="Enabled"
else
    FV_ENABLED="Disabled"
fi

# Check for FileVault Personal Recovery Key escrow file
if [ -f "/var/db/FileVaultPRK.dat" ] ; then
   PRK_STATUS="Present"
else
   PRK_STATUS="Not Present"
fi

echo "FileVault: ${FV_ENABLED} | PRK: ${PRK_STATUS}"

# Description: Returns FileVault enabled/disabled status along with PRK escrow file presence
# Execution Context: SYSTEM
# Execution Architecture: UNKNOWN
# Return Type: STRING
