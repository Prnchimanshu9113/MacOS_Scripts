#!/bin/bash

# Get the UDID
UDID=$(ioreg -d2 -c IOPlatformExpertDevice | awk -F\" '/IOPlatformUUID/{print $(NF-1)}' | tr -d '-')

# Check for the presence of the cert
expiry_date=$(security find-certificate -c "$UDID:ZEN" -p 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | awk -F= '/notAfter/ {print $2}')

# Check if the cert is present
if [ -n "$expiry_date" ]; then
    expirydate=$(date -jf "%b %e %T %Y %Z" "$expiry_date" "+%m/%d/%Y")
    echo "$expirydate"
else
    echo "NoZEN"
fi
