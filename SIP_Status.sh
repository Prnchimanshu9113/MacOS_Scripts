#!/bin/bash

sip_status=$(csrutil status | grep "enabled")

if [ "$sip_status" != "" ]; then
    echo "<result>Enabled</result>"
else
    echo "<result>Disabled</result>"
fi

<<'EOF'
SIP (System Integrity Protection) is a security technology that restricts the root (superuser) account's access to certain system files and directories, even if you have administrator privileges. 
It prevents the root user (or any other user) from modifying protected areas of the macOS operating system, including:

/System
/usr (except /usr/local)
/bin
/sbin
Apps pre-installed by Apple (like Safari) are also protected by SIP.
EOF
