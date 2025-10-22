echo "[*] Launching IoT Probe..."
offensive_harness/probes/iot_probe/iot_probe.sh | tee -a logs/iot_probe.log
echo "[*] IoT Probe completed."

echo "[*] Launching Supply Chain Probe..."
offensive_harness/probes/supply_chain_probe/supply_chain_probe.sh | tee -a logs/supply_chain_probe.log
echo "[*] Supply Chain Probe completed."

echo "[*] Launching Insider Threat Probe..."
offensive_harness/probes/insider_threat_probe/insider_threat_probe.sh | tee -a logs/insider_threat_probe.log
echo "[*] Insider Threat Probe completed."

echo "[*] Launching AI/ML Adversarial Probe..."
offensive_harness/probes/ai_adversarial_probe/ai_adversarial_probe.sh | tee -a logs/ai_adversarial_probe.log
echo "[*] AI/ML Adversarial Probe completed."

# --- Summary Aggregator ---
echo "[*] Aggregating probe summaries into summary.json..."

summary_file="logs/summary.json"
echo "{" > "$summary_file"

# Extract the last 'summary:' line from each probe log
for probe in iot_probe supply_chain_probe insider_threat_probe ai_adversarial_probe; do
    log_file="logs/${probe}.log"
    summary_line=$(grep "summary:" "$log_file" | tail -n 1 | sed 's/summary: //')
    echo "  \"${probe}\": \"${summary_line}\"," >> "$summary_file"
done

# Remove trailing comma and close JSON
sed -i '$ s/,$//' "$summary_file"
echo "}" >> "$summary_file"

echo "[*] Summary written to $summary_file"
