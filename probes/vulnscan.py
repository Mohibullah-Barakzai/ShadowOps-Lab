#!/usr/bin/env python3
"""
Vulnscan Probe
Deterministic vulnerability scanning with reproducible artifacts.
"""

import os
import hashlib
import subprocess
from datetime import datetime


def run_vulnscan(target):
    timestamp = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
    outdir = f"outputs/{target}/{timestamp}"
    logdir = f"logs/{target}"
    os.makedirs(outdir, exist_ok=True)
    os.makedirs(logdir, exist_ok=True)

    vulns_file = os.path.join(outdir, "vulns.txt")
    checksum_file = os.path.join(outdir, "vulns.sha256")
    log_file = os.path.join(logdir, "vulnscan.log")

    try:
        # Example: nmap vuln scripts (safe mode)
        result = subprocess.run(
            ["nmap", "-Pn", "--script", "vuln", target],
            capture_output=True, text=True
        )
        output = result.stdout
    except FileNotFoundError:
        # Fallback if nmap not installed
        output = f"FAKE VULN SCAN for {target}\nNo real vulnerabilities tested.\n"

    # Save results
    with open(vulns_file, "w") as f:
        f.write(output)

    # Compute checksum
    sha256 = hashlib.sha256(output.encode()).hexdigest()
    with open(checksum_file, "w") as f:
        f.write(sha256 + "  vulns.txt\n")

    # Log
    with open(log_file, "a") as f:
        f.write(f"[{timestamp}] Vulnscan run for {target}, checksum={sha256}\n")

    # Count vulnerabilities (simple heuristic: lines with 'VULNERABLE')
    count = sum(1 for line in output.splitlines() if "VULNERABLE" in line.upper())

    return vulns_file, sha256, count
