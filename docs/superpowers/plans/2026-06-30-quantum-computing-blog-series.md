# "How to Build a Quantum Computer" Blog Series — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Stand up the site's blog and publish a 6-post English distill series — one overview hub + five qubit-platform deep-dives — that is the deep, fully-cited long-form version of the Xiaohongshu QUANTUM 101 decks.

**Architecture:** al-folio Jekyll site. Each post is a `layout: distill` markdown file in `_posts/`, tag `quantum`, category `physical-layer`, sharing one BibTeX file. Figures are original inline SVG (theme-adaptive). The blog index page is restored to surface "blog" in the navbar. Build with `bundle exec jekyll build`; verify by parsing the generated `_site` HTML for unresolved citations and broken internal links.

**Tech Stack:** Jekyll + al-folio (jekyll-paginate-v2, distill template v2, KaTeX), BibTeX, hand-authored SVG. Bundler/Ruby toolchain (already present — site `_site/` builds locally).

**Source drafts (other repo, read-only):**
`../xiaohongshu/<topic>-qubit*/en/post.md` for the five platforms and
`../xiaohongshu/2026-06-11_quantum-computing-technical-routes/` for the hub. Relative to this
repo root: `PR/xcwang/xuchuangw.github.io` → `PR/xiaohongshu`.

---

## File Structure

| Path | Responsibility |
|------|----------------|
| `_pages/blog.md` | **Create.** Restored al-folio blog index; `nav: true`, `nav_order: 6` → puts "blog" in navbar. |
| `assets/bibliography/quantum_computing_101.bib` | **Create.** One shared BibTeX file for all six posts. |
| `_posts/2026-06-30-superconducting-qubits.md` | **Create.** Deep-dive (pilot template). |
| `_posts/2026-06-30-trapped-ion-qubits.md` | **Create.** Deep-dive. |
| `_posts/2026-06-30-neutral-atom-qubits.md` | **Create.** Deep-dive. |
| `_posts/2026-06-30-photonic-qubits.md` | **Create.** Deep-dive. |
| `_posts/2026-06-30-other-qubit-platforms.md` | **Create.** Deep-dive. |
| `_posts/2026-06-30-how-to-build-a-quantum-computer.md` | **Create.** Overview hub. |
| `assets/img/blog/quantum-101/<topic>/` | **Create.** Per-post standalone `.svg` copies + optional `preview.svg`. |
| `bin/check-series.sh` | **Create.** Build + citation/link audit script (see Shared Reference C). |

Posts are reachable at `/blog/2026/<slug>/` (existing `permalink: /blog/:year/:title/`).
No `_config.yml` change is required (blog, pagination, archives, distill citations already on).

---

## Shared Reference A — Distill post frontmatter template

Every post uses this exact frontmatter (fill the bracketed fields; `toc` names are per-post):

```yaml
---
layout: distill
title: [post title]
description: [one-sentence summary — shows on the blog index card and in meta tags]
date: 2026-06-30
tags: quantum [one or two topic-specific tags, e.g. superconducting transmon]
categories: physical-layer
giscus_comments: false
related_posts: true
bibliography: quantum_computing_101.bib
authors:
  - name: Xuchuang Wang
    url: "/"
    affiliations:
      name: HKBU
toc:
  - name: [Section 1 title]
  - name: [Section 2 title]
  # ...one entry per <h2> in the body, exact text match
---
```

Notes:
- `bibliography:` is the filename only; distill prepends `/assets/bibliography/`.
- `toc` entries must exactly match the `##` headings in the body or the sidebar links break.
- `giscus_comments: false` for now (no comment system configured site-wide). Flip later if desired.

## Shared Reference B — Figure authoring & embedding

Figures are **original, clean, minimalist, and theme-adaptive** (the site has light & dark mode).

**Authoring rules:**
- Inline `<svg>` directly in the post body (so `currentColor` works across themes).
- Primary strokes, axes, and text: `stroke="currentColor"` / `fill="currentColor"` — adapts to
  light/dark automatically.
- Accents only from this theme-safe palette (readable on both backgrounds):
  blue `#4f7cff`, teal `#14b8a6`, amber `#e0a106`, red `#ef4444`.
- Thin lines (`stroke-width="1.5"`–`2"`), generous whitespace, sans labels, no drop shadows,
  no dark fills. A `viewBox` (e.g. `0 0 720 320`); never a fixed pixel width.
- Wrap every figure exactly like this (distill layout class + numbered caption):

