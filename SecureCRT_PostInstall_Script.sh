#!/bin/sh
## postinstall

pathToScript=$0
pathToPackage=$1
targetLocation=$2
targetVolume=$3

loggedInUser=$(stat -f "%Su" /dev/console)
#loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

processor=$(system_profiler SPHardwareDataType | grep "Chip" | awk -F ": " '{print $2}')
#processor=$(sysctl -n machdep.cpu.brand_string)
if [[ $processor == *"Intel"* ]]; then
    mv /private/var/tmp/secure-intel/SecureCRT.app /Applications/
elif [[ $processor == *"Apple"* ]]; then
    mv /private/var/tmp/secure-m1/SecureCRT.app /Applications/
else
    echo "Unknown processor"
fi

: << 'Comment' arch=$(/usr/bin/arch)
if [ "$arch" == "arm64" ]; then
    mv /private/var/tmp/secure-m1/SecureCRT.app /Applications/
elif [ "$arch" == "i386" ]; then
    mv /private/var/tmp/secure-intel/SecureCRT.app /Applications/
else
    echo "Unknown Architecture"
fi
Comment

xattr -dr com.apple.quarantine /Applications/SecureCRT.app
open -a /Applications/SecureCRT.app

sleep 10

killall SecureCRT

mkdir /Users/$loggedInUser/Library/Application\ Support/VanDyke
mkdir /Users/$loggedInUser/Library/Application\ Support/VanDyke/SecureCRT
sudo cp -R /private/var/tmp/License /Users/$loggedInUser/Library/Application\ Support/VanDyke/SecureCRT/

rm -rf /private/var/tmp/secure-m1
rm -rf /private/var/tmp/License

exit 0       ## Success
exit 1       ## Failure
