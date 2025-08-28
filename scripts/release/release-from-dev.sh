#!/usr/bin/env bash
set -euo pipefail

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Working tree is dirty." >&2
  exit 1
fi

# Ensure local development branch is up to date
git fetch origin development
git checkout development
git pull origin development

gh pr create --base main --head development --fill

gh pr merge --${MERGE_MODE:-rebase} --admin

git checkout main
git pull origin main
"$(dirname "$0")/mark-main.sh"

echo "Release complete."
