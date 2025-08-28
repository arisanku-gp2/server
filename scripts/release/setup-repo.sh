#!/usr/bin/env bash
set -euo pipefail

# Configure merge options
gh repo edit --allow-merge-commit=false --allow-rebase-merge=true --allow-squash-merge=true

# Enable branch protection with linear history (requires admin token)
read -r owner repo <<<"$(gh repo view --json owner,name -q '.owner.login + " " + .name')"

gh api -X PUT repos/${owner}/${repo}/branches/main/protection --input - <<'JSON'
{
  "required_linear_history": true
}
JSON
