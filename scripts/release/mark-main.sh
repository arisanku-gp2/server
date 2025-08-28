#!/usr/bin/env bash
set -euo pipefail

branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$branch" != "main" ]]; then
  echo "This script must run on main. Current: $branch" >&2
  exit 1
fi

bump=""
if [[ "${1:-}" == "--bump" ]]; then
  bump="${2:-}"
fi

version=$(cat VERSION)
IFS='.' read -r major minor patch <<<"$version"
case "$bump" in
  major)
    ((major++)); minor=0; patch=0;;
  minor)
    ((minor++)); patch=0;;
  patch)
    ((patch++));;
  "")
    ;;
  *)
    echo "Unknown bump level: $bump" >&2
    exit 1;
    ;;
esac
new_version="${major}.${minor}.${patch}"
echo "$new_version" > VERSION

{
  echo ""
  echo "## v$new_version"
  echo "- release marker"
} >> CHANGELOG.md

git add VERSION CHANGELOG.md
git commit -m "chore(release): v$new_version (marker)"
