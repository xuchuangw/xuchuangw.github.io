# Homepage polish — design spec

**Date:** 2026-06-17
**Page:** `_pages/about.md` (the landing page, `permalink: /`), rendered via `_layouts/about.liquid`.
**Author:** design pass on the existing "Quiet Scholar" identity.

## Goal

Raise the *finish* of the homepage without redesigning it. Keep the existing visual
identity intact — Newsreader / Source Serif 4 / Inter, the single blue accent
(`--global-theme-color`), and the accent-tick-on-a-hairline-rule motif. This is a
precision pass on spacing, type, color, and component detail.

## Non-goals (explicitly out of scope)

- No new hero or signature element; no "two networks" visual device.
- No restructuring of the page (section order, what lives on the homepage vs subpages
  is unchanged).
- No font changes, no new accent color, no new motifs.
- No content rewrite. Copy changes are limited to nothing (structure/markup only),
  except moving inline-styled HTML into a CSS class.

## Constraints / quality floor

- Stay inside the current identity and token system; reuse existing variables.
- Site-wide ripple is acceptable where a fix lives in shared SCSS and clearly improves
  the whole site (user-approved). Shared-CSS changes here: dark-mode secondary text,
  light-mode secondary text contrast.
- Accessibility: secondary text must clear **WCAG AA** (≥ 4.5:1 for normal text) in
  **both** light and dark mode.
- Respect existing reduced-motion / responsive behavior; add no new animation.
- Must build clean under `bundle exec jekyll build` (Dart Sass; avoid deprecated
  global built-ins in any new SCSS).

## Affected files

| File | Change |
|------|--------|
| `_sass/_variables.scss` | Add secondary-text + notice-background color tokens. |
| `_sass/_themes.scss` | Wire the new tokens into `:root` (light) and `[data-theme="dark"]`; fix the dark secondary-text value. |
| `_sass/_custom.scss` | Section-heading unification, recruiting-notice component, measure, research-highlights link/marker scoping, spacing rhythm; refresh stale comments. |
| `_pages/about.md` | Replace the inline-styled callout `<div>` with `.recruiting-notice`; wrap research highlights in `.research-highlights`. |

---

## Work-stream A1 — Unify the section-heading system

**Problem.** Two heading systems appear on one page. The in-content markdown `##`
headings ("joining the lab", "research highlights") fall through to the generic serif
`h2`, while the template section ("news") is styled as an uppercase, letter-spaced
overline with a hairline rule and a short accent tick — because the Quiet Scholar CSS
only targets `.post > article > h2` (direct children of `article`), not the content
headings inside `.post > article > .clearfix`.

**Decision.** One motif, two deliberate tiers, sharing the *same skeleton*:
`[accent tick at top-left] → heading → hairline rule beneath`.

- **Tier 1 — content sections** (`.post > article > .clearfix > h2`): keep Newsreader
  **serif**, `font-size: 1.55rem`, weight 600, color `--global-text-color` (primary).
  Add `position: relative; padding-top: 0.85rem; padding-bottom: 0.55rem;
  border-bottom: 1px solid var(--global-divider-color); margin-top: 2.8rem;
  margin-bottom: 1.3rem;` and a `::before` accent tick (`2.25rem × 2px`,
  `var(--global-theme-color)`, `top:0; left:0`). Lowercase text is preserved
  (matches the source `## joining the lab`).
- **Tier 0 — meta/template sections** (`news`, existing `.post > article > h2`):
  unchanged — small uppercase Inter overline, same tick + rule.

Net effect: every section on the page is opened by the same accent-tick-on-a-rule
device; size and case encode the hierarchy (content > meta). News remains the model;
the content sections join its family.

---

## Work-stream A2 — Restore secondary-text hierarchy + AA contrast

**Problem.** In `_sass/_themes.scss`, dark mode sets `--global-text-color` **and**
`--global-text-color-light` to the same value (`$grey-color-light ≈ #e8e8e8`). So in
dark mode every de-emphasized element (subtitle `.desc`, profile coordinate line,
captions, `.periodical` italics, `h6`, section-overline labels) loses its distinction
from body text. Separately, the light-mode secondary grey (`$grey-color #828282` on
white ≈ 3.6:1) does **not** clear AA for normal-size text (e.g., the 0.82rem coordinate
line).

**Decision.** Introduce dedicated secondary-text tokens that clear AA in both modes,
wired only through `--global-text-color-light` so the change is confined to secondary
text (footer/`$grey-color` usages are untouched).

- New variables in `_variables.scss`:
  - `$text-secondary-light: #6b6b6b;`  // on #fff ≈ 5.3:1 (AA pass)
  - `$text-secondary-dark: #9aa0a6;`   // on #1c1c1d ≈ 6.4:1 (AA pass)
  - `$notice-bg-light: #eef4fd;`       // pale accent tint
  - `$notice-bg-dark:  #1f2733;`       // subtle blue-grey, just above #1c1c1d
- `_themes.scss`:
  - `:root` → `--global-text-color-light: #{$text-secondary-light};`
    and `--global-notice-bg: #{$notice-bg-light};`
  - `[data-theme="dark"]` → `--global-text-color-light: #{$text-secondary-dark};`
    and `--global-notice-bg: #{$notice-bg-dark};`
