#!/bin/bash
# Uninstall CrowdStrike Falcon
token="abcdef"
/Applications/Falcon.app/Contents/Resources/falconctl uninstall --maintenance-token <<< "${token}"
exit 0