```html
<figure class="l-body" style="text-align:center; margin: 1.5rem auto; max-width: 720px;">
  <svg viewBox="0 0 720 320" role="img" aria-label="[accessible description]"
       style="width:100%; height:auto;">
    <!-- paths use stroke/fill="currentColor" + the accent palette above -->
  </svg>
  <figcaption style="margin-top:.5rem;">
    <b>Figure N.</b> [caption]. [If it recreates a published concept: "After Ref. " <d-cite key="..."></d-cite>.]
  </figcaption>
</figure>
```

- Also save a standalone copy of each figure to
  `assets/img/blog/quantum-101/<topic>/figNN-<name>.svg` (for reuse / linking). The standalone
  copy may hardcode a neutral stroke (`#3b3f4a`) since it renders outside the theme.

**Math:** inline `$...$`, display `$$...$$` (distill KaTeX delimiters are configured). Use math
only where it clarifies (e.g. a Hamiltonian, a blockade radius, a fidelity bound).

## Shared Reference C — Build & audit (the "test" for every content task)

Create `bin/check-series.sh` once (Task 1), then run it after every post. It must build the site
and fail loudly on unresolved citations or broken internal series links.

```bash
#!/usr/bin/env bash
# Build the site and audit the quantum series posts.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== jekyll build =="
bundle exec jekyll build 2>&1 | tee /tmp/series-build.log
# Fail on any Liquid warning/error in our files.
! grep -Ei "error|warning.*(blog|distill)" /tmp/series-build.log

echo "== citation audit =="
# Every d-cite key used in a post must exist in the bib.
bib="assets/bibliography/quantum_computing_101.bib"
fail=0
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
```

Expected on success: prints `AUDIT PASS` and exits 0. Any missing bib key or broken link → exit 1.

## Shared Reference D — BibTeX entry format & sourcing rules

- One entry per distinct source in `quantum_computing_101.bib`. Prefer journal DOI; else arXiv;
  else a reputable institutional/news URL (IBM/Google/Nature News/APS). Never cite a claim you
  could not verify — cut or soften it instead.
- Citation key convention: `lastnameYYYYkeyword` (e.g. `arute2019supremacy`, `google2024willow`).
- Example entries:

```bibtex
@article{koch2007transmon,
  title   = {Charge-insensitive qubit design derived from the Cooper pair box},
  author  = {Koch, Jens and Yu, Terri M. and Gambetta, Jay and others},
  journal = {Physical Review A},
  volume  = {76}, number = {4}, pages = {042319}, year = {2007},
  doi     = {10.1103/PhysRevA.76.042319}
}

@article{google2024willow,
  title   = {Quantum error correction below the surface code threshold},
  author  = {{Google Quantum AI and Collaborators}},
  journal = {Nature}, volume = {638}, pages = {920--926}, year = {2025},
  doi     = {10.1038/s41586-024-08449-y}
}
```

- Cite inline with `<d-cite key="koch2007transmon"></d-cite>`. Distill auto-renders the numbered
  reference list at the post's end — no manual bibliography section.

## Shared Reference E — Deep-dive post structure (applies to all five platforms)

Each deep-dive expands its source `post.md` into a structured, **deep** distill article
(~2500–4500 words). Required `##` sections (these become the `toc`):

1. **Series callout** (not a section — a short italic line at the very top):
   `*Part of the [How to Build a Quantum Computer](/blog/2026/how-to-build-a-quantum-computer/) series.*`
   (On first build the hub may not exist yet — the link still renders; the audit only checks
   links that point to posts that should exist by the end. Add the hub link in the cross-link
   pass, Task 11, if you prefer to avoid a transient broken link.)
2. **What this qubit is** — the central metaphor, then the real physics.
3. **How it's built and controlled** — mechanism + gate physics + governing equation(s).
4. **Strengths** — with quantitative backing (gate speed/time, fidelity), each cited.
5. **The honest costs** — real error budget, coherence, scaling walls, with numbers, cited.
6. **State of the art** — latest verified milestones AND what they mean + caveats, each cited.
7. **Where it sits** — short comparison vs other routes (a small table or callout).

Depth bar: include the mechanism, the math, and the sourced numbers — not just the metaphor.
Keep the warm, wry, verified voice. Every number/date/named result gets a `<d-cite>`.

---

## Phase 0 — Scaffolding & build harness

### Task 1: Blog index page, asset dirs, bib seed, audit script

