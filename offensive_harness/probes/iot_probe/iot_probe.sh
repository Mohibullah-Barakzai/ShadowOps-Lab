#!/bin/bash
# IoT Probe - Phase 2 Enriched with Summary
# Purpose: Simulate scanning for common IoT service ports and log findings

echo "[IoT Probe] Starting IoT service scan..."
echo "timestamp: $(date -u)"

ports=(23 2323 80 443 554 8080 8888)
open_count=0

for port in "${ports[@]}"; do
    if nc -z -w1 127.0.0.1 $port 2>/dev/null; then
        echo "port $port: OPEN"
        ((open_count++))
    else
        echo "port $port: CLOSED"
    fi
done

# Severity logic
if [ $open_count -eq 0 ]; then
    severity="LOW"
elif [ $open_count -le 2 ]; then
    severity="MEDIUM"
else
    severity="HIGH"
fi

echo "summary: $open_count/${#ports[@]} ports open → severity: $severity"
echo "status: Completed IoT probe scan"
