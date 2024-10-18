#!/bin/sh

user=$(whoami)
secure_token_status=$(sysadminctl -secureTokenStatus $user 2>&1 | grep "ENABLED" > /dev/null && echo "Enabled" || echo "Disabled")
echo "<result>$secure_token_status</result>"
