#!/usr/bin/env python3
"""
Recon Harness - Deterministic Subdomain Enumeration Module
"""

import subprocess, os, hashlib, datetime, sys

def run_subenum(target):
    timestamp = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
    output_dir = f"outputs/{target}/{timestamp}"
    log_dir = f"logs/{target}"
    os.makedirs(output_dir, exist_ok=True)
    os.makedirs(log_dir, exist_ok=True)

    log_file = os.path.join(log_dir, "subenum.log")
    with open(log_file, "a") as log:
        log.write(f"[{timestamp}] Running subdomain enumeration for {target}\n")

    # Example: using assetfinder (replace with your preferred tool)
    result = subprocess.run(
        ["assetfinder", "--subs-only", target],
        capture_output=True, text=True
    )

    subdomains = sorted(set(result.stdout.splitlines()))
    output_file = os.path.join(output_dir, "subdomains.txt")
    with open(output_file, "w") as f:
        f.write("\n".join(subdomains))

    # Deterministic checksum
    sha256 = hashlib.sha256(open(output_file, "rb").read()).hexdigest()
    with open(os.path.join(output_dir, "subdomains.sha256"), "w") as f:
        f.write(f"{sha256}  subdomains.txt\n")

    return output_file, sha256
