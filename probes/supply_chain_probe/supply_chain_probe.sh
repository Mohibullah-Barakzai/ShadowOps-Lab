#!/bin/bash
# Supply Chain Probe – Dependency Integrity Check

log_file="logs/supply_chain_probe.log"
mkdir -p logs

echo "[Supply Chain Probe] Running dependency integrity check..." | tee "$log_file"
echo "timestamp: $(date -u)" | tee -a "$log_file"

# Simulated dependency file
dep_file="probes/supply_chain_probe/dependency.txt"
expected_hash="6cc86c2ad5190d36a8a627c61e5d058089871142da12d177bf9ffa65f6c6fd42"

if [[ ! -f "$dep_file" ]]; then
    echo "status: MISSING dependency file" | tee -a "$log_file"
    echo "summary: dependency file missing → severity: HIGH" | tee -a "$log_file"
    exit 1
fi

actual_hash=$(sha256sum "$dep_file" | awk '{print $1}')

if [[ "$actual_hash" == "$expected_hash" ]]; then
    echo "status: Dependency integrity verified" | tee -a "$log_file"
    echo "summary: dependency integrity OK → severity: LOW" | tee -a "$log_file"
else
    echo "status: Dependency hash mismatch" | tee -a "$log_file"
    echo "summary: dependency integrity FAILED → severity: HIGH" | tee -a "$log_file"
fi

