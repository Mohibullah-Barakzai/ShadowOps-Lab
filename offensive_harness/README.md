# Offensive Harness – Phase 2

This phase introduces a multi‑vector offensive harness with reproducible logging.  
Each probe is isolated, timestamped, and logs to its own file under `logs/`.

## Integrated Probes

Each probe now produces:
- A UTC timestamp
- A status line
- A final `summary:` line for instant reviewer clarity

- **IoT Probe**  
  - Path: `probes/iot_probe/iot_probe.sh`  
  - Log: `logs/iot_probe.log`  
  - Behavior: Scans common IoT service ports (23, 2323, 80, 443, 554, 8080, 8888)  
  - Summary: Reports number of open ports and assigns severity (LOW / MEDIUM / HIGH)

- **Supply Chain Probe**  
  - Path: `probes/supply_chain_probe/supply_chain_probe.sh`  
  - Log: `logs/supply_chain_probe.log`  
  - Behavior: Stub execution  
  - Summary: `stub executed → severity: LOW`

- **Insider Threat Probe**  
  - Path: `probes/insider_threat_probe/insider_threat_probe.sh`  
  - Log: `logs/insider_threat_probe.log`  
  - Behavior: Stub execution  
  - Summary: `stub executed → severity: LOW`

- **AI/ML Adversarial Probe**  
  - Path: `probes/ai_adversarial_probe/ai_adversarial_probe.sh`  
  - Log: `logs/ai_adversarial_probe.log`  
  - Behavior: Stub execution  
  - Summary: `stub executed → severity: LOW`

## Harness Runner

The runner script orchestrates all probes in sequence:

```bash
bash offensive_harness/run_all.sh
