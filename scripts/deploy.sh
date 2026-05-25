#!/usr/bin/env bash
set -euo pipefail

USERNAME="${1:-${GITHUB_USERNAME:-}}"
COMMIT_MESSAGE="${COMMIT_MESSAGE:-Create personal website}"

if [[ -z "$USERNAME" ]]; then
  echo "Usage: ./scripts/deploy.sh <github-username>"
  echo "Or set GITHUB_USERNAME=<github-username>."
  exit 1
fi

REPO="${USERNAME}.github.io"
REMOTE_URL="${REMOTE_URL:-git@github.com:${USERNAME}/${REPO}.git}"

if [[ ! -d .git ]]; then
  git init
fi

git branch -M main
git add .

if git diff --cached --quiet; then
  echo "No staged changes to commit."
else
  git commit -m "$COMMIT_MESSAGE"
fi

if git remote get-url origin >/dev/null 2>&1; then
  CURRENT_REMOTE="$(git remote get-url origin)"
  if [[ "$CURRENT_REMOTE" != "$REMOTE_URL" ]]; then
    echo "origin already points to: $CURRENT_REMOTE"
    echo "Expected: $REMOTE_URL"
    echo "Update it manually if you want to use a different repository."
    exit 1
  fi
else
  if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    if gh repo view "${USERNAME}/${REPO}" >/dev/null 2>&1; then
      git remote add origin "$REMOTE_URL"
    else
      gh repo create "$REPO" --public --source=. --remote=origin
    fi
  else
    git remote add origin "$REMOTE_URL"
  fi
fi

git push -u origin main

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  if gh api "repos/${USERNAME}/${REPO}/pages" >/dev/null 2>&1; then
    echo "GitHub Pages is already enabled."
  else
    gh api \
      --method POST \
      "repos/${USERNAME}/${REPO}/pages" \
      -f "source[branch]=main" \
      -f "source[path]=/" >/dev/null || true
  fi
fi

echo
echo "Deployment requested."
echo "Your site should become available shortly:"
echo "https://${REPO}"

