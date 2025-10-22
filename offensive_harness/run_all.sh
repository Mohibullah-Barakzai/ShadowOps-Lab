echo "[*] Launching IoT Probe..."
offensive_harness/probes/iot_probe/iot_probe.sh | tee -a logs/iot_probe.log
echo "[*] IoT Probe completed."

echo "[*] Launching Supply Chain Probe..."
offensive_harness/probes/supply_chain_probe/supply_chain_probe.sh | tee -a logs/supply_chain_probe.log
echo "[*] Supply Chain Probe completed."

echo "[*] Launching Insider Threat Probe..."
offensive_harness/probes/insider_threat_probe/insider_threat_probe.sh | tee -a logs/insider_threat_probe.log
echo "[*] Insider Threat Probe completed."
