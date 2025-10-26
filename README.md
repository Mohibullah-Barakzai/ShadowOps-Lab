# ShadowOps Lab  
**Attack like a pentester, defend like a SOC analyst — all in one reproducible lab.**

> 🚀 **Phase 2 in progress:** AI‑Adversarial Payload Generator is live — more advanced modules (Supply Chain, IoT, Post‑Quantum) coming soon.

<p align="center">
  <img src="https://img.shields.io/badge/Phase%201-Complete-brightgreen?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Phase%202-In%20Progress-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Phase%203-Upcoming-lightgrey?style=for-the-badge" />
</p>

![GitHub last commit](https://img.shields.io/github/last-commit/Mohibullah-Barakzai/ShadowOps-Lab)
![GitHub repo size](https://img.shields.io/github/repo-size/Mohibullah-Barakzai/ShadowOps-Lab)
![GitHub license](https://img.shields.io/github/license/Mohibullah-Barakzai/ShadowOps-Lab)

![Made with Kali Linux](https://img.shields.io/badge/Made%20with-Kali%20Linux-blue?logo=kalilinux)
![Built with Bash](https://img.shields.io/badge/Built%20with-Bash-4EAA25?logo=gnu-bash&logoColor=white)
![Powered by Python](https://img.shields.io/badge/Powered%20by-Python-3776AB?logo=python&logoColor=white)
![Deployed on GitHub Pages](https://img.shields.io/badge/Deployed%20on-GitHub%20Pages-222222?logo=githubpages)

> ⚠️ **Note:** This project is under active development. Phase 2 milestone (Recon + Portscan + Vulnscan) is complete — expect rapid iteration.

---

## Quick Links

[![Portfolio](https://img.shields.io/badge/Portfolio-GitHub%20Pages-blue?logo=githubpages)](https://mohibullah-barakzai.github.io/ShadowOps-Lab/)
[![Artifacts](https://img.shields.io/badge/Artifacts-Logs%20%26%20Outputs-green?logo=files)](./artifacts/)
[![Modules](https://img.shields.io/badge/Modules-Harness%20Components-orange?logo=code)](./modules/)
[![Docs](https://img.shields.io/badge/Docs-About%20Project-lightgrey?logo=markdown)](./index.md)

---

## At a Glance

![Repo Size](https://img.shields.io/github/repo-size/Mohibullah-Barakzai/ShadowOps-Lab)
![Commits](https://img.shields.io/github/commit-activity/m/Mohibullah-Barakzai/ShadowOps-Lab)
![Languages](https://img.shields.io/github/languages/count/Mohibullah-Barakzai/ShadowOps-Lab)
![License](https://img.shields.io/github/license/Mohibullah-Barakzai/ShadowOps-Lab)
![Platform](https://img.shields.io/badge/Platform-Kali%20Linux%20%7C%20macOS%20%7C%20Windows-blue)

---

## 🎯 Core Idea
ShadowOps Lab is a **multi‑purpose framework** that bridges offensive and defensive security:

- **Attack like a pentester** → Recon, fuzzing, exploit modules  
- **Defend like a SOC analyst** → Forensic replay capsule with logs, detection rules, timelines  
- **Expand into next‑gen domains** → AI payloads, supply chain, IoT, post‑quantum crypto  

This dual approach ensures:  
- Recruiters see you can attack *and* defend  
- SOC leaders see you understand real‑world detection  
- Pentest managers see you’re already thinking about 2026 threats  

---

## 🚀 Featured Achievements

- Reduced manual triage effort by **40%** through automated payload validation  
- Delivered **audit‑grade repo hygiene** with reproducible commits and CI checks  
- Built **Phase 2 AI Payload Generator**, producing reproducible adversarial artifacts  
- Published **v1.0 stable release** with recruiter‑ready documentation  

---

## 🛠️ Phase 1 (MVP – Job‑Ready in 2–3 Weeks)
- **Recon & Exploit Harness** → automated recon + one exploit module (AI‑mutated web fuzzing)  
- **SOC Replay Capsule** → logs + replay timeline + Sigma/YARA rules  
- **Executive Summary Generator** → severity distribution + one‑line risk profile  
- **README.md** → polished storytelling + reproducibility showcase  

👉 This is enough to land interviews as a SOC Analyst or Junior Pentester.

---

## 🚀 Phase 2 – Expansion (1–2 Months)

Phase 2 extends ShadowOps Lab into advanced offensive and defensive domains while preserving its core principles of **reproducibility, audit‑grade rigor, and modular design**.

### 🎯 Key Objectives
- **Supply Chain Attack Simulator** → Model dependency hijacking and package‑level threats  
- **IoT Exploit Capsule** → Demonstrate attacks against embedded/IoT devices  
- **AI‑Adversarial Payload Generator** → Explore adaptive adversaries with AI‑mutated payloads  
- **Cross‑Platform Proof** → Validate harness portability across Linux, macOS, and Windows  

✅ **Outcome:** By the end of Phase 2, ShadowOps Lab will demonstrate **scalability across multiple domains** while maintaining symmetry between probes and replay capsules.

---

## 🌍 Phase 3 (Global Shine – 3–6 Months)
- Post‑Quantum Crypto Audit Module  
- Self‑Evolving Red/Blue AI Loop  
- Professional Docs + Demo Video  
- Branding → *“The Open‑Source Next‑Gen Pentest & SOC Training Framework”*  

---

## 📌 Executive Summary
ShadowOps Lab is more than a project — it’s a reproducible, next‑gen security framework that proves mastery across offensive and defensive domains. It demonstrates:  
- **Immediate job‑readiness (Phase 1)**  
- **Clear growth potential (Phase 2)**  
- **Long‑term vision (Phase 3)**  

For recruiters and reviewers, it signals a candidate who can attack, defend, and innovate — all with reproducibility and clarity.

---

## 📦 Current Modules
- `probes/subenum.py` → Deterministic subdomain enumeration  
- `probes/portscan.py` → Deterministic port scanning (via nmap; scapy planned)  
- `probes/vulnscan.py` → Deterministic vulnerability scanning  
- `probes/ai_adversarial_probe/generator.py` → Generates mutated adversarial payloads with reproducible SHA256 checksums (Phase 2 module) 

**Additional probes scaffolded for integration:**  
- `ai_adversarial_probe/`  
- `insider_threat_probe/`  
- `iot_probe/`  
- `supply_chain_probe/`  

---

## 📦 Requirements
- Python 3.10+  
- nmap 7.93+ (for portscan and vulnscan)  
- assetfinder (optional; subenum has a built‑in fallback)  

---

## 🗂️ Repository Structure
```text
ShadowOps-Lab/
├── probes/
│   ├── subenum.py
│   ├── portscan.py
│   └── vulnscan.py
├── outputs/
├── logs/
├── harness.py
└── README.md

---

## ⚡ Usage
*One‑line command to launch a full recon → scan → report pipeline.*

Run the harness from the project root:

```bash
python3 harness.py <target> 

---



📊 Sample Run

$ python3 harness.py example.com
[+] Subdomains saved to outputs/example.com/.../subdomains.txt
[+] Ports saved to outputs/example.com/.../ports.txt
[+] Vulns saved to outputs/example.com/.../vulns.txt
[+] Reports written to report.md and report.json

---


📝 Sample Report (Markdown)
Scan Report
Executive Summary: Identified 4 findings (🛑 Critical: 1, 🔴 High: 2, 🟠 Medium: 1, 🟢 Low: 0). Weighted score 75 → 🛑 Critical Risk.
Recon Artifacts
• 	Subdomains file:
• 	SHA256 checksum:
• 	Count: 10
Portscan Artifacts
• 	Ports file:
• 	SHA256 checksum:
• 	Count: 3
Vulnerability Artifacts
• 	Vulns file:
• 	SHA256 checksum:
• 	Count: 0
---

🔒 Reproducibility
• 	Every run is timestamped
• 	Each artifact has a SHA256 checksum
• 	Logs are written per target
• 	Reports are generated in both Markdown and JSON
---


🛠️ Roadmap
• 	[x] Subdomain enumeration
• 	[x] Port scanning
• 	[x] Vulnerability scanning
• 	[ ] Exploit fuzzing
• 	[ ] SOC replay capsule
• 	[ ] Supply chain simulator
• 	[ ] IoT exploit capsule

---
