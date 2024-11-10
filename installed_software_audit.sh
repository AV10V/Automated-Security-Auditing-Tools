#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Get a list of installed packages
echo "Installed Software Audit:"
if command -v dpkg &> /dev/null; then
    # For Debian/Ubuntu-based systems
    dpkg -l | awk '{print $2, $3}' | column -t
elif command -v rpm &> /dev/null; then
    # For RHEL/CentOS-based systems
    rpm -qa | column -t
else
    echo "Unsupported package manager"
    exit 1
fi
