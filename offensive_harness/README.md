# Offensive Harness – Phase 2

This phase introduces a multi‑vector offensive harness with reproducible logging.  
Each probe is isolated, timestamped, and logs to its own file under `logs/`.

## Integrated Probes

- **IoT Probe**  
  - Path: `probes/iot_probe/iot_probe.sh`  
  - Log: `logs/iot_probe.log`  
  - Status: Stub (timestamp + OK)

- **Supply Chain Probe**  
  - Path: `probes/supply_chain_probe/supply_chain_probe.sh`  
  - Log: `logs/supply_chain_probe.log`  
  - Status: Stub (timestamp + OK)

- **Insider Threat Probe**  
  - Path: `probes/insider_threat_probe/insider_threat_probe.sh`  
  - Log: `logs/insider_threat_probe.log`  
  - Status: Stub (timestamp + OK)

- **AI/ML Adversarial Probe**  
  - Path: `probes/ai_adversarial_probe/ai_adversarial_probe.sh`  
  - Log: `logs/ai_adversarial_probe.log`  
  - Status: Stub (timestamp + OK)

## Harness Runner

The runner script orchestrates all probes in sequence:

```bash
bash offensive_harness/run_all.sh
