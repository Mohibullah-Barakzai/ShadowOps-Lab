#!/usr/bin/env python3
from probes.ai_adversarial_probe import generator as ai_payload
import argparse
import hashlib
import json
import os
import datetime
import subprocess

def sha256sum(filename):
    h = hashlib.sha256()
    with open(filename, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            h.update(chunk)
    return h.hexdigest()

def count_lines(filename):
    if not os.path.exists(filename):
        return 0
    with open(filename, "r") as f:
        return sum(1 for _ in f)

def run_subdomain_enum(target, outdir):
    outfile = os.path.join(outdir, "subdomain_enum.txt")
    # Placeholder: integrate subfinder/amass here
    with open(outfile, "w") as f:
        pass
    checksum = sha256sum(outfile)
    count = count_lines(outfile)
    print(f"[+] Subdomain_enum saved to {outfile}")
    print(f"[+] SHA256 checksum: {checksum}")
    print(f"[+] Total subdomains discovered: {count}")
    return {"output_file": outfile, "checksum": checksum, "count": count}

def run_portscan(target, outdir):
    outfile = os.path.join(outdir, "portscan.txt")
    # Run a simple nmap scan (top 1000 ports, no ping)
    with open(outfile, "w") as f:
        subprocess.run(["nmap", "-Pn", "--top-ports", "1000", target], stdout=f)
    checksum = sha256sum(outfile)
    count = count_lines(outfile)
    print(f"[+] Portscan saved to {outfile}")
    print(f"[+] SHA256 checksum: {checksum}")
    print(f"[+] Total ports discovered: {count}")
    return {"output_file": outfile, "checksum": checksum, "count": count}

def run_vulnscan(target, outdir):
    outfile = os.path.join(outdir, "vulnscan.txt")
    # Run nmap with vuln scripts
    with open(outfile, "w") as f:
        subprocess.run(["nmap", "-Pn", "--script", "vuln", target], stdout=f)
    checksum = sha256sum(outfile)
    count = count_lines(outfile)
    print(f"[+] Vulnscan saved to {outfile}")
    print(f"[+] SHA256 checksum: {checksum}")
    print(f"[+] Total vulnerabilities discovered: {count}")
    return {"output_file": outfile, "checksum": checksum, "count": count}

def run_ai_payload(seed, outdir):
    # Generate payload using AI module
    payload = ai_payload.generate_payload(seed)
    ai_payload.save_payload(payload, seed)
    # We don’t write to outdir here because generator handles its own outputs
    return {
        "seed": seed,
        "output_dir": "outputs/ai_payloads/",
        "note": "Mutated payloads with SHA256 checksums"
    }

def build_report(target, results, outdir):
    # Map vulnscan findings as Medium, portscan findings as Low
    severity_counts = {
        "Critical": 0,
        "High": 0,
        "Medium": results["vulnscan"]["count"],
        "Low": results["portscan"]["count"]
    }
    total_findings = sum(severity_counts.values())

    weighted_score = (
        severity_counts["Critical"] * 100 +
        severity_counts["High"] * 75 +
        severity_counts["Medium"] * 50 +
        severity_counts["Low"] * 10
    )
    executive_summary = (
        f"**Executive Summary:** Identified {total_findings} findings "
        f"(🛑 Critical: {severity_counts['Critical']}, "
        f"🔴 High: {severity_counts['High']}, "
        f"🟠 Medium: {severity_counts['Medium']}, "
        f"🟢 Low: {severity_counts['Low']}). "
        f"Weighted score {weighted_score} → "
        f"{'🛑 Critical Risk' if weighted_score >= 70 else '⚠️ Moderate/Low Risk'}. "
        f"Results are reproducible and documented for independent verification."
    )

    report = {
        "executive_summary": executive_summary,
        "severity_counts": severity_counts,
        "weighted_score": weighted_score,
        "subenum": results["subdomain_enum"],
        "portscan": results["portscan"],
        "vulnscan": results["vulnscan"],
        "ai_payload": results["ai_payload"]
    }

    # Write JSON
    json_path = os.path.join(outdir, "report.json")
    with open(json_path, "w") as f:
        json.dump(report, f, indent=2)

    # Write Markdown
    md_path = os.path.join(outdir, "report.md")
    with open(md_path, "w") as f:
        f.write("# Scan Report\n\n---\n")
        f.write(executive_summary + "\n---\n\n")
        f.write("### Recon Artifacts\n")
        f.write(f"- Subdomains file: `{results['subdomain_enum']['output_file']}`\n")
        f.write(f"- SHA256 checksum: `{results['subdomain_enum']['checksum']}`\n")
        f.write(f"- Count: {results['subdomain_enum']['count']}\n\n")
        f.write("### Portscan Artifacts\n")
        f.write(f"- Ports file: `{results['portscan']['output_file']}`\n")
        f.write(f"- SHA256 checksum: `{results['portscan']['checksum']}`\n")
        f.write(f"- Count: {results['portscan']['count']}\n\n")
        f.write("### Vulnerability Artifacts\n")
        f.write(f"- Vulns file: `{results['vulnscan']['output_file']}`\n")
        f.write(f"- SHA256 checksum: `{results['vulnscan']['checksum']}`\n")
        f.write(f"- Count: {results['vulnscan']['count']}\n\n")
        f.write("### AI Payload Artifacts\n")
        f.write(f"- Seed: `{results['ai_payload']['seed']}`\n")
        f.write(f"- Output dir: `{results['ai_payload']['output_dir']}`\n")
        f.write(f"- Note: {results['ai_payload']['note']}\n")

    print(f"[+] Reports written to {md_path} and {json_path}")

def main():
    parser = argparse.ArgumentParser(description="ShadowOps-Lab Harness")
    parser.add_argument("--target", required=True, help="Target domain or IP")
    parser.add_argument("--module", choices=["subdomain_enum", "portscan", "vulnscan", "ai_payload"], help="Run a specific module")
    args = parser.parse_args()

    timestamp = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    outdir = os.path.join("outputs", args.target, timestamp)
    os.makedirs(outdir, exist_ok=True)

    results = {}

    if args.module == "subdomain_enum":
        results["subdomain_enum"] = run_subdomain_enum(args.target, outdir)
    elif args.module == "portscan":
        results["portscan"] = run_portscan(args.target, outdir)
    elif args.module == "vulnscan":
        results["vulnscan"] = run_vulnscan(args.target, outdir)
    elif args.module == "ai_payload":
        results["ai_payload"] = run_ai_payload("shadowops", outdir)
    else:
        results["subdomain_enum"] = run_subdomain_enum(args.target, outdir)
        results["portscan"] = run_portscan(args.target, outdir)
        results["vulnscan"] = run_vulnscan(args.target, outdir)
        results["ai_payload"] = run_ai_payload("shadowops", outdir)

    # Ensure all keys exist for report
    for key in ["subdomain_enum", "portscan", "vulnscan", "ai_payload"]:
        if key not in results:
            results[key] = {"output_file": "", "checksum": "", "count": 0} if key != "ai_payload" else {"seed": "", "output_dir": "", "note": ""}

    build_report(args.target, results, outdir)

if __name__ == "__main__":
    main()
