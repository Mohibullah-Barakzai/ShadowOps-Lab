#!/bin/bash
# ShadowOps-Lab verification script
# Checks that each roadmap phase has its expected artifacts + SHA256 integrity

echo "=== ShadowOps-Lab Verification ==="

pass=true

# Phase 1 checks
echo -n "Phase 1: "
if [[ -f artifacts/recon-output.txt && -f artifacts/verification-log.txt ]]; then
  echo "PASS (recon-output.txt, verification-log.txt found)"
  sha256sum artifacts/recon-output.txt
  sha256sum artifacts/verification-log.txt
else
  echo "FAIL (missing Phase 1 artifacts)"
  pass=false
fi

# Phase 2 checks
echo -n "Phase 2: "
if [[ -f artifacts/git-status-proof.txt && -f artifacts/payload-gen-output.txt ]]; then
  echo "PASS (git-status-proof.txt, payload-gen-output.txt found)"
  sha256sum artifacts/git-status-proof.txt
  sha256sum artifacts/payload-gen-output.txt
else
  echo "FAIL (missing Phase 2 artifacts)"
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

# Phase 4 checks (planned only)
echo "Phase 4: PLANNED (no artifacts expected yet)"

# Baseline comparison
if [[ "$1" == "--baseline" ]]; then
  echo
  echo "Generating clean baseline checksums..."
  sha256sum artifacts/recon-output.txt \
          artifacts/verification-log.txt \
          artifacts/git-status-proof.txt \
          artifacts/payload-gen-output.txt \
          soc-replay/reports/replay-proof.txt \
          artifacts/automation/auto-proof.txt > artifacts/checksums.txt
  echo "Baseline written to artifacts/checksums.txt"
  exit 0
fi

if [[ -f artifacts/checksums.txt ]]; then
  echo
  echo "=== Baseline Comparison ==="
  sha256sum -c artifacts/checksums.txt --ignore-missing
else
  echo
  echo "No baseline checksums.txt found for comparison."
fi

# Final summary
if [ "$pass" = true ]; then
  echo "=== Overall: PASS (all required artifacts present) ==="
else
  echo "=== Overall: ATTENTION NEEDED (some artifacts missing) ==="
fi
