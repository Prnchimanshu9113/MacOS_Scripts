#!/bin/bash

# Get the battery status using pmset command
battery_info=$(pmset -g batt)

# Extract the battery percentage
battery_percentage=$(echo "$battery_info" | grep -Eo "\d+%" | head -1)

# Extract charging/discharging status
charging_status=$(echo "$battery_info" | grep -i "discharging" || echo "charging")

# Extract remaining time
remaining_time=$(echo "$battery_info" | grep -Eo "[0-9]+:[0-9]+ remaining" | head -1)

# Display the battery information
echo "Battery percentage: $battery_percentage"
if [[ $charging_status == *"discharging"* ]]; then
    echo "Battery is discharging."
    echo "Remaining time: $remaining_time"
else
    echo "Battery is charging."
fi