**Files:**
- Create: `_pages/blog.md`
- Create: `assets/bibliography/quantum_computing_101.bib`
- Create: `assets/img/blog/quantum-101/{superconducting,trapped-ion,neutral-atom,photonic,other,hub}/` (dirs)
- Create: `bin/check-series.sh`

- [ ] **Step 1: Restore the canonical al-folio blog index page.**
  Fetch the upstream al-folio `_pages/blog.md` (it contains the full post-listing + pagination
  markup this theme expects) and adapt its frontmatter. Use WebFetch on
  `https://raw.githubusercontent.com/alshedivat/al-folio/main/_pages/blog.md`. Save it to
  `_pages/blog.md`, then set its frontmatter to:

```yaml
---
layout: default
permalink: /blog/
title: blog
nav: true
nav_order: 6
pagination:
  enabled: true
  collection: posts
  permalink: /page/:num/
  per_page: 10
  sort_field: date
  sort_reverse: true
  trail:
    before: 1
    after: 3
---
```
  Keep the rest of the upstream body verbatim. (If WebFetch is unavailable, reconstruct from the
  al-folio docs — the body iterates `paginator.posts` and renders post cards.)

- [ ] **Step 2: Create the asset directories.**

```bash
mkdir -p assets/img/blog/quantum-101/{superconducting,trapped-ion,neutral-atom,photonic,other,hub}
```

- [ ] **Step 3: Seed the bib file** with a header comment so the file exists for the first build:

```bibtex
% Bibliography for the "How to Build a Quantum Computer" blog series.
% One entry per verified source. Keys: lastnameYYYYkeyword. Prefer DOI.
```

- [ ] **Step 4: Create `bin/check-series.sh`** with the exact contents of Shared Reference C, then `chmod +x bin/check-series.sh`.

- [ ] **Step 5: Build to verify scaffolding is clean.**
  Run: `bundle exec jekyll build`
  Expected: exits 0; `_site/blog/index.html` exists; navbar in `_site/index.html` contains a `blog` link (`grep -c '/blog/' _site/index.html` ≥ 1).

- [ ] **Step 6: Commit.**

```bash
git add _pages/blog.md assets/bibliography/quantum_computing_101.bib bin/check-series.sh
git commit -m "feat(blog): scaffold blog index, series bib, and build-audit script"
```

---

## Phase 1 — Superconducting deep-dive (pilot / locked template)

> This post is built first and reviewed by the user before the others. It establishes the
> template (frontmatter, figure style, citation rendering, voice/depth).

### Task 2: Research & cite — superconducting

**Files:** Modify `assets/bibliography/quantum_computing_101.bib`

- [ ] **Step 1:** Read the source draft `../xiaohongshu/superconducting-qubits/en/post.md` (and `../xiaohongshu/trapped-ion-qubits/_brief.md` for the verified-facts house style).
- [ ] **Step 2:** For each factual claim below, find a primary source and add a BibTeX entry (Shared Reference D). Verify the number/date; if it does not check out, note it and soften the prose later. Claims to source:
  - Transmon design (Koch et al., PRA 2007).
  - 2025 Nobel Prize in Physics (macroscopic quantum tunnelling / circuit QED — confirm citation & wording on the official Nobel announcement).
  - Google Sycamore "quantum supremacy" (Arute et al., Nature 2019) — and the later classical-simulation pushback (cite at least one rebuttal).
  - Google Willow below-threshold error correction (Nature 2025; Λ≈2.14, distance-7 surface code).
  - Google "Quantum Echoes"/verifiable advantage (Nature 2025, OTOC, ~13,000×) — verify the number and "verifiable" framing.
  - IBM Condor 1121 physical qubits (2023) and Heron/Nighthawk qubit counts.
  - Coherence: typical transmon T1/T2 ≈ 0.1–0.4 ms; Princeton tantalum T1 ≈ 1.68 ms (Nature 2025) — verify record value & date.
  - Gate times: 1Q ~10–50 ns, 2Q ~25–70 ns; and a representative 2Q fidelity (≥99.5–99.9%) with source.
- [ ] **Step 3: Audit the keys compile.** Run: `bash bin/check-series.sh` is premature (no post yet); instead `grep -c '^@' assets/bibliography/quantum_computing_101.bib` ≥ 8.
- [ ] **Step 4: Commit.** `git add assets/bibliography/quantum_computing_101.bib && git commit -m "refs(blog): sourced citations for superconducting deep-dive"`

### Task 3: Figures — superconducting

