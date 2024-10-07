#!/bin/bash

serial_number=$(system_profiler SPHardwareDataType | grep "Serial Number (system)" | awk '{print $4}')
echo "<result>$serial_number</result>"
