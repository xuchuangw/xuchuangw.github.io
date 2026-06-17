# Homepage Polish Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Raise the finish of the landing page (section headings, dark-mode contrast, the recruiting callout, reading rhythm) without changing its identity.

**Architecture:** Pure CSS/SCSS refinement of the existing "Quiet Scholar" theme plus one Markdown markup swap. New color tokens flow through existing CSS custom properties; new component/heading rules extend the existing accent-tick-on-a-hairline-rule motif. No JS, no new dependencies, no font/accent changes.

**Tech Stack:** Jekyll (al-folio), Dart Sass (SCSS partials in `_sass/`), Liquid layouts, Kramdown Markdown. Local preview via `bundle exec jekyll serve`; visual verification via headless Google Chrome screenshots.

## Global Constraints

- Keep the existing identity: Newsreader / Source Serif 4 / Inter; single accent `var(--global-theme-color)` (`#0b57d0` light / `#8ab4f8` dark). No new fonts, accents, or motifs.
- Secondary text must clear **WCAG AA (≥ 4.5:1 for normal text)** in both light and dark mode.
- Brand/accent color is ALWAYS referenced via `var(--global-theme-color)` — never hardcoded.
- New SCSS must compile clean under Dart Sass (avoid deprecated global built-ins like `unquote`/`lighten` in new code).
- Site-wide ripple is acceptable only for the shared-CSS secondary-text change (A2); everything else is homepage-scoped via selectors/classes.
- No new animation; respect existing reduced-motion and responsive behavior.
- This is conservative polish — no restructuring, no hero, no content rewrite.

## File Structure

| File | Responsibility | Change |
|------|----------------|--------|
| `_sass/_variables.scss` | SCSS color/value tokens | **Modify** — add 4 tokens (secondary text ×2, notice bg ×2). |
| `_sass/_themes.scss` | Map tokens → CSS custom properties per light/dark | **Modify** — wire `--global-text-color-light` (both modes) + add `--global-notice-bg` (both modes). |
| `_sass/_custom.scss` | All Quiet Scholar overrides | **Modify** — content-section headings, `.recruiting-notice`, `.research-highlights`, shared measure; refresh stale comments. |
| `_pages/about.md` | Landing page content | **Modify** — swap inline-styled callout for `.recruiting-notice`; wrap research highlights in `.research-highlights`. |

**Task order & dependencies:** Task 1 (tokens) must precede Task 3 (callout consumes `--global-notice-bg`). Task 5 (measure) must follow Tasks 3 & 4 (its selector references the `.recruiting-notice` and `.research-highlights` wrappers they create). Tasks 1, 2 are otherwise independent.

---

## Verification harness (used by every task)

A local `jekyll serve --watch` auto-rebuilds on save; each task then screenshots the live page and Reads the PNG to confirm the change.

**Screenshot command** (substitute `WxH` and `OUT` per task):

```bash
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$CHROME" --headless=new --hide-scrollbars --no-first-run --no-default-browser-check \
  --user-data-dir=/tmp/cshot --window-size=WIDTH,HEIGHT \
  --screenshot=OUT "http://127.0.0.1:4000/" 2>/dev/null
```

Notes for the executor:
- Keep window **height ≤ ~4000** — taller windows hit the software-render surface limit and exit 21 with no file.
- After saving an edit, wait for `jekyll serve --watch` to finish regenerating (a fresh `...done in N seconds` line appears in `/tmp/jekyll-serve.log`) **before** screenshotting; otherwise you capture the old build. (When driving this from the agent loop, use a background wait/poll rather than a foreground `sleep`.)
- Read the PNG to inspect it. Crop mid-page regions with `convert IN -crop WxH+X+Y +repage OUT` (ImageMagick is installed) for crisp detail.

---

### Task 1: Color tokens + dark-mode / AA secondary-text fix (A2)

**Files:**
- Modify: `_sass/_variables.scss` (after `$grey-900: #212529;`)
- Modify: `_sass/_themes.scss` (`:root` block and `html[data-theme="dark"]` block)

**Interfaces:**
- Produces (consumed by Task 3 and Task 5): CSS custom property `--global-notice-bg`; corrected `--global-text-color-light` in both themes.

