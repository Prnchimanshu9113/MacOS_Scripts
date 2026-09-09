#!/bin/bash

if system_profiler SPConfigurationProfileDataType | grep -qi 'allowUSBRestrictedMode = 1'; then
  echo 1
else
  echo 0
fi
