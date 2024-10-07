#!/bin/bash

gatekeeper_status=$(spctl --status)

if [[ $gatekeeper_status == *"assessments enabled"* ]]; then
    echo "<result>Enabled</result>"
else
    echo "<result>Disabled</result>"
fi
