#!/usr/bin/env bash
# verify.sh — ShadowOps-Lab artifact verification script
# Ensures all required artifacts exist and match baseline checksums.

set -euo pipefail

pass=true

echo "=== ShadowOps-Lab Verification ==="

# Phase 1 checks
echo "Phase 1:"
if [[ -f artifacts/recon-output.txt ]]; then
  echo "  PASS (Recon output present)"
  sha256sum artifacts/recon-output.txt
else
  echo "  FAIL (Recon output missing)"
  pass=false
fi

if [[ -f artifacts/verification-log.txt ]]; then
  echo "  PASS (Verification log present)"
  sha256sum artifacts/verification-log.txt
else
  echo "  FAIL (Verification log missing)"
  pass=false
fi

# Phase 2 checks
echo "Phase 2:"
if [[ -f artifacts/git-status-proof.txt ]]; then
  echo "  PASS (Git status proof present)"
  sha256sum artifacts/git-status-proof.txt
else
  echo "  FAIL (Git status proof missing)"
  pass=false
fi

if [[ -f artifacts/payload-gen-output.txt ]]; then
  echo "  PASS (Payload Generator output present)"
  sha256sum artifacts/payload-gen-output.txt
else
  echo "  FAIL (Payload Generator output missing)"
  pass=false
fi

# Phase 3 checks
echo "Phase 3:"
if [[ -f soc-replay/reports/replay-proof.txt ]]; then
  echo "  PASS (SOC Replay Capsule present)"
  sha256sum soc-replay/reports/replay-proof.txt
else
  echo "  FAIL (SOC Replay Capsule missing)"
  pass=false
fi

if [[ -f artifacts/automation/auto-proof.txt ]]; then
  echo "  PASS (Automation Proof present)"
  sha256sum artifacts/automation/auto-proof.txt
else
  echo "  FAIL (Automation Proof missing)"
  pass=false
fi

if [[ -f artifacts/next-gen/nextgen-proof.txt ]]; then
  echo "  PASS (Next-Gen Module Placeholder present)"
  sha256sum artifacts/next-gen/nextgen-proof.txt
else
  echo "  FAIL (Next-Gen Module Placeholder missing)"
  pass=false
fi

# Phase 4 checks
echo "Phase 4:"
if [[ -f artifacts/phase4/payload-gen-output.txt ]] && [[ -f artifacts/phase4/soc-automation-output.txt ]]; then
  echo "  PASS (Phase 4 artifacts present)"
  sha256sum artifacts/phase4/payload-gen-output.txt
  sha256sum artifacts/phase4/soc-automation-output.txt
else
  echo "  IN PROGRESS (Phase 4 artifacts missing or incomplete)"
  pass=false
fi

# Recruiter Case Study (planned Phase 4 deliverable)
if [[ -f artifacts/recruiter-impact/case-study.md ]]; then
  echo "  PASS (Recruiter Case Study Artifact present)"
  sha256sum artifacts/recruiter-impact/case-study.md
else
  echo "  TODO (Recruiter Case Study Artifact not yet added)"
fi

echo
echo "=== Baseline Comparison ==="
if [[ -f artifacts/checksums.txt ]]; then
  sha256sum -c artifacts/checksums.txt || pass=false
else
  echo "No baseline checksums found — run './verify.sh --baseline' to generate."
fi

if [[ "${1:-}" == "--baseline" ]]; then
  echo "Generating clean baseline checksums..."
  find artifacts soc-replay -type f ! -name "checksums.txt" -exec sha256sum {} \; > artifacts/checksums.txt
  echo "Baseline written to artifacts/checksums.txt"
fi

echo
if $pass; then
  echo "=== Overall: PASS (all required artifacts present) ==="
else
  echo "=== Overall: FAIL (one or more artifacts missing or mismatched) ==="
  exit 1
fi
