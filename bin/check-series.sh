#!/usr/bin/env bash
# Build the site and audit the quantum series posts.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== jekyll build =="
bundle exec jekyll build 2>&1 | tee /tmp/series-build.log
# Fail on any Liquid error, or any warning that names our blog/distill files.
if grep -Ei "error|warning.*(blog|distill)" /tmp/series-build.log; then
  echo "BUILD LOG CONTAINS ERRORS/WARNINGS — see /tmp/series-build.log" >&2
  exit 1
fi

echo "== citation audit =="
# Every d-cite key used in a post must exist in the bib.
bib="assets/bibliography/quantum_computing_101.bib"
fail=0
shopt -s nullglob
for post in _posts/*.md; do
  for key in $(grep -oE 'd-cite key="[^"]+"' "$post" | sed -E 's/.*key="([^"]+)"/\1/' | tr ',' '\n' | sort -u); do
    if ! grep -qE "\{[[:space:]]*${key}[[:space:]]*," "$bib"; then
      echo "MISSING BIB ENTRY: $key (used in $post)"; fail=1
    fi
  done
done

echo "== internal link audit =="
# Every /blog/2026/<slug>/ link target must have produced an output dir.
for post in _posts/*.md; do
  for link in $(grep -oE '/blog/2026/[a-z0-9-]+/' "$post" | sort -u); do
    if [ ! -e "_site${link}index.html" ]; then
      echo "BROKEN INTERNAL LINK: $link (in $post)"; fail=1
    fi
  done
done

echo "== spurious-table audit (kramdown pipe-in-math) =="
# Our only intended tables are plain-text comparison tables. A rendered table cell
# that contains math (a '$' delimiter or a bra-ket command like \rangle) means kramdown
# turned a literal '|' in inline math into a spurious <table>. Fix: write '|' as \vert in
# math (see plan Shared Reference B).
for html in _site/blog/2026/*/index.html; do
  if grep -nE '<t[dh][ >].*(\$|\\(rangle|langle|vert))' "$html" >/dev/null; then
    echo "SPURIOUS TABLE (math '|' in $html) — escape pipes in math as \\vert"; fail=1
  fi
done

[ "$fail" -eq 0 ] && echo "AUDIT PASS" || { echo "AUDIT FAIL"; exit 1; }
