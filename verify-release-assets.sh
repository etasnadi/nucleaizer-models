#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$ROOT_DIR/release-assets"

if command -v sha256sum >/dev/null 2>&1; then
  sha256sum --check ../SHA256SUMS
elif command -v shasum >/dev/null 2>&1; then
  while read -r expected filename; do
    actual=$(shasum -a 256 "$filename" | awk '{print $1}')
    [[ "$actual" == "$expected" ]] || {
      echo "SHA-256 mismatch: $filename" >&2
      exit 1
    }
    echo "$filename: OK"
  done < ../SHA256SUMS
else
  echo "Neither sha256sum nor shasum is available." >&2
  exit 1
fi
