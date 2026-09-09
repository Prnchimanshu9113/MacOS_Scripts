#!/bin/bash

plistBuddy='/usr/libexec/PlistBuddy'
GPplistFile='/Library/Preferences/com.paloaltonetworks.GlobalProtect.settings.plist'

${plistBuddy} -c "print : 'Palo Alto Networks':'GlobalProtect':'PanSetup':'Portal'" ${GPplistFile}
${plistBuddy} -c "add :'Palo Alto Networks' dict" ${GPplistFile}
${plistBuddy} -c "add :'Palo Alto Networks':'GlobalProtect' dict" ${GPplistFile}
${plistBuddy} -c "add :'Palo Alto Networks':'GlobalProtect':'PanSetup' dict" ${GPplistFile}
${plistBuddy} -c "add :'Palo Alto Networks':'GlobalProtect':'PanSetup':'Portal' string 'vpn.adobe.com'" ${GPplistFile}
#defaults write /Library/Preferences/com.paloaltonetworks.GlobalProtect.client.plist PanPortalList -array lehi.vpn.adobe.com dublin.vpn.adobe.com bangalore.vpn.adobe.com
pkill -9 GlobalProtect

pangpa_plist="/Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist"
pangps_plist="/Library/LaunchAgents/com.paloaltonetworks.gp.pangps.plist"

sudo chmod 644 $pangpa_plist
sudo chmod 644 $pangps_plist

sudo chown $UID $pangpa_plist
sudo chown $UID $pangps_plist

sudo defaults write "$pangpa_plist" RunAtLoad -bool false 
sudo defaults write "$pangpa_plist" KeepAlive -bool false
sudo defaults write "$pangps_plist" RunAtLoad -bool false

exit 0
