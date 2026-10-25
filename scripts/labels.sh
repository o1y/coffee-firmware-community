#!/usr/bin/env bash
# Run before the first issue: a form silently skips labels that don't exist yet.
# Safe to re-run.
set -euo pipefail
repo="${1:?usage: scripts/labels.sh <owner/repo>}"

label() { gh label create "$1" --repo "$repo" --color "$2" --description "$3" --force; }

label "bug"     "d73a4a" "Bug report form"
label "shot"    "a2662f" "Shot problem form"
label "install" "0075ca" "Installation or update problem form"

# Must match the bug form's Area options, lowercased.
for area in "brewing" "steam" "hot water" "heating up" "water & tank" "scale" \
            "wi-fi" "screen & touch" "sleep & auto-off" "other"; do
  label "area: $area" "c5def5" "From the bug form's Area field"
done

label "needs-info"        "fbca04" "Waiting for the reporter"
label "confirmed"         "5319e7" "Reproduced or understood"
label "fixed"             "0e8a16" "Fixed in a release; the closing comment names it"
label "original-firmware" "bfdadc" "About the original firmware, not this one"

# Defaults that don't fit an issues-only repo.
for l in "good first issue" "help wanted" "enhancement" "question" "documentation"; do
  gh label delete "$l" --repo "$repo" --yes 2>/dev/null || true
done
