# How to Build a Quantum Computer — blog series design spec

**Date:** 2026-06-30
**Site:** `xuchuangw.github.io` (al-folio Jekyll, deployed to GitHub Pages).
**Author:** Xuchuang Wang (万象). Long-form English home for the Xiaohongshu *QUANTUM 101 / 量子科普* qubit decks.

## Goal

Stand up the site's blog section (currently empty — no `_posts/`, no blog nav) with a
6-post English series, **"How to Build a Quantum Computer,"** that is the detailed,
properly-cited long-form version of the Xiaohongshu qubit posters. The series surveys the
five hardware routes to a qubit (one overview hub + five platform deep-dives), reusing the
already-drafted `post.md` "Blog article" sections as the backbone.

Source material lives in the sibling repo
`PR/xiaohongshu/{superconducting,trapped-ion,neutral-atom,photonic,other}-qubit*/en/post.md`
and `PR/xiaohongshu/2026-06-11_quantum-computing-technical-routes/` (the overview deck).

## The six posts

Tag **`quantum`**, category **`physical-layer`**. Series cohesion comes from the overview
hub + cross-links + the consistent *"How to Build a Quantum Computer"* titling — **not** from
a series-specific tag.

| # | Role | Slug | Source draft |
|---|------|------|--------------|
| 1 | Overview / hub | `how-to-build-a-quantum-computer` | `2026-06-11_quantum-computing-technical-routes/` deck |
| 2 | Deep-dive | `superconducting-qubits` | `superconducting-qubits/en/post.md` |
| 3 | Deep-dive | `trapped-ion-qubits` | `trapped-ion-qubits/en/post.md` |
| 4 | Deep-dive | `neutral-atom-qubits` | `neutral-atom-qubits/en/post.md` |
| 5 | Deep-dive | `photonic-qubits` | `photonic-qubits/en/post.md` |
| 6 | Deep-dive | `other-qubit-platforms` | `other-qubit-platforms/en/post.md` |

Post filenames: `_posts/2026-06-30-<slug>.md` (date is placeholder/publish date; permalink
resolves to `/blog/2026/<slug>/` per the existing `permalink: /blog/:year/:title/` config).

## Decisions (locked with user)

- **Language:** English only.
- **Layout:** `distill` — TOC sidebar, section anchors, MathJax, `<d-cite>` + `<d-bibliography>`.
- **Imagery:** text-forward; **original clean-minimalist SVG** figures (light, academic — not
  the dark poster aesthetic). **No** reuse of poster PNGs. Figures *from* reference papers are
  copyrighted → we either redraw the concept as an original figure ("after Ref. [x]") or use
  only explicitly open-licensed (CC-BY) images. Default: original.
- **Citations:** **full BibTeX.** Every key factual claim sourced with a real DOI/URL in a
  shared `.bib`; numbered reference list auto-rendered by distill. Any claim that fails
  verification is cut or softened — never shipped unsourced.
- **Structure & nav:** series with an **overview hub** + the five deep-dives cross-linked;
  **`blog` added to the top navbar.** Tag `quantum`.
- **Depth:** these are **deep technical articles, not the poster intros.** The drafted
  `post.md` is the *popular-science floor*; the blog goes well beyond it — real mechanisms,
  Hamiltonians/gate physics, quantitative fidelity/coherence/error numbers, and the actual
  meaning (and caveats) of SOTA results. MathJax used wherever an equation clarifies. See
  "Depth target" below.
- **Voice:** informative AND genuinely funny (warm, self-aware, verified) — the standing
  poster directive. Preserve the drafts' tone *even at depth* (rigorous but still warm/wry).
- **Build sequencing:** **superconducting first as the full template** → render locally →
  user sign-off on look/feel → then batch the remaining five against the locked template.

## Non-goals (explicitly out of scope, this batch)

- Quantum-network topics (what-is / why / repeaters / QKD / QEC) — a later batch.
- Bilingual or Chinese-only versions.
- Reusing the poster PNG cards as figures.
- Redesigning the site theme, fonts, or existing pages.

## Site architecture (al-folio specifics)

| File / dir | Change |
|------------|--------|
| `_posts/` | New dir. Six `2026-06-30-<slug>.md` distill posts. |
| `_pages/blog.md` | New page, `nav: true` + `nav_order`, permalink containing `/blog/` — this is what surfaces "blog" in the navbar (header.liquid keys on `p.permalink contains '/blog/'`). |
| `assets/bibliography/quantum_computing_101.bib` | New shared bib for the series. |
| `assets/img/blog/quantum-101/<topic>/*.svg` | New original SVG figures, one subdir per post. |
| `assets/img/blog/quantum-101/<topic>/preview.*` | Optional per-post preview/thumbnail for the blog index card. |

No changes to `_config.yml` are required for posts/permalinks (blog already enabled:
`permalink: /blog/:year/:title/`, pagination on, archives on, distill citation set on).
`_config.yml` may need a one-line check only if the navbar blog toggle needs enabling.

### Post frontmatter shape (distill)

```yaml
---
layout: distill
title: <title>
description: <one-line summary, shows on blog index + meta>
date: 2026-06-30
tags: quantum <topic-specific>
categories: physical-layer
giscus_comments: true            # match site default if comments enabled elsewhere
bibliography: quantum_computing_101.bib
authors:
  - name: Xuchuang Wang
    url: "/"
    affiliations:
      name: HKBU
toc:
  - name: <section 1>
  - name: <section 2>
  # ...
---
```