**Files:** authored inline in the post (Task 4); standalone copies in `assets/img/blog/quantum-101/superconducting/`

- [ ] **Step 1:** Build 2–3 original SVGs per Shared Reference B:
  - **Fig 1 — Anharmonic energy ladder:** an LC oscillator's evenly-spaced ladder vs the
    transmon's uneven ladder (label the $0\!\to\!1$ and $1\!\to\!2$ gaps differing); accent the
    used $|0\rangle,|1\rangle$ levels in teal.
  - **Fig 2 — Josephson junction / transmon circuit:** capacitor + Josephson junction (×) box,
    minimal schematic; one accent.
  - **Fig 3 (optional) — Gate-speed positioning:** a simple horizontal scale placing
    superconducting (fast, ~10–70 ns) vs ions (slow) — only if it adds insight.
- [ ] **Step 2:** Save standalone `.svg` copies to the topic dir (neutral stroke `#3b3f4a`).
- [ ] **Step 3: Commit.** `git add assets/img/blog/quantum-101/superconducting && git commit -m "assets(blog): superconducting figures"`

### Task 4: Write the post — superconducting

**Files:** Create `_posts/2026-06-30-superconducting-qubits.md`

- [ ] **Step 1:** Write the frontmatter from Shared Reference A. Title e.g. *"Superconducting qubits: the circuit that fakes an atom."* `tags: quantum superconducting transmon`. `toc` lists the section headings from Step 2.
- [ ] **Step 2:** Write the body following Shared Reference E (sections 1–7), expanding the source draft to ~2500–4500 words at the depth bar:
  - Include the transmon mechanism: anharmonicity via the Josephson cosine potential
    $U(\phi) = -E_J\cos\phi$, why an LC ladder is too even, what the transmon fixes.
  - Quantitative strengths (gate times, fidelity) and honest costs (T1/T2, wiring wall, the
    dilution-fridge millikelvin requirement), each with `<d-cite>`.
  - SOTA with caveats (Sycamore contested; Willow = memory not computation; Echoes = verifiable).
  - Embed Figs 1–2 (inline SVG) at the right points; keep the warm/wry voice.
  - Add the series callout line at the very top.
- [ ] **Step 3: Build & audit.** Run: `bash bin/check-series.sh`. Expected: `AUDIT PASS`.
- [ ] **Step 4: Spot-check the rendered HTML.** Confirm `_site/blog/2026/superconducting-qubits/index.html` exists, the TOC sidebar lists every section, and citation superscripts/`d-cite` resolved (no raw `[?]`).
- [ ] **Step 5: Commit.** `git add _posts/2026-06-30-superconducting-qubits.md && git commit -m "feat(blog): superconducting qubits deep-dive"`

### Task 5: CHECKPOINT — user reviews the pilot

- [ ] **Step 1:** Serve locally (`bundle exec jekyll serve`) and ask the user to review the
  rendered superconducting post: layout, figure style, citation rendering, depth, and voice.
- [ ] **Step 2:** Apply any template adjustments the user requests. **Lock the template** before
  Phase 2. Re-run `bin/check-series.sh` after edits.

---

## Phase 2 — Remaining four deep-dives (against the locked template)

Each task follows the same procedure as Tasks 2–4 (research→bib, figures, write, audit, commit),
applied to that platform with its own content packet. Procedure reference: Shared References A–E.
Per-task verify command is always `bash bin/check-series.sh` → expect `AUDIT PASS`. Commit after each.

### Task 6: Trapped-ion qubits

**Files:** Create `_posts/2026-06-30-trapped-ion-qubits.md`; Modify the bib; figures under `.../trapped-ion/`.
Source draft: `../xiaohongshu/trapped-ion-qubits/en/post.md` (+ `_brief.md` facts sheet).

- [ ] **Research/cite:** ion species & hyperfine/optical qubit; Mølmer–Sørensen gate via shared
  motional modes; world-leading 1Q/2Q fidelities (Oxford/NIST/Quantinuum, ~99.9%+); long
  coherence (seconds–minutes); slow gates (µs–ms); all-to-all connectivity; Quantinuum H-series /
  QCCD architecture; recent logical-qubit milestones. Add sourced bib entries.
- [ ] **Figures:** (a) linear Paul trap with ion chain + shared motional mode; (b) MS gate
  schematic (two ions coupled through a phonon mode). Inline SVG per Shared Reference B.
