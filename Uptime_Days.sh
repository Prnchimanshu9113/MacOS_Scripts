#!/bin/bash

uptimeDays=$(uptime | awk '{print $3}')

if [[ $uptimeDays -ge "30" ]];
then
        echo "$uptimeDays"
        echo "<result>30 days or more</result>"
else
        echo "$uptimeDays"
        echo "<result>Less than 30 days</result>"
fi
