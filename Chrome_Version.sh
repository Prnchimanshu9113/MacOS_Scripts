#!/bin/sh

#Insert the app name here, without the .app extension
appname="/Applications/Google Chrome.app"


#Get the string, cut the unneeded parts, print results
appvernum=`mdls -name kMDItemVersion "$appname" | sed 's/kMDItemVersion = "//' | sed 's/"//' `
echo "<result>$appvernum</result>"


#mdls -name kMDItemVersion "/Applications/Google Chrome.app" | sed 's/kMDItemVersion = "//' | sed 's/"//'