- [ ] **Write** (Shared Reference E, sections 1–7) — balance the *memory* and *computer* roles the
  draft emphasizes; include the MS-gate idea and the speed↔fidelity↔connectivity trade-off.
- [ ] **Audit + commit.**

### Task 7: Neutral-atom qubits

**Files:** Create `_posts/2026-06-30-neutral-atom-qubits.md`; Modify the bib; figures under `.../neutral-atom/`.
Source draft: `../xiaohongshu/neutral-atom-qubits/en/post.md`.

- [ ] **Research/cite:** optical-tweezer arrays; Rydberg blockade (define the blockade radius
  $R_b$); two-qubit gates via Rydberg interaction; reconfigurable connectivity & atom shuttling;
  Lukin/Harvard 2023–2024 logical-qubit results; QuEra Aquila; Pasqal; typical array sizes
  (hundreds–thousands of atoms) and fidelities. Add sourced bib entries.
- [ ] **Figures:** (a) tweezer array grid with a few excited (Rydberg) atoms; (b) blockade —
  one excited atom suppressing a neighbor within $R_b$. Inline SVG.
- [ ] **Write** (Shared Reference E) — emphasize scalability + reconfigurability + the Rydberg
  mechanism; honest costs (atom loss, gate fidelity vs superconducting/ion, measurement speed).
- [ ] **Audit + commit.**

### Task 8: Photonic qubits

**Files:** Create `_posts/2026-06-30-photonic-qubits.md`; Modify the bib; figures under `.../photonic/`.
Source draft: `../xiaohongshu/photonic-qubits/en/post.md`.

- [ ] **Research/cite:** photon encodings (dual-rail/polarization); why two photons barely
  interact → measurement-induced nonlinearity; KLM scheme; **measurement-/fusion-based** quantum
  computing & cluster states; Xanadu Borealis GBS advantage (Nature 2022); USTC Jiuzhang GBS;
  PsiQuantum fusion-based architecture; room-temperature operation + loss as the central enemy.
  Add sourced bib entries (verify GBS advantage claims & caveats — GBS ≠ universal QC).
- [ ] **Figures:** (a) dual-rail photon qubit / beam-splitter + detector; (b) fusion of two
  small cluster states into a larger graph. Inline SVG.
- [ ] **Write** (Shared Reference E) — make the "light barely interacts, so we compute by
  measuring" idea land; cover MBQC/FBQC; SOTA with the GBS-vs-universal caveat.
- [ ] **Audit + commit.**

### Task 9: Other qubit platforms

**Files:** Create `_posts/2026-06-30-other-qubit-platforms.md`; Modify the bib; figures under `.../other/`.
Source draft: `../xiaohongshu/other-qubit-platforms/en/post.md`.

- [ ] **Research/cite:** semiconductor **spin qubits** (Si/SiGe quantum dots, Intel, Delft;
  CMOS-compatibility, >99% fidelity, mK operation); **topological qubits** (Majorana; Microsoft
  2025 "Majorana 1" / topological-gap claims — verify and present the controversy honestly);
  **NV centers** (room-temperature, sensing & networking more than large-scale QC); brief mention
  of nuclear/molecular spins. Add sourced bib entries; flag contested claims.
- [ ] **Figures:** (a) a Si quantum-dot spin qubit (gate-defined dot, spin up/down); (b) a small
  "platform landscape" comparison sketch. Inline SVG.
- [ ] **Write** (Shared Reference E, adapted — this post surveys several platforms) — one tight
  subsection per platform; be especially careful & sourced on topological claims.
- [ ] **Audit + commit.**

---

## Phase 3 — Overview hub + cross-linking

### Task 10: Overview hub post

**Files:** Create `_posts/2026-06-30-how-to-build-a-quantum-computer.md`; Modify the bib; figures under `.../hub/`.
Source: `../xiaohongshu/2026-06-11_quantum-computing-technical-routes/` (deck + any notes).

- [ ] **Step 1: Research/cite.** DiVincenzo criteria (cite the 2000 paper); the at-a-glance
  numbers for the cross-route comparison (gate speed, coherence, fidelity, qubit count,
  connectivity, operating temperature for each of the 5 routes) — each cell sourced (reuse bib
  entries already added in Tasks 2–9; add any missing).
- [ ] **Step 2: Hub comparison figure.** One original SVG: a comparison matrix or small-multiples
  chart across the five routes (e.g. gate time vs coherence, with qubit-count as a label). Inline
  SVG per Shared Reference B; this is the series' signature figure — make it clean and honest.
