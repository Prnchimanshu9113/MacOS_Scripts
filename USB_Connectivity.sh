#!/bin/bash

#checking USB connectivity

echo "Checking USB connectivity..."

# Get the list of connected USB devices
usb_devices=$(system_profiler SPUSBDataType)
if [[ -z "$usb_devices" ]]; then
    echo "No USB devices connected."
else
   echo "Connected USB devices:"
   echo "$usb_devices"
fi

