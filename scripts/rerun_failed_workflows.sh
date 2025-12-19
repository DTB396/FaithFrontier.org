#!/usr/bin/env bash
set -euo pipefail

# Re-run failed workflow runs for the current repo.
# Usage:
#   bash scripts/rerun_failed_workflows.sh
# Optional:
#   REPO="owner/repo" bash scripts/rerun_failed_workflows.sh

REPO="${REPO:-}"
LIMIT="${LIMIT:-50}"   # number of recent runs to scan

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: GitHub CLI 'gh' not found. Install it, then run: gh auth login"
  exit 1
fi

if [[ -z "$REPO" ]]; then
  # infer owner/repo from git remote
  REMOTE_URL="$(git remote get-url origin 2>/dev/null || true)"
  if [[ -z "$REMOTE_URL" ]]; then
    echo "ERROR: Could not infer repo. Set REPO=owner/repo"
    exit 1
  fi
  # supports git@github.com:owner/repo.git or https://github.com/owner/repo.git
  REPO="$(echo "$REMOTE_URL" | sed -E 's#(git@github.com:|https://github.com/)([^/]+/[^/.]+)(\.git)?#\2#')"
fi

echo "Repo: $REPO"
echo "Scanning last $LIMIT runs for failures..."

# Get failed/cancelled/timed_out runs
RUN_IDS="$(gh run list -R "$REPO" --limit "$LIMIT" --json databaseId,conclusion,status \
  --jq '.[] | select((.conclusion=="failure") or (.conclusion=="cancelled") or (.conclusion=="timed_out")) | .databaseId')"

if [[ -z "$RUN_IDS" ]]; then
  echo "No failed/cancelled/timed_out runs found in last $LIMIT."
  exit 0
fi

echo "Found runs:"
echo "$RUN_IDS" | sed 's/^/  - /'

echo
echo "Re-running..."
while read -r id; do
  [[ -z "$id" ]] && continue
  echo "Re-run: $id"
  gh run rerun "$id" -R "$REPO" --failed || true
done <<< "$RUN_IDS"

echo "Done."
