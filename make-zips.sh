#!/usr/bin/env bash
# Rebuilds dist/100m-offers.zip and dist/100m-leads.zip for upload to claude.ai.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
mkdir -p dist
for s in 100m-offers 100m-leads; do
  rm -f "dist/$s.zip"
  (cd skills && zip -qr "../dist/$s.zip" "$s" -x "*.DS_Store")
  echo "built dist/$s.zip"
done
