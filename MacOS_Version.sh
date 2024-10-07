#!/bin/bash

OsVer="`system_profiler SPSoftwareDataType | grep "System Version: " | sed 's/System Version: //'`"
echo "<result>$OsVer</result>"

macos_version=$(sw_vers -productVersion)
echo "<result>$macos_version</result>"