- [ ] **Step 1: Start a watching preview server**

```bash
cd "/Users/xuchuangwang/Library/Mobile Documents/com~apple~CloudDocs/PR/xcwang/xuchuangw.github.io"
pkill -f "jekyll serve" 2>/dev/null
rm -f /tmp/jekyll-serve.log
nohup bundle exec jekyll serve --watch --port 4000 --host 127.0.0.1 \
  --config _config.yml,_config.local.yml > /tmp/jekyll-serve.log 2>&1 &
```
Wait until `/tmp/jekyll-serve.log` shows `Server running...`, then confirm `curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:4000/` prints `200`.

- [ ] **Step 2: Add the SCSS tokens**

In `_sass/_variables.scss`, find:

```scss
$grey-color-dark: #1c1c1d;
$grey-900: #212529;
```

Replace with:

```scss
$grey-color-dark: #1c1c1d;
$grey-900: #212529;

// Secondary text — AA-compliant de-emphasis, surfaced via --global-text-color-light.
$text-secondary-light: #6b6b6b; // on #ffffff ≈ 5.3:1 (WCAG AA)
$text-secondary-dark: #9aa0a6; //  on #1c1c1d ≈ 6.4:1 (WCAG AA)

// Quiet notice background for the recruiting callout.
$notice-bg-light: #eef4fd; // pale accent tint on white
$notice-bg-dark: #1f2733; //  subtle blue-grey just above #1c1c1d
```

- [ ] **Step 3: Wire the light theme (`:root`)**

In `_sass/_themes.scss`, inside `:root`, find:

```scss
  --global-text-color-light: #{$grey-color};
```
Replace with:
```scss
  --global-text-color-light: #{$text-secondary-light};
```

Then, in the same `:root` block, find:

```scss
  --global-card-bg-color: #{$white-color};
```
Replace with:
```scss
  --global-card-bg-color: #{$white-color};
  --global-notice-bg: #{$notice-bg-light};
```

- [ ] **Step 4: Wire the dark theme (`html[data-theme="dark"]`)**

In `_sass/_themes.scss`, inside `html[data-theme="dark"]`, find:

```scss
  --global-text-color-light: #{$grey-color-light};
```
Replace with:
```scss
  --global-text-color-light: #{$text-secondary-dark};
```

Then, in the same dark block, find:

```scss
  --global-card-bg-color: #{$grey-900};
```
Replace with:
```scss
  --global-card-bg-color: #{$grey-900};
  --global-notice-bg: #{$notice-bg-dark};
```

- [ ] **Step 5: Verify the compiled CSS carries the new dark tokens**

After the watch rebuild completes:
```bash
grep -o "data-theme=.dark[^}]*--global-text-color-light:[^;]*" _site/assets/css/*.css | head
```
Expected: the dark block contains `--global-text-color-light:#9aa0a6` (or the hex Sass emits). Also confirm `--global-notice-bg` appears for both themes:
```bash
grep -o -- "--global-notice-bg:[^;]*" _site/assets/css/*.css | sort -u
```
Expected: two values (`#eef4fd` and `#1f2733`).

- [ ] **Step 6: Visual check (light) + AA confirmation**

Screenshot light desktop (`WIDTH,HEIGHT = 1300,1450`, `OUT=/tmp/v1-top.png`) and Read it. Confirm the masthead/subtitle/coordinate line still render correctly (no layout shift). For dark mode, toggle the theme in a real browser at `http://127.0.0.1:4000/` and confirm the subtitle and coordinate line now read **dimmer** than body text (previously identical). Contrast targets: `#6b6b6b` on `#ffffff` ≈ 5.3:1; `#9aa0a6` on `#1c1c1d` ≈ 6.4:1 — both ≥ 4.5:1.

- [ ] **Step 7: Commit**

```bash
git add _sass/_variables.scss _sass/_themes.scss
git commit -m "Fix dark-mode secondary-text contrast; add notice-bg token

Dark mode set --global-text-color and --global-text-color-light to the same
value, flattening the secondary-text hierarchy. Introduce AA-compliant
secondary-text tokens (light #6b6b6b, dark #9aa0a6) and a notice-bg token.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 2: Unify section headings (A1)

**Files:**
- Modify: `_sass/_custom.scss` (insert a new block after section 7, the `.post > article > h2` rule that ends near the line `// 8. Links`)

