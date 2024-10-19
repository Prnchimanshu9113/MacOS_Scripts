#!/bin/sh

#Insert the app name here, without the .app extension
appname="/Applications/Google Chrome.app"


#Get the string, cut the unneeded parts, print results
appvernum=`mdls -name kMDItemVersion "$appname" | sed 's/kMDItemVersion = "//' | sed 's/"//' `
echo "<result>$appvernum</result>"

appvers=$(system_profiler SPApplicationsDataType | awk -F': ' '/Google Chrome/ {getline; print $2}')
echo "<result>$appvers</result>"


#mdls -name kMDItemVersion "/Applications/Google Chrome.app" | sed 's/kMDItemVersion = "//' | sed 's/"//'
