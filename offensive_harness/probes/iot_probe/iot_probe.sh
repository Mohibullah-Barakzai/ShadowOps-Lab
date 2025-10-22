#!/bin/bash
# IoT Probe - Phase 2 Enriched
# Purpose: Simulate scanning for common IoT service ports and log findings

echo "[IoT Probe] Starting IoT service scan..."
echo "timestamp: $(date -u)"

# Define common IoT-related ports
ports=(23 2323 80 443 554 8080 8888)

# Simulate scanning localhost for these ports
for port in "${ports[@]}"; do
    if nc -z -w1 127.0.0.1 $port 2>/dev/null; then
        echo "port $port: OPEN"
    else
        echo "port $port: CLOSED"
    fi
done

echo "status: Completed IoT probe scan"
