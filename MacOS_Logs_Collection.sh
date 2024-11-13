#!/bin/bash

# Variables
LOG_FILE="system_logs_$(date +%Y-%m-%d_%H-%M-%S).log"  # Log file with timestamp
PROCESS_NAME=""    # Specify the process name if needed (e.g., "Google Chrome")
EVENT_TYPE=""      # Specify the event type if needed (e.g., "error", "fault")
SUBSYSTEM=""       # Specify the subsystem if needed (e.g., "com.apple.network")

# Check if any argument is provided
if [[ -z "$PROCESS_NAME" && -z "$EVENT_TYPE" && -z "$SUBSYSTEM" ]]; then
    echo "Please specify at least one of PROCESS_NAME, EVENT_TYPE, or SUBSYSTEM in the script."
    exit 1
fi

# Start logging
echo "Collecting logs..."
echo "Logs for Process: $PROCESS_NAME, Event: $EVENT_TYPE, Subsystem: $SUBSYSTEM" > "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

# Construct log command based on specified filters
LOG_COMMAND="log show --style syslog --info --predicate '" # log show: This command retrieves logs in macOS with various options:
                                                           #--style syslog: Formats the output in syslog style.
                                                           #--info: Includes informational messages.
                                                           #--predicate: Filters logs based on the specified conditions.
if [[ -n "$PROCESS_NAME" ]]; then
    LOG_COMMAND+="process == \"$PROCESS_NAME\""
fi
if [[ -n "$EVENT_TYPE" ]]; then
    [[ -n "$PROCESS_NAME" ]] && LOG_COMMAND+=" && "
    LOG_COMMAND+="eventMessage contains \"$EVENT_TYPE\""
fi
if [[ -n "$SUBSYSTEM" ]]; then
    [[ -n "$PROCESS_NAME" || -n "$EVENT_TYPE" ]] && LOG_COMMAND+=" && "
    LOG_COMMAND+="subsystem == \"$SUBSYSTEM\""
fi
LOG_COMMAND+="'"

# Execute log command and save to file
eval "$LOG_COMMAND" >> "$LOG_FILE"

# Check if the log collection was successful
if [[ $? -eq 0 ]]; then
    echo "Logs saved to $LOG_FILE"
else
    echo "Failed to collect logs."
fi

exit 0
