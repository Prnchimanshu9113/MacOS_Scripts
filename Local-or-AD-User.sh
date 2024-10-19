#!/bin/sh

currentUser=$(stat -f "%Su" /dev/console)

# Output the result
echo "The current logged-in user is: $currentUser"


# Check if there is no logged-in user
if [ "$currentUser" == "LoginWindow" ] || [ -z "$currentUser" ]; then
    echo "No logged-in user."
    exit 1001
else
    # Check if the user is a local or domain (AD) user by checking OriginalNodeName
    if dscl . -read "/Users/$currentUser" OriginalNodeName 2>/dev/null | grep -q "No such key"; then
        accountType="Local User"
    else
        accountType="Domain User"
    fi
    
    # Output the result
    echo "$currentUser account type: $accountType"
fi
