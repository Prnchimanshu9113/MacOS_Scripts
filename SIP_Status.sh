#!/bin/bash

sip_status=$(csrutil status | grep "enabled")

if [ "$sip_status" != "" ]; then
    echo "<result>Enabled</result>"
else
    echo "<result>Disabled</result>"
fi
