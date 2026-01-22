#!/bin/zsh
set -euo pipefail

SOURCE="/Users/benaissa287/Library/Mobile Documents/iCloud~md~obsidian/Documents/FACILO/Projets en cours/UTOPYA"
REPO="/Users/benaissa287/Documents/GitHub/facilo-utopya"

cd "$REPO"

# Sync Obsidian content into Quartz
rsync -a --delete --exclude '.DS_Store' --exclude '.obsidian' "$SOURCE/" "$REPO/content/"

# Ensure homepage exists
if [ -f "$REPO/content/00_ACTU_TODO.md" ]; then
  cp -f "$REPO/content/00_ACTU_TODO.md" "$REPO/content/index.md"
fi

# Commit only if there are changes
if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A
  if ! git diff --cached --quiet; then
    git commit -m "sync obsidian"
  fi
else
  git add -A
  if ! git diff --cached --quiet; then
    git commit -m "sync obsidian"
  fi
fi
