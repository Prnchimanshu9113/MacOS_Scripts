#!/bin/bash

fv_status=$(fdesetup status | grep "FileVault is On")

if [ "$fv_status" != "" ]; then
    echo "<result>Enabled</result>"
else
    echo "<result>Disabled</result>"
fi