- [ ] **Step 3: Write the hub** (~2500–4000 words): frame "what makes a good qubit" (DiVincenzo),
  present the five routes at a glance with the comparison figure/table, then a short, fair
  paragraph per route **each linking to its deep-dive** at `/blog/2026/<slug>/`. Close with an
  honest "no winner yet / co-design" outlook. Warm, wry, sourced.
- [ ] **Step 4:** `tags: quantum overview`. `toc` covers the sections.
- [ ] **Step 5: Audit + commit.** `bash bin/check-series.sh` → `AUDIT PASS` (now all five
  deep-dive links resolve). `git commit -m "feat(blog): how-to-build-a-quantum-computer overview hub"`

### Task 11: Cross-link pass (deep-dives ↔ hub)

**Files:** Modify all five `_posts/2026-06-30-*-qubits.md` / `*-platforms.md`.

- [ ] **Step 1:** Ensure each deep-dive's top series-callout links to the hub, and add a closing
  "Read the rest of the series" block listing the other four siblings + the hub, each as a
  `/blog/2026/<slug>/` link.
- [ ] **Step 2: Audit.** `bash bin/check-series.sh` → `AUDIT PASS` (no broken internal links).
- [ ] **Step 3: Commit.** `git commit -am "feat(blog): cross-link the quantum-computing series"`

---

## Phase 4 — Series finish

### Task 12: Full-series audit + content review

- [ ] **Step 1: Clean build.** `bundle exec jekyll build` → exits 0, no liquid errors.
- [ ] **Step 2: Audit.** `bash bin/check-series.sh` → `AUDIT PASS`.
- [ ] **Step 3: Citation completeness.** Spot-check 5 random numeric/dated claims per post against
  their cited source; confirm no `@misc` placeholder or dead key remains. `grep -L doi assets/bibliography/quantum_computing_101.bib` style check for entries missing both `doi` and `url`.
- [ ] **Step 4: Voice & depth review.** Read each post: is it both genuinely informative and
  genuinely funny (warm, not cynical), and does each deep-dive deliver mechanism + math + sourced
  numbers (not just the poster metaphor)? Fix shortfalls.
- [ ] **Step 5: Navbar & index check.** `grep '/blog/' _site/index.html` (blog in nav);
  open `_site/blog/index.html` — all six posts listed, newest first, descriptions present.
- [ ] **Step 6: Final commit.** `git commit -am "chore(blog): final audit pass for quantum series"` (if any fixes).

### Task 13: Hand-off

- [ ] **Step 1:** Summarize for the user: branch `blog/quantum-computing-101`, six posts live at
  `/blog/`, ready to preview via `bundle exec jekyll serve`. Ask whether to merge to `master`
  (which deploys to GitHub Pages) or open a PR — defer to the
  superpowers:finishing-a-development-branch skill for that decision. Do not push/merge without
  user approval.

---

## Self-Review

**Spec coverage:** ✅ Tag `quantum` + category `physical-layer` (Ref A, all tasks). ✅ Distill
layout, TOC, MathJax, BibTeX (Ref A/D, all). ✅ English-only. ✅ Original minimalist theme-adaptive
SVG, no poster-PNG reuse (Ref B). ✅ Full BibTeX with verified primary sources (Ref D, Tasks 2,6–10).
✅ Overview hub + cross-linking + `blog` in navbar (Tasks 1, 10, 11). ✅ Superconducting-first pilot
with checkpoint (Tasks 2–5). ✅ Depth target / mechanism+math+numbers (Ref E, all deep-dives).
✅ Warm-and-funny voice preserved (Ref E, Task 12). ✅ Out-of-scope items excluded (no network
topics, no bilingual, no PNG reuse).

**Placeholder scan:** No "TBD/handle later" steps. Bracketed fields in Ref A are template slots
(intentional, filled per task). Per-platform "research X" steps name the specific facts and
sources to find — that is research direction, not a hand-wave.

**Consistency:** bib filename `quantum_computing_101.bib`, citation key scheme `lastnameYYYYkeyword`,
post slugs, `/blog/2026/<slug>/` permalink, and `bin/check-series.sh` audit are used identically
across all tasks. `nav_order: 6` is the one free navbar slot (after services=5).

**Risk note:** The largest effort and risk is citation sourcing (every number verified to a primary
source). Tasks 2 and 6–10 each gate the prose on completed, verified bib entries; unverifiable
claims are cut, not shipped.
