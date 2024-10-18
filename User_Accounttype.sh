#!/bin/sh

user=$(whoami)

admin_status=$(dscl . -read /Groups/admin GroupMembership | grep -q "$user" && echo "Admin" || echo "Standard")

echo "<result>$admin_status</result>"
