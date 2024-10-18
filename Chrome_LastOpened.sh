#!/bin/sh

app_path="/Applications/Google\ Chrome.app"

app_last_opened_date=$(mdls $app_path | grep "kMDItemLastUsedDate " | grep -Eo "\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d") 
#mdls command prints the values of all the metadata attributes associated with the files provided as an argument.

echo "<result>$app_last_opened_date</result>"
