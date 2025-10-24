# ShadowOps Lab
**Multi‑Purpose Next‑Gen Penetration Testing & SOC Training Framework**

![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-blue)
![Status](https://img.shields.io/badge/Status-In_Progress-yellow)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

> ShadowOps Lab is a reproducible, next‑gen security framework that trains you to **attack like a pentester and defend like a SOC analyst** — all in one lab.  
> ⚠️ **Note:** This project is under active development. Phase 2 milestone (Recon + Portscan + Vulnscan) is complete — expect rapid iteration.

---

## 🎯 Core Idea
ShadowOps Lab is designed as a **multi‑purpose framework** that bridges offensive and defensive security:

- **Attack like a pentester** → Recon, fuzzing, exploit modules.  
- **Defend like a SOC analyst** → Forensic replay capsule with logs, detection rules, timelines.  
- **Expand into next‑gen domains** → AI payloads, supply chain, IoT, post‑quantum crypto.  

This dual approach ensures:  
- Recruiters see you can attack *and* defend.  
- SOC leaders see you understand real‑world detection.  
- Pentest managers see you’re already thinking about 2026 threats.  

---

## 🛠️ Phase 1 (MVP – Job‑Ready in 2–3 Weeks)
- **Recon & Exploit Harness** → automated recon + one exploit module (AI‑mutated web fuzzing).  
- **SOC Replay Capsule** → logs + replay timeline + Sigma/YARA rules.  
- **Executive Summary Generator** → severity distribution + one‑line risk profile.  
- **README.md** → polished storytelling + reproducibility showcase.  

👉 This is enough to land interviews as a SOC Analyst or Junior Pentester.  

---

## 🚀 Phase 2 – Expansion (1–2 Months)
Phase 2 expands ShadowOps Lab into new offensive and defensive domains while preserving the reproducibility and audit‑friendly rigor established in Phase 1.  

### Key Objectives
- **Supply Chain Attack Simulator**  
- **IoT Exploit Capsule**  
- **AI‑Adversarial Payload Generator**  
- **Cross‑Platform Proof**  

✅ *By the end of Phase 2, the harness demonstrates scalability across multiple domains while maintaining symmetry between probes and replay capsules.*  

---

## 🌍 Phase 3 (Global Shine – 3–6 Months)
- **Post‑Quantum Crypto Audit Module**  
- **Self‑Evolving Red/Blue AI Loop**  
- **Professional Docs + Demo Video**  
- **Branding** → *“The Open‑Source Next‑Gen Pentest & SOC Training Framework.”*  

---

## 📌 Executive Summary
ShadowOps Lab is more than a project — it’s a reproducible, next‑gen security framework that proves mastery across offensive and defensive domains.  
It demonstrates immediate job‑readiness (Phase 1), clear growth potential (Phase 2), and long‑term vision (Phase 3).  
For recruiters and reviewers, it signals a candidate who can **attack, defend, and innovate** — all with reproducibility and clarity.  

---

## 📦 Current Modules
- `probes/subenum.py` → Deterministic subdomain enumeration (via `assetfinder` or fallback list).  
- `probes/portscan.py` → Deterministic port scanning with checksums and logs.  
- `probes/vulnscan.py` → Deterministic vulnerability scanning (via `nmap --script vuln` or fallback).  

Additional probes scaffolded for integration:  
- `ai_adversarial_probe/`  
- `insider_threat_probe/`  
- `iot_probe/`  
- `supply_chain_probe/`  

---

## ⚡ Usage
Run the harness from the project root:

```bash
python3 harness.py <target>
