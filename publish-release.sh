#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$ROOT_DIR"

GH_BIN=$(command -v gh || true)
if [[ -z "$GH_BIN" ]] && [[ -x "$HOME/.local/bin/gh" ]]; then
  GH_BIN="$HOME/.local/bin/gh"
fi

if [[ -z "$GH_BIN" ]]; then
  echo "GitHub CLI is not installed. Install gh and run 'gh auth login'." >&2
  exit 1
fi

./verify-release-assets.sh

"$GH_BIN" release create models-v1 \
  release-assets/mask_rcnn_general.h5 \
  release-assets/mask_rcnn_cytoplasm.h5 \
  release-assets/mask_rcnn_tissue_bluebrown.h5 \
  release-assets/mask_rcnn_tissue_pink.h5 \
  SHA256SUMS \
  --repo etasnadi/nucleaizer-models \
  --title "NucleAIzer models v1" \
  --notes "Immutable trained model weights used by both NucleAIzer deployments. Verify downloads against SHA256SUMS."
