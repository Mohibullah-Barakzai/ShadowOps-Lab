#!/bin/bash
# SOC Replay Capsule v0.2
# Purpose: Replay logs, apply detection rules, and export timeline with severity icons

echo "[SOC Replay] Starting forensic replay..."
timestamp=$(date)
echo "timestamp: $timestamp"

logfile="soc_replay/logs/auth.log"
rulefile="soc_replay/rules/ssh_bruteforce.yml"

# Count failed + success logins
failed=$(grep "Failed password" "$logfile" | wc -l)
success=$(grep "Accepted password" "$logfile" | wc -l)

if [ "$failed" -ge 3 ] && [ "$success" -ge 1 ]; then
    echo "ALERT: SSH brute force detected → severity: HIGH"
    compromise="true"
else
    echo "No brute force pattern detected → severity: LOW"
    compromise="false"
fi

# --- Timeline Export with Severity Icons ---
timeline="soc_replay/timelines/ssh_timeline.csv"
echo "timestamp,event,severity" > "$timeline"

# Failed logins → always MEDIUM
grep "Failed password" "$logfile" | awk '{print $1" "$2" "$3",Failed SSH login,🟡 MEDIUM"}' >> "$timeline"

# Successful login → HIGH if preceded by brute force, otherwise LOW
if [ "$compromise" = "true" ]; then
    grep "Accepted password" "$logfile" | awk '{print $1" "$2" "$3",Successful SSH login,🔴 HIGH"}' >> "$timeline"
else
    grep "Accepted password" "$logfile" | awk '{print $1" "$2" "$3",Successful SSH login,🟢 LOW"}' >> "$timeline"
fi

echo "[SOC Replay] Timeline written to $timeline"
echo "[SOC Replay] Completed."
