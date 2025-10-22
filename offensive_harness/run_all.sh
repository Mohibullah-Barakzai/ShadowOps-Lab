echo "[*] Launching IoT Probe..."
offensive_harness/probes/iot_probe/iot_probe.sh | tee -a logs/iot_probe.log
echo "[*] IoT Probe completed."

echo "[*] Launching Supply Chain Probe..."
offensive_harness/probes/supply_chain_probe/supply_chain_probe.sh | tee -a logs/supply_chain_probe.log
echo "[*] Supply Chain Probe completed."
