#!/usr/bin/env bash
# Build the site and audit the quantum series posts.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== jekyll build =="
bundle exec jekyll build 2>&1 | tee /tmp/series-build.log
# Fail on any Liquid error, or any warning that names our blog/distill files.
! grep -Ei "error|warning.*(blog|distill)" /tmp/series-build.log

echo "== citation audit =="
# Every d-cite key used in a post must exist in the bib.
bib="assets/bibliography/quantum_computing_101.bib"
fail=0
shopt -s nullglob
for post in _posts/2026-06-30-*.md; do
  for key in $(grep -oE 'd-cite key="[^"]+"' "$post" | sed -E 's/.*key="([^"]+)"/\1/' | sort -u); do
    if ! grep -q "{$key," "$bib"; then
      echo "MISSING BIB ENTRY: $key (used in $post)"; fail=1
    fi
  done
done

echo "== internal link audit =="
# Every /blog/2026/<slug>/ link target must have produced an output dir.
for post in _posts/2026-06-30-*.md; do
  for link in $(grep -oE '/blog/2026/[a-z0-9-]+/' "$post" | sort -u); do
    if [ ! -e "_site${link}index.html" ]; then
      echo "BROKEN INTERNAL LINK: $link (in $post)"; fail=1
    fi
  done
done

[ "$fail" -eq 0 ] && echo "AUDIT PASS" || { echo "AUDIT FAIL"; exit 1; }
