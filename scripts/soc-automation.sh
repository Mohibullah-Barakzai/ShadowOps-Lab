#!/bin/bash
# SOC Automation Enhancer — Phase 4
# Simulates triage and alert correlation routines

LOGFILE="artifacts/phase4/sample-alerts.log"
OUTPUT="artifacts/phase4/soc-automation-output.txt"

mkdir -p artifacts/phase4

# Step 1: Generate a sample alert log
cat > "$LOGFILE" <<EOF
[2025-10-27 20:45] ALERT: Suspicious login from 192.168.1.50
[2025-10-27 20:46] ALERT: Multiple failed SSH attempts from 10.0.0.23
[2025-10-27 20:47] ALERT: Outbound connection to known C2 domain
EOF

# Step 2: Parse and correlate alerts
echo "=== SOC Automation Enhancer Report ===" > "$OUTPUT"
grep "ALERT" "$LOGFILE" | while read -r line; do
    echo "Correlated Event: $line" >> "$OUTPUT"
done

echo "Report generated at $OUTPUT"
