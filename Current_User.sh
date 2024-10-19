#!/bin/sh

# Get the current logged-in user
current_user=$(stat -f%Su /dev/console)

# Output the result
echo "The current logged-in user is: $current_user"
