#!/usr/bin/env python3
"""
ShadowOps-Lab Harness
Audit‑grade, reproducible workflow for penetration testing and SOC analysis.
Modules:
- probes/subenum.py
- probes/portscan.py
- probes/vulnscan.py
"""

import sys
import json
from collections import Counter, OrderedDict
from probes import subenum
from probes import portscan
from probes import vulnscan


def generate_report(findings, subenum_meta, portscan_meta, vulnscan_meta):
    """Generate both Markdown and JSON style reports from findings + module metadata."""
    severity_counts = Counter([f["severity"] for f in findings])
    weighted_score = (
        severity_counts["Critical"] * 100
        + severity_counts["High"] * 75
        + severity_counts["Medium"] * 50
        + severity_counts["Low"] * 25
    ) // max(len(findings), 1)

    summary = (
        f"**Executive Summary:** Identified {len(findings)} findings "
        f"(🛑 Critical: {severity_counts.get('Critical',0)}, "
        f"🔴 High: {severity_counts.get('High',0)}, "
        f"🟠 Medium: {severity_counts.get('Medium',0)}, "
        f"🟢 Low: {severity_counts.get('Low',0)}). "
        f"Weighted score {weighted_score} → "
        f"{'🛑 Critical Risk' if weighted_score>=75 else '⚠️ Medium Risk' if weighted_score>=25 else '🟢 Low Risk'}. "
        "Results are reproducible and documented for independent verification."
    )

    # Markdown report
    md_report = (
        f"# Scan Report\n\n---\n{summary}\n---\n\n"
        f"### Recon Artifacts\n"
        f"- Subdomains file: `{subenum_meta['output_file']}`\n"
        f"- SHA256 checksum: `{subenum_meta['checksum']}`\n"
        f"- Count: {subenum_meta['count']}\n\n"
        f"### Portscan Artifacts\n"
        f"- Ports file: `{portscan_meta['output_file']}`\n"
        f"- SHA256 checksum: `{portscan_meta['checksum']}`\n"
        f"- Count: {portscan_meta['count']}\n\n"
        f"### Vulnerability Artifacts\n"
        f"- Vulns file: `{vulnscan_meta['output_file']}`\n"
        f"- SHA256 checksum: `{vulnscan_meta['checksum']}`\n"
        f"- Count: {vulnscan_meta['count']}\n"
    )

    # JSON report
    json_report = OrderedDict({
        "executive_summary": summary,
        "severity_counts": severity_counts,
        "weighted_score": weighted_score,
        "subenum": subenum_meta,
        "portscan": portscan_meta,
        "vulnscan": vulnscan_meta,
    })

    return md_report, json_report


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 harness.py <target>")
        sys.exit(1)

    target = sys.argv[1]

    # === Run deterministic subdomain enumeration ===
    output_file, checksum = subenum.run_subenum(target)
    with open(output_file, "r") as f:
        subdomains = [line.strip() for line in f if line.strip()]

    subenum_meta = {
        "output_file": output_file,
        "checksum": checksum,
        "count": len(subdomains),
    }

    print(f"[+] Subdomains saved to {output_file}")
    print(f"[+] SHA256 checksum: {checksum}")
    print(f"[+] Total subdomains discovered: {len(subdomains)}")

    # === Run portscan ===
    ports_file, ports_checksum, ports_count = portscan.run_portscan(target)

    portscan_meta = {
        "output_file": ports_file,
        "checksum": ports_checksum,
        "count": ports_count,
    }

    print(f"[+] Ports saved to {ports_file}")
    print(f"[+] SHA256 checksum: {ports_checksum}")
    print(f"[+] Total open ports discovered: {ports_count}")

    # === Run vulnscan ===
    vulns_file, vulns_checksum, vulns_count = vulnscan.run_vulnscan(target)

    vulnscan_meta = {
        "output_file": vulns_file,
        "checksum": vulns_checksum,
        "count": vulns_count,
    }

    print(f"[+] Vulns saved to {vulns_file}")
    print(f"[+] SHA256 checksum: {vulns_checksum}")
    print(f"[+] Total vulnerabilities discovered: {vulns_count}")

    # === Example findings (placeholder until modules feed real data) ===
    findings = [
        {"id": 1, "severity": "Critical"},
        {"id": 2, "severity": "High"},
        {"id": 3, "severity": "High"},
        {"id": 4, "severity": "Medium"},
    ]

    # Generate reports
    md_report, json_report = generate_report(findings, subenum_meta, portscan_meta, vulnscan_meta)

    # Print previews
    print("\nMarkdown preview:\n", md_report)
    print("\nJSON preview:\n", json_report)

    # Save reports to files
    with open("report.md", "w") as f:
        f.write(md_report)
    with open("report.json", "w") as f:
        json.dump(json_report, f, indent=2, default=str)

    print("\n[+] Reports written to report.md and report.json")
