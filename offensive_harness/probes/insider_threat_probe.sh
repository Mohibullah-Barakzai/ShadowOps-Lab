#!/bin/bash
# Insider Threat Probe — v0.1
# Purpose: Detect weak accounts and sensitive files

LOGFILE="logs/insider_threat_probe.log"

echo "[Insider Threat Probe] Starting insider threat checks..." | tee "$LOGFILE"
timestamp=$(date)
echo "timestamp: $timestamp" | tee -a "$LOGFILE"

# 1. Check for accounts with no password (Linux /etc/shadow)
weak_accounts=$(awk -F: '($2==""){print $1}' /etc/shadow 2>/dev/null)

if [ -n "$weak_accounts" ]; then
    echo "status: Weak accounts found → $weak_accounts" | tee -a "$LOGFILE"
    echo "summary: weak accounts detected → severity: HIGH" | tee -a "$LOGFILE"
else
    echo "status: No weak accounts detected" | tee -a "$LOGFILE"
    echo "summary: no weak accounts → severity: LOW" | tee -a "$LOGFILE"
fi


# 2. Check for world-writable sensitive files
sensitive_files=("/etc/passwd" "/etc/shadow" "$HOME/.ssh/authorized_keys")
for f in "${sensitive_files[@]}"; do
    if [ -e "$f" ] && [ -w "$f" ]; then
        echo "status: World-writable sensitive file → $f" | tee -a "$LOGFILE"
        echo "summary: world-writable sensitive file detected → severity: HIGH" | tee -a "$LOGFILE"
        exit 0
    fi
done

echo "[Insider Threat Probe] Completed." | tee -a "$LOGFILE"