- Primary text values (`--global-text-color`) are unchanged in both modes.

Verification: confirm dark mode visually (subtitle/coordinate line read dimmer than
body) and check both ratios.

---

## Work-stream B1 — Recruiting callout → finished "notice" component

**Problem.** The page's most important CTA (Ph.D. / RA recruiting) is an inline-styled
`<div>` in `about.md` — a bare left border, `0.4rem 0.9rem` padding, no background —
sitting tight under the masthead. It reads as an indented paragraph, not a deliberate
notice.

**Decision.** Move it into SCSS as `.recruiting-notice`, quiet but intentional:

```scss
.recruiting-notice {
  background: var(--global-notice-bg);
  border-left: 3px solid var(--global-theme-color);
  border-radius: 4px;
  padding: 0.9rem 1.1rem;
  margin: 0.4rem 0 1.8rem;           // breathing room from masthead + below
  font-family: $font-serif-body;
  > strong:first-child { color: var(--global-theme-color); }  // "Prospective students:" label
}
```

`about.md`: replace
`<div style="border-left: 3px solid var(--global-theme-color); ...">…</div>`
with `<div class="recruiting-notice">…</div>` (same inner HTML: `<strong>`, link).

Still understated — a whisper of accent tint and an accent label, nothing loud.

---

## Work-stream C — Reading rhythm & link density

### C1 — One consistent measure; refresh stale comments
**Problem.** Body `p` is capped at `max-width: 80ch`, but content lists/headings are
uncapped, so in *research highlights* the bullets run wider (~1000px) than the
paragraphs (~780px) → ragged right edge. Comments still reference the old "800px
column / 16px base" although the site is now a 1000px column at 120% root.

**Decision.** Apply one measure to the direct flow-children of the content column —
prose, lists, and the two wrappers (`.recruiting-notice`, `.research-highlights`) — so
wrapped lists inherit the same bound:

```scss
.post > article > .clearfix > p,
.post > article > .clearfix > ul,
.post > article > .clearfix > ol,
.post > article > .clearfix > .recruiting-notice,
.post > article > .clearfix > .research-highlights { max-width: 72ch; }
```

(Separate selectors, no `:is()`, for Dart Sass safety.) Constraining the
`.research-highlights` wrapper bounds its inner `<ul>` even though that `<ul>` is no
longer a direct child of `.clearfix`. Update the stale comments to reflect the 1000px
column at 120% root. Final ch value (72–74) tuned by screenshot so the right edge aligns
without feeling narrow.

### C2 — Quiet the venue-link thicket in research highlights
**Problem.** Every venue link in *research highlights* is full-accent + underlined
(~25 equally-loud links), so the area reads as a wall of links rather than three
research themes with supporting citations.

**Decision.** Scope a quieter link + marker treatment to the highlights list only.

- `about.md`: wrap the highlights list in `<div class="research-highlights" markdown="1">…</div>`.
- SCSS — **mind the specificity** (the global content-link rule
  `.post > article > .clearfix a:not(.btn):not(.navbar-brand)` is (0,1,3); the override
  must match or exceed it):

```scss
.post > article > .clearfix .research-highlights {
  a:not(.btn):not(.navbar-brand) {
    text-decoration: none;                 // drop the underline thicket
    &:hover { text-decoration: underline;  // affordance returns on hover
              text-decoration-color: var(--global-theme-color); }
  }
  ::marker { color: var(--global-text-color-light); }  // mute default disc/circle markers
}
```

Links keep the accent color (inherited) and remain obviously clickable on hover; the
bold theme lead-ins and paper descriptions now read first.

---

## Work-stream D — Micro-polish (fold-ins)

- **D1 — Masthead → callout rhythm:** handled by `.recruiting-notice { margin-top: 0.4rem }`
  plus the existing `.desc { padding-bottom: 1.1rem }`. Tune by screenshot so the
  callout has clear breathing room from the subtitle hairline.
- **D2 — Mobile callout-above-headshot: DROPPED.** Reordering requires restructuring the
  layout (the profile `<div>` precedes content in the DOM and `<article>` is not a flex
  container); the risk/complexity is not justified for a conservative pass, and headshot-
  then-notice is a normal mobile reading order. Recorded as considered-and-cut (Chanel's
  "remove one accessory"). Mobile spacing is otherwise verified to stay clean.

---

## Verification plan

1. `bundle exec jekyll build --config _config.yml,_config.local.yml` completes with no
   new Sass errors.
2. Before/after headless-Chrome screenshots (desktop 1300w, mobile 430w) for: masthead +
   callout, the two content section headings vs news, research highlights.
3. **Dark mode** specifically verified (toggle in-browser or set `data-theme="dark"`):
   subtitle / coordinate line / captions read dimmer than body text.
4. Contrast spot-check: `#6b6b6b` on `#ffffff` and `#9aa0a6` on `#1c1c1d` both ≥ 4.5:1.
5. Optional: run the `web-design-guidelines` review on the changed CSS.
6. No visual regression on other pages from the shared-CSS changes (publications,
   team) — quick screenshot pass.

## Rollback

All changes are additive CSS + one Markdown markup swap. Reverting the commit restores
the prior state exactly; no data or content is altered.
