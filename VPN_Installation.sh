#!/bin/bash

# Define VPN app and service names (adjust based on your VPN)
VPN_APP_NAME="MetaClient"  # Change this to your VPN app name if different
VPN_PROCESS_NAME="Openvpn"            # Adjust the process name if it's different

# Function to check if the VPN app is installed
check_vpn_installed() {
    echo "Checking if VPN application '$VPN_APP_NAME' is installed..."
    
    if [ -d "/Applications/$VPN_APP_NAME.app" ]; then
        echo "VPN application '$VPN_APP_NAME' is installed."
        return 0  # Installed
    else
        echo "VPN application '$VPN_APP_NAME' is NOT installed."
        return 1  # Not installed
    fi
}

# Function to check if the VPN process is running
check_vpn_running() {
    echo "Checking if VPN process '$VPN_PROCESS_NAME' is running..."
    
    if pgrep -i "$VPN_PROCESS_NAME" > /dev/null 2>&1; then
        echo "VPN process is running."
        return 0  # Running
    else
        echo "VPN process is NOT running."
        return 1  # Not running
    fi
}

# Function to check if VPN is connected (through the scutil command)
check_vpn_connected() {
    echo "Checking VPN connection status..."
    #scutil --nc list: This lists all network configurations including VPN #-E: Enables extended regular expressions (allowing | for "or")
    VPN_STATUS=$(scutil --nc list | grep -Ei "connected|enabled")  

    if [[ "$VPN_STATUS" =~ "connected" || "$VPN_STATUS" =~ "enabled" ]]; then
        echo "VPN is connected"
        return 0  # VPN is connected
    else
        echo "VPN is NOT connected"
        return 1  # VPN is not connected
    fi
}

# Main script logic
echo "Starting VPN check..."

# Step 1: Check if the VPN is installed
if check_vpn_installed; then
    # Step 2: If installed, check if it's running
    if check_vpn_running; then
        # Step 3: If running, check if VPN is connected
        if check_vpn_connected; then
            echo "VPN is installed, running, and connected."
        else
            echo "VPN is installed and running, but NOT connected."
        fi
    else
        echo "VPN is installed but NOT running."
    fi
else
    echo "VPN is NOT installed on this system."
fi

echo "VPN check completed."