**Interfaces:**
- Consumes: none. Produces: visual treatment only (no symbols).

- [ ] **Step 1: Add the content-section heading rule**

In `_sass/_custom.scss`, find the start of section 8:

```scss
// ---------------------------------------------------------------------------
// 8. Links — accent color, restrained underline; keep prose readable.
// ---------------------------------------------------------------------------
```

Insert this block **immediately before** it:

```scss
// ---------------------------------------------------------------------------
// 7b. Content section headings (markdown ## inside .clearfix) join the "news"
//     family: same accent-tick-on-a-hairline-rule device, but a larger serif
//     title so hierarchy reads (content sections > meta/overline sections).
// ---------------------------------------------------------------------------
.post > article > .clearfix > h2 {
  position: relative;
  font-family: $font-serif-display;
  font-weight: 600;
  font-size: 1.55rem;
  line-height: 1.22;
  letter-spacing: -0.005em;
  color: var(--global-text-color);
  padding-top: 0.85rem;
  padding-bottom: 0.55rem;
  margin-top: 2.8rem;
  margin-bottom: 1.3rem;
  border-bottom: 1px solid var(--global-divider-color);

  &::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 2.25rem;
    height: 2px;
    background-color: var(--global-theme-color);
  }
}

```

- [ ] **Step 2: Verify**

After the watch rebuild, screenshot (`1300,3600`, `OUT=/tmp/v2-full.png`) and Read it; crop the mid-page sections for detail:
```bash
convert /tmp/v2-full.png -crop 1300x900+0+1350 +repage /tmp/v2-joinlab.png
convert /tmp/v2-full.png -crop 1300x900+0+2300 +repage /tmp/v2-highlights.png
```
Confirm: **"joining the lab"** and **"research highlights"** now show a short accent tick at top-left + a full hairline rule beneath, as larger serif titles — visually a family with **NEWS** (which stays the small uppercase overline). No double rules or overlap; spacing above each section looks deliberate.

- [ ] **Step 3: Commit**

```bash
git add _sass/_custom.scss
git commit -m "Unify homepage section headings into one tick+rule system

Content headings (joining the lab / research highlights) fell through to the
generic serif h2 while 'news' used the overline treatment. Give content h2s
the same accent-tick-on-a-hairline-rule device at a larger serif size.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 3: Recruiting-notice component (B1 + D1 spacing)

**Files:**
- Modify: `_sass/_custom.scss` (append a new section at end of file)
- Modify: `_pages/about.md` (the callout `<div>` at the top of the body)

**Interfaces:**
- Consumes: `--global-notice-bg` (Task 1). Produces: `.recruiting-notice` wrapper class (referenced by Task 5's measure selector).

- [ ] **Step 1: Add the component styles**

Append to the end of `_sass/_custom.scss`:

```scss
// ---------------------------------------------------------------------------
// 16. Recruiting notice — the landing CTA as a quiet, finished component
//     (replaces the inline-styled div in about.md). Uses --global-notice-bg.
// ---------------------------------------------------------------------------
.recruiting-notice {
  background: var(--global-notice-bg);
  border-left: 3px solid var(--global-theme-color);
  border-radius: 4px;
  padding: 0.9rem 1.1rem;
  margin: 0.4rem 0 1.8rem;
  font-family: $font-serif-body;

  strong:first-child {
    color: var(--global-theme-color);
  }
}
```

- [ ] **Step 2: Swap the Markdown markup**

In `_pages/about.md`, find:

```html
<div style="border-left: 3px solid var(--global-theme-color); padding: 0.4rem 0.9rem; margin: 0 0 1.4rem;">
<strong>Prospective students:</strong> I am recruiting Ph.D. students (Fall 2026 / Spring 2027) and short-term Research Assistants (remote or onsite, 3 or 6 months). See <a href="/team/#Openning">openings and how to apply</a>.
</div>
```

Replace with:

```html
<div class="recruiting-notice">
<strong>Prospective students:</strong> I am recruiting Ph.D. students (Fall 2026 / Spring 2027) and short-term Research Assistants (remote or onsite, 3 or 6 months). See <a href="/team/#Openning">openings and how to apply</a>.
</div>
```

- [ ] **Step 3: Verify**

After rebuild, screenshot (`1300,1450`, `OUT=/tmp/v3-top.png`) and Read it. Confirm the callout now has: a faint accent-tinted background, rounded corner, comfortable padding, the **"Prospective students:"** label in accent color, and clear breathing room from the subtitle hairline above and the intro below. Light **and** dark (toggle in browser) should both look intentional — confirm `--global-notice-bg` dark (`#1f2733`) is legible, not muddy.

