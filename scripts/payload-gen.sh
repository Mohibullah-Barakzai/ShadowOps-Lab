#!/bin/bash
# Phase 4 Adversarial Payload Generator (extended scaffold)
# Generates multiple reproducible payload variants for baseline verification

timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo "=== Phase 4 Payload Generator Run @ $timestamp ==="

# Variant 1: Plain test payload
echo "[Variant 1] Plain payload:"
echo "Phase4-Payload-Test"

# Variant 2: Base64 encoded
echo "[Variant 2] Base64 encoded:"
echo -n "Phase4-Payload-Test" | base64

# Variant 3: Hex encoded
echo "[Variant 3] Hex encoded:"
echo -n "Phase4-Payload-Test" | xxd -p

# Variant 4: Simple obfuscation (ROT13)
echo "[Variant 4] ROT13 obfuscated:"
echo "Phase4-Payload-Test" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