### Figures

- Authored as standalone `.svg` files (hand-written SVG, clean minimalist: thin lines,
  restrained palette, white-page friendly), embedded with captions.
- Concept inventory (illustrative, finalized per post during writing): energy-level ladder
  (anharmonicity), trap/tweezer geometry, gate-pulse timeline, and on the **hub** a
  comparison chart (gate speed / coherence / qubit count / connectivity across the 5 routes).
- Each figure caption notes "original" or "after Ref. [key]" where it recreates a concept.

### Citations / bibliography

- One `.bib` shared across all six posts.
- Inline `<d-cite key="..."></d-cite>`; reference list auto-appended.
- **Every claim with a number, date, or named result must have an entry.** Known claims to
  source (non-exhaustive): 2025 Physics Nobel; Google Sycamore 2019; Google Willow 2024
  below-threshold (Λ≈2.14, distance-7 surface code); Google Quantum Echoes / verifiable
  advantage 2025; IBM Condor 1121 qubits; IBM Heron/Nighthawk counts; transmon (Yale 2007);
  Princeton tantalum T1 ≈ 1.68 ms (2025); plus the analogous headline facts in the other
  four decks. Sourcing is the largest effort and is done via web research against primary
  sources (journal DOI preferred, reputable news/blog otherwise).

### Cross-linking & series identity

- **Hub** (post 1) introduces the problem ("what makes a good qubit"), gives the at-a-glance
  five-route comparison, then links to each deep-dive.
- **Each deep-dive** opens with a short callout: "Part of the *How to Build a Quantum
  Computer* series" linking back to the hub and listing siblings.
- Tag `quantum` gives an archive page at `/blog/tag/quantum/` (shared with any future quantum
  posts — series grouping is carried by the hub + cross-links, not the tag).

## Content approach per post

The drafted `post.md` is the **floor, not the ceiling.** Expand each into a structured,
genuinely deep distill article — a curious physics-grad-student / fellow-researcher should
learn something, not just a layperson. Follow the poster card flow as a skeleton, then go
deeper at every step:

1. **Hook / what this qubit *is*** — the central metaphor, then the real physics behind it.
2. **Physical realization & control** — the actual mechanism and gate physics, with the
   governing Hamiltonian / key equations (MathJax) where they clarify: e.g. transmon
   anharmonicity & the Josephson cosine potential; Mølmer–Sørensen via shared motional
   modes; Rydberg blockade radius; KLM / fusion-based linear-optics & cluster states.
3. **Strengths** — why competitive, with quantitative backing (gate speed, fidelity).
4. **Honest weaknesses / costs** — the real error budget, scaling walls, with numbers.
5. **State of the art** — latest verified milestones AND what they actually mean + caveats
   (not just headlines), each cited.
6. **Where it sits vs the other routes** — comparison; deep-dives get a short table/callout,
   the hub gets the full cross-route comparison + a "what makes a good qubit" (DiVincenzo)
   framing.

### Depth target

- **Length:** substantial — aim ~2500–4500 words per deep-dive (vs the ~1500-word poster
  draft); the hub similar. Length serves depth, never padding.
- **Technical level:** include the mechanism, the math, and the numbers — fidelities, T1/T2,
  gate times, error rates, qubit counts — each sourced. Equations via MathJax where they earn
  their place.
- **SOTA with nuance:** explain *why* a result matters and its limitations (e.g. "below
  threshold" = memory, not computation; "quantum advantage" verifiable vs contested).
- **Still warm and funny.** Depth and the standing humor directive are not in tension —
  rigorous, surprising, and wry at once. The field, PhD, and advisor stay likeable.
- Tighten for a reading (not scrolling) medium; add the connective tissue the cards couldn't
  hold. Cut anything that's filler rather than insight.

## Build / verification workflow

1. Author post + figures + bib entries for **superconducting** first.
2. Build locally: `bundle exec jekyll build` (and/or serve) — must compile clean (Dart Sass,
   no broken liquid, distill renders, citations resolve, TOC populates, figures load).
3. User reviews the rendered superconducting post (template sign-off).
4. Batch the remaining five against the locked template; rebuild clean after each.
5. Add `_pages/blog.md` + confirm `blog` in navbar; verify hub ↔ deep-dive links resolve.

### Quality floor

- Site builds clean under `bundle exec jekyll build`; no liquid/SCSS errors.
- Every numeric/dated/named claim resolves to a `.bib` entry with a working source.
- Distill renders: TOC sidebar populated, `<d-cite>` links resolve to the reference list,
  MathJax renders any math, SVG figures load with captions.
- Internal series links (hub ↔ deep-dives, tag archive) all resolve.
- Voice check: each post is both genuinely informative and genuinely funny, and nothing
  about the field/PhD/advisor reads as cynical.
- Depth check: each deep-dive delivers real mechanism + math + sourced numbers (not just the
  poster-level metaphor); SOTA claims carry their caveats; length serves depth, not padding.

## Open implementation details (resolved during writing-plans / build)

- Exact `_pages/blog.md` contents + `nav_order` value (slot relative to existing nav: about,
  openings(3), publications, services, team, quantum_network, agentic_network).
- Whether `giscus_comments` is enabled site-wide (match existing posts/pages; there are none
  yet, so follow `_config.yml`'s comments setting).
- Final per-post `toc` section names and figure list.
