#!/bin/bash

pgrep oahd
errorCode=$?
if [[ "$errorCode" -ne "0" ]]; then
echo "<result>No</result>"
else
echo "<result>Yes</result>"
fi
