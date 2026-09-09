#!/bin/bash
# Uninstall CrowdStrike Falcon
token="abcdef"
/Applications/Falcon.app/Contents/Resources/falconctl uninstall --maintenance-token <<< "${token}"
exit 0


#!/bin/zsh
#This script has been designed for the ES Team to be run by WS1. 
#This script should not be distributed to end users for any purpose as it contains a live API Key.
######################################################
#Insert the API Client ID and Secret Here:
     clientid='8a59e14108ef4cf7a063a2a5a417a0ac'
     clientsecret='F6BsnV94wuZ3yWP8MCi5Y7RNq1dU20LXGxSvkbjH'
######################################################
 
ERROR=0
if [[ -f "/Applications/Falcon.app/Contents/Resources/falconctl" ]]; then
   aid=$(sudo /Applications/Falcon.app/Contents/Resources/falconctl stats | grep agentID | cut -d " " -f2 | tr -d '-')
   sleep 10
   bearer=$(curl -X POST "https://api.us-2.crowdstrike.com/oauth2/token" -H "Content-Type: application/x-www-form-urlencoded" -d "client_id=${clientid}&client_secret=${clientsecret}" | grep "access" | sed -r 's/^[^:]*:(.*)$/\1/' | tr -d '",')
   token=$(curl -X POST "https://api.us-2.crowdstrike.com/policy/combined/reveal-uninstall-token/v1" -H  "accept: application/json" -H  "authorization: Bearer${bearer}" -H  "Content-Type: application/json" -d "{  \"audit_message\": \"ES Uninstall Script\",  \"device_id\": \"${aid}\"}" | grep "token" | sed -r 's/^[^:]*:(.*)$/\1/' | tr -d '", ')
    echo $token 
     sudo /Applications/Falcon.app/Contents/Resources/falconctl uninstall --maintenance-token <<< "${token}"
    echo "Falcon has been uninstalled"
else
    echo "Falcon sensor app not found"
    ERROR=1
fi
exit $ERROR
