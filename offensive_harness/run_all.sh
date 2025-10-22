echo "[*] Run Summary → ..."
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

# --- Markdown Summary Aggregator ---
summary_md="logs/summary.md"
echo "[*] Aggregating probe summaries into summary.md..."

{
  echo "# Probe Run Summary"
  echo
  echo "| Probe | Summary |"
  echo "|-------|---------|"
  for probe in iot_probe supply_chain_probe insider_threat_probe ai_adversarial_probe; do
      log_file="logs/${probe}.log"
      summary_line=$(grep "summary:" "$log_file" | tail -n 1 | sed 's/summary: //')
      echo "| ${probe} | ${summary_line} |"
  done
} > "$summary_md"

# --- Console One-Liner Summary with Icons ---
format_summary() {
    case "$1" in
        *"LOW"*) echo "🟢 $1" ;;
        *"MEDIUM"*) echo "🟡 $1" ;;
        *"HIGH"*) echo "🔴 $1" ;;
        *) echo "$1" ;;
    esac
}

iot_summary=$(grep 'summary:' logs/iot_probe.log | tail -n 1 | sed 's/summary: //')
supply_summary=$(grep 'summary:' logs/supply_chain_probe.log | tail -n 1 | sed 's/summary: //')
insider_summary=$(grep 'summary:' logs/insider_threat_probe.log | tail -n 1 | sed 's/summary: //')
ai_summary=$(grep 'summary:' logs/ai_adversarial_probe.log | tail -n 1 | sed 's/summary: //')

echo "[*] Run Summary → IoT: $(format_summary "$iot_summary") | SupplyChain: $(format_summary "$supply_summary") | Insider: $(format_summary "$insider_summary") | AI/ML: $(format_summary "$ai_summary")"
