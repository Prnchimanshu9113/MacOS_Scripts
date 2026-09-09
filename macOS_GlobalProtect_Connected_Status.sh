#!/bin/bash

# GlobalProtect settings plist path
GP_PLIST="/Library/Preferences/com.paloaltonetworks.GlobalProtect.settings.plist"

# Get the default interface
defaultInterface=$(route get default 2>/dev/null | awk '/interface: / {print $2}')

# Get list of active interface IPs
interfaceIPs=$(/sbin/ifconfig -a -u inet | awk '/inet / {print $2}')

# Get VPN IPs from GP plist
vpnIPs=$(/usr/bin/defaults read "$GP_PLIST" 2>/dev/null | grep -F "PreferredIP_" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

# If default interface is VPN or any active IP matches a VPN IP, block install
for vpnIP in $vpnIPs; do
    if [[ "$defaultInterface" == utun* ]] || echo "$interfaceIPs" | grep -q "$vpnIP"; then
        echo "GlobalProtect is connected"
        exit 1  # Block install
    fi
done

echo "GlobalProtect is NOT connected"
exit 0  # Allow install