- [ ] **Step 4: Commit**

```bash
git add _sass/_custom.scss _pages/about.md
git commit -m "Refine recruiting callout into a quiet notice component

Move the inline-styled callout into a .recruiting-notice class: subtle accent
tint, accent label, generous padding and spacing. No copy change.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 4: Quiet the research-highlights link density (C2)

**Files:**
- Modify: `_pages/about.md` (wrap the highlights list)
- Modify: `_sass/_custom.scss` (append a new section)

**Interfaces:**
- Consumes: none. Produces: `.research-highlights` wrapper class (referenced by Task 5's measure selector).

- [ ] **Step 1: Wrap the highlights list (open)**

In `_pages/about.md`, find:

```markdown
## research highlights

- **quantum networking — algorithms for the quantum internet:**
```

Replace with:

```markdown
## research highlights

<div class="research-highlights" markdown="1">

- **quantum networking — algorithms for the quantum internet:**
```

- [ ] **Step 2: Wrap the highlights list (close)**

In `_pages/about.md`, find the final bullet (end of the file body):

```markdown
  - multi-fidelity feedback for sample-efficient learning ([NeurIPS'23](https://proceedings.neurips.cc/paper_files/paper/2023/hash/64602b87c31db70a3ef060f6c5d5b01d-Abstract-Conference.html)).
```

Replace with:

```markdown
  - multi-fidelity feedback for sample-efficient learning ([NeurIPS'23](https://proceedings.neurips.cc/paper_files/paper/2023/hash/64602b87c31db70a3ef060f6c5d5b01d-Abstract-Conference.html)).

</div>
```

- [ ] **Step 3: Add the scoped link/marker styles**

Append to the end of `_sass/_custom.scss`:

```scss
// ---------------------------------------------------------------------------
// 17. Research highlights — quiet the dense venue-link list so the theme
//     lead-ins read first. Scoped deeper than the global content-link rule
//     (.post > article > .clearfix a:not(.btn):not(.navbar-brand) is (0,4,2));
//     this selector is (0,5,2) and therefore wins.
// ---------------------------------------------------------------------------
.post > article > .clearfix > .research-highlights {
  a:not(.btn):not(.navbar-brand) {
    text-decoration: none;

    &:hover {
      text-decoration: underline;
      text-decoration-color: var(--global-theme-color);
    }
  }

  ::marker {
    color: var(--global-text-color-light);
  }
}
```

- [ ] **Step 4: Verify**

After rebuild, screenshot (`1300,3600`, `OUT=/tmp/v4-full.png`); crop:
```bash
convert /tmp/v4-full.png -crop 1300x1000+0+2300 +repage /tmp/v4-highlights.png
```
Read it. Confirm: in **research highlights**, venue links are no longer underlined (color only), the bold theme lead-ins and paper descriptions read first, list markers are muted grey, and links still underline on hover. Confirm the list content is intact (Kramdown processed the `markdown="1"` div — no raw `<div>` or unparsed bullets visible).

- [ ] **Step 5: Commit**

```bash
git add _pages/about.md _sass/_custom.scss
git commit -m "Quiet venue-link density in research highlights

Wrap the highlights list in .research-highlights and drop the link underlines
(color + hover carry the affordance), mute the list markers, so the research
themes read before the ~25 citations.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 5: One consistent reading measure + refresh stale comments (C1)

**Files:**
- Modify: `_sass/_custom.scss` (the existing measure rule in section 2, and its comment; plus the section-2 header comment)

**Interfaces:**
- Consumes: `.recruiting-notice` (Task 3), `.research-highlights` (Task 4) — both referenced in the selector. Produces: none.

- [ ] **Step 1: Replace the measure rule**

In `_sass/_custom.scss`, find:

```scss
// Comfortable measure for long-form prose inside the 800px column.
.post > article > .clearfix p,
.post-content p {
  max-width: 80ch;
}
```

Replace with:

```scss
// One consistent measure inside the 1000px column at 120% root — applied to
// prose, lists, and the two content wrappers so the right edge lines up
// (lists previously ran wider than paragraphs). Wrappers bound their inner
// lists even though those lists aren't direct children of .clearfix.
.post > article > .clearfix > p,
.post > article > .clearfix > ul,
.post > article > .clearfix > ol,
.post > article > .clearfix > .recruiting-notice,
.post > article > .clearfix > .research-highlights,
.post-content p {
  max-width: 72ch;
}
```

- [ ] **Step 2: Refresh the stale section-2 comment**

In `_sass/_custom.scss`, find:

```scss
// 2. Global base type — override the framework's Roboto on <body>.
//    16px base preserved; serif body with comfortable journal leading.
```

Replace with:

```scss
// 2. Global base type — override the framework's Roboto on <body>.
//    html is scaled to 120% root (section below); serif body, journal leading.
```

- [ ] **Step 3: Verify measure consistency**

After rebuild, screenshot (`1300,3600`, `OUT=/tmp/v5-full.png`) and Read it. Confirm the right edge of paragraphs, the two-network intro bullets, and the research-highlights bullets now align to the same measure (no list running wider than prose). Tune the value if needed: if the column feels too narrow, bump `72ch` to `74ch` and re-verify; if a list still overruns, confirm it is a direct child of `.clearfix` or wrapped by `.recruiting-notice` / `.research-highlights`.

- [ ] **Step 4: Final full-page + mobile regression pass**

```bash
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$CHROME" --headless=new --hide-scrollbars --no-first-run --no-default-browser-check \
  --user-data-dir=/tmp/cshot --window-size=1300,3600 --screenshot=/tmp/v5-desktop.png "http://127.0.0.1:4000/" 2>/dev/null
"$CHROME" --headless=new --hide-scrollbars --no-first-run --no-default-browser-check \
  --user-data-dir=/tmp/cshot-m --window-size=430,4000 --screenshot=/tmp/v5-mobile.png "http://127.0.0.1:4000/" 2>/dev/null
```
Read both. Confirm desktop + mobile both look clean and nothing regressed. Spot-check one other page that shares the CSS (e.g. `http://127.0.0.1:4000/publications/`) for the secondary-text change — confirm it reads as an improvement, not a regression.

- [ ] **Step 5: Commit**

```bash
git add _sass/_custom.scss
git commit -m "Apply one consistent ~72ch measure to prose and lists

Cap prose, lists, and the content wrappers at the same measure so the right
edge aligns (lists no longer run wider than paragraphs). Refresh stale 800px /
16px comments to the current 1000px column at 120% root.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Post-implementation

- [ ] Optional: run the `web-design-guidelines` skill on the changed CSS for an accessibility/UX pass.
- [ ] Stop the preview server: `pkill -f "jekyll serve"`.
- [ ] Use the `finishing-a-development-branch` skill to decide how to integrate `homepage-polish` (merge to `master` / open PR / etc.).

## Self-Review (completed by plan author)

**Spec coverage:** A1 → Task 2; A2 → Task 1; B1 → Task 3; C1 → Task 5; C2 → Task 4; D1 → folded into Task 3 (`.recruiting-notice` margins); D2 (mobile reorder) → intentionally dropped per spec, no task. All spec sections covered.

**Placeholder scan:** No TBD/TODO; every code step shows complete SCSS/Markdown and exact commands. The one tunable (`72ch` → `74ch`) is an explicit, bounded verification adjustment, not a placeholder.

**Type/selector consistency:** `--global-notice-bg` defined in Task 1, consumed in Task 3 ✓. `.recruiting-notice` created in Task 3, referenced in Task 5 measure ✓. `.research-highlights` created in Task 4, referenced in Task 5 measure ✓. Section-heading selector `.post > article > .clearfix > h2` and measure/`.research-highlights` selectors all use the same `.post > article > .clearfix` root ✓. Specificity claims for the highlights override verified ((0,5,2) > global (0,4,2)).
