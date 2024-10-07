#!/bin/bash

LOGFILE="$HOME/cpu_usage.log"

while true; do
    DATE=$(date +"%Y-%m-%d %H:%M:%S")
    CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}')
    echo "$DATE - CPU Usage: $CPU" >> "$LOGFILE"
    sleep 10
done
