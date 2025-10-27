# 🤖 AI-Adversarial Payload Generator

The AI-Adversarial Payload Generator is part of **Phase 2** of ShadowOps Lab.  
It explores next‑generation fuzzing and adversarial testing by generating **mutated payloads** that simulate adaptive attacker behavior.

---

## 📂 Module Structure
- `harness.sh` — main harness script; generates timestamped artifacts for each run  
- `artifacts/` — auto‑created per run, containing:
  - `run.log` — execution log with timestamp and payload generation details  
  - `payloads.txt` — randomized adversarial payloads (e.g., mutated HTTP headers)  

---

## 🖥️ Usage
From inside the module folder:

```bash
cd modules/ai-payloads
./harness.sh
