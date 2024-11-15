#!/bin/bash

### Network Audit Script
### Author: AV10V
### Date: $(date)
### Description: A flexible network audit script for scanning open ports and saving results.
### Usage ./network_audit.sh -t 192.168.1.1 -p 80-443 -o output.txt

# Function to display usage instructions
usage() {
    echo "Usage: $0 [-t TARGET] [-p PORTS] [-o OUTPUT_FILE]"
    echo ""
    echo "Options:"
    echo "  -t TARGET        Specify the target IP or hostname (e.g., 192.168.1.1 or example.com)"
    echo "  -p PORTS         Specify the port range (e.g., 1-65535). Default is 1-65535."
    echo "  -o OUTPUT_FILE   Save the results to a specified file."
    echo "  -h               Display this help message."
    exit 1
}

# Default values
PORTS="1-65535"
OUTPUT_FILE=""
TARGET=""

# Parse command-line arguments
while getopts "t:p:o:h" opt; do
    case $opt in
        t) TARGET=$OPTARG ;;
        p) PORTS=$OPTARG ;;
        o) OUTPUT_FILE=$OPTARG ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Check if target is provided
if [[ -z $TARGET ]]; then
    echo "Error: Target (-t) is required."
    usage
fi

# Validate port range
if ! [[ $PORTS =~ ^[0-9]+-[0-9]+$ ]]; then
    echo "Error: Invalid port range format. Use the format 'start-end' (e.g., 1-1024)."
    exit 1
fi

# Perform network scan using netcat (or nmap if available)
echo "Starting network audit on target: $TARGET"
echo "Scanning ports: $PORTS"

if command -v nmap &> /dev/null; then
    echo "Using Nmap for scanning..."
    SCAN_RESULTS=$(nmap -p "$PORTS" "$TARGET")
else
    echo "Nmap not found. Using netcat for scanning..."
    SCAN_RESULTS=$(for port in $(seq $(echo $PORTS | cut -d'-' -f1) $(echo $PORTS | cut -d'-' -f2)); do
        (echo > /dev/tcp/$TARGET/$port) &> /dev/null && echo "Port $port is open" || echo "Port $port is closed"
    done)
fi

# Display results
echo "Scan Results:"
echo "$SCAN_RESULTS"

# Save results to file if specified
if [[ -n $OUTPUT_FILE ]]; then
    echo "$SCAN_RESULTS" > "$OUTPUT_FILE"
    echo "Results saved to $OUTPUT_FILE"
fi

echo "Network audit completed."
