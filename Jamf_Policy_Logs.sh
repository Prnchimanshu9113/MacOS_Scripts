#!/bin/bash

POLICY_TRIGGER="install_software"
LOG_FILE="/var/log/jamf_policy_install.log"

# Trigger the policy
echo "Triggering Jamf policy: $POLICY_TRIGGER"
sudo jamf policy -event "$POLICY_TRIGGER" | tee -a "$LOG_FILE"

# Check if the policy was successful
if [[ $? -eq 0 ]]; then
    echo "Policy $POLICY_TRIGGER executed successfully."
else
    echo "Policy $POLICY_TRIGGER failed. Check log for details: $LOG_FILE"
    exit 1
fi

exit 0
