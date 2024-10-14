#!/bin/bash

bootstraptoken_status=$(sudo profiles status -type bootstraptoken | sed 's/profiles: //') #sudo profiles status -type bootstraptoken | awk '{sub(/^profiles: /, ""); print}'

bootstraptoken_key=$(diskutil apfs listcryptousers / | grep -B 1 "Type: MDM Bootstrap Token External Key" | sed -n '/Type: MDM Bootstrap Token External Key/!s/+-- //p')
#diskutil apfs listcryptousers / | awk '/MDM Bootstrap Token External Key/{print prev} {prev=$0}' | sed 's/+-- //'

bootstraptoken_full="${bootstraptoken_status}\nKey: ${bootstraptoken_key}"

echo -e "<result>$bootstraptoken_full</result>"

exit 0
