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


#!/bin/bash

# Extract the uptime details
uptimeOutput=$(uptime)

# Check if uptime includes "days" (meaning the system has been up for more than 24 hours)
if [[ "$uptimeOutput" == *"days"* ]]; then
    # Extract the number of days
    uptimeDays=$(echo "$uptimeOutput" | awk '{print $3}')
    # Extract the hours and minutes
    uptimeHours=$(echo "$uptimeOutput" | awk '{print $5}' | cut -d: -f1)
    uptimeMinutes=$(echo "$uptimeOutput" | awk '{print $5}' | cut -d: -f2)
    
    # Calculate total uptime in minutes
    totalMinutes=$((uptimeDays * 1440 + uptimeHours * 60 + uptimeMinutes))
else
    # Extract the hours and minutes for uptime less than a day
    uptimeHours=$(echo "$uptimeOutput" | awk '{print $3}' | cut -d: -f1)
    uptimeMinutes=$(echo "$uptimeOutput" | awk '{print $3}' | cut -d: -f2)
    
    # Calculate total uptime in minutes
    totalMinutes=$((uptimeHours * 60 + uptimeMinutes))
fi

# Output the total uptime in minutes
echo "Uptime in minutes: $totalMinutes"

# Check if the uptime is 30 days or more
if [[ $totalMinutes -ge 43200 ]]; then
    echo "<result>30 days or more</result>"
else
    echo "<result>Less than 30 days</result>"
fi

