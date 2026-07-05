# Design: Wider blog layout + convert network pages to blog posts

Date: 2026-07-05

Two related changes to the blog:

1. Widen the distill blog reading column and turn the table of contents into a sticky left sidebar (collapsing to a top box in portrait / narrow viewports).
2. Convert the two standalone "research primer" pages (`quantum network`, `agentic network`) into distill blog posts, preserving their old URLs via redirects.

---

## Part 1 — Wider blog + sticky left-sidebar ToC

### Problem
All 9 blog posts use `layout: distill`. Distill assigns every article child `grid-column: text` — a deliberately narrow (~700px) reading measure — leaving large empty side margins on desktop and feeling cramped, especially in portrait/narrow windows. The ToC (`d-contents`) floats in the top-left of the reading area rather than acting as a persistent sidebar.

### Scope
All edits live in `_sass/_distill.scss`, which already owns the distill overrides (including the existing `@media (max-width: 1024px)` ToC-collapse rule at line 197). The change applies to **all** distill posts, including the quantum-computing-101 series — this is intended.

### Changes (desktop, > 1024px)
1. **Widen the body.** Move default article content from the narrow `text` grid region to the wider `page` region, capped with a `max-width` in the ~820–880px range so long-line readability is preserved. Net: noticeably wider column, smaller dead margins. Distill figures/rows that set their own column continue to work.
2. **Sticky left-sidebar ToC.** Give `d-contents` `position: sticky; top: ~5rem; max-height: calc(100vh - 6rem); overflow-y: auto` so it stays pinned and scrolls independently as the article moves, and no longer consumes the reading column.

### Changes (portrait / ≤ 1024px)
Keep today's behavior: ToC collapses to a full-width box at the top, article goes near-full-width. Verify the article actually widens in portrait (the primary complaint).

### Verification
Serve the site locally and screenshot a distill post at a desktop width and a portrait width (per the saved al-folio preview recipe), before and after, to confirm the widening and the sticky sidebar behave — rather than guessing grid numbers. Tune the exact `max-width` / sidebar width against the screenshots.

---

## Part 2 — Convert the two network pages to blog posts

### Source
- `_pages/quantum_network.md` — `layout: page`, `permalink: /quantum-network/`, created 2026-03-18.
- `_pages/agentic_network.md` — `layout: page`, `permalink: /agentic-network/`, created 2026-05-20.

Both are polished pieces with a `What / Why / How / Where-my-research-fits` structure and their own SVG figures — a natural fit for `layout: distill`.

### New posts
- `_posts/2026-03-18-quantum-networking.md`
- `_posts/2026-05-20-agentic-networking.md`

Dated with each page's original git creation date (per user decision). Distill frontmatter: `title`, `description`, `date`, `tags`, `categories`, `authors` (Xuchuang Wang), and a `toc:` list matching the four sections. Body content carries over verbatim — the `<div class="row">` figure markup and `/assets/img/*.svg` references work unchanged in distill.

Proposed metadata:
- Quantum: `tags: quantum networking entanglement`, `categories: research`, toc = What is a quantum network? / Why quantum networks? / How do quantum networks work? / Where my research fits.
- Agentic: `tags: agents llm networking`, `categories: research`, toc = What is an agentic network? / Why agentic networks? / How do agentic networks work? / Where my research fits.

### Old URLs → redirect (no new plugin)
The site has no `jekyll-redirect-from` plugin, and adding one would touch the Gemfile/CI. Instead:
- Add `_layouts/redirect.liquid` — a minimal HTML page with `<meta http-equiv="refresh">`, a `<link rel="canonical">`, and a manual fallback link, driven by a `redirect_to` front-matter field.
- Replace each old `_pages/*.md` file's body with a redirect stub: `layout: redirect`, its original `permalink`, and `redirect_to` pointing at the new post URL (`/blog/2026/quantum-networking/`, `/blog/2026/agentic-networking/`). This keeps `/quantum-network/` and `/agentic-network/` resolving.

### Inbound links
`_pages/about.md:31-32` links to `/quantum-network/` and `/agentic-network/`. Repoint both to the new post URLs (the redirects are a safety net for external/bookmarked links).

### Blog permalink
`_config.yml` uses `permalink: /blog/:year/:title/`, so the new posts resolve at `/blog/2026/quantum-networking/` and `/blog/2026/agentic-networking/`.

---

## Out of scope
- Adding any Jekyll plugin.
- Restructuring the non-distill `post.liquid` layout.
- Editing the prose/content of the two converted pieces beyond frontmatter.
