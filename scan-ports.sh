#!/bin/bash

if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: scan-ports.sh <ip> <output>"
    exit 0
fi

echo "Discovering TCP ports..."
nmap -T4 -p- "$1" -oN "$2"
ports=$(cat "$2" | grep / | grep open | awk -F/ '{print $1}' | tr '\n' ',')
ports=${ports::-1}
echo
echo
echo "Running full scan on discovered TCP ports $ports... "
echo
echo
nmap -T4 -A -p$ports "$1" -oN "$2"
echo
echo
echo "Scans complete. Results saved to: $2"
