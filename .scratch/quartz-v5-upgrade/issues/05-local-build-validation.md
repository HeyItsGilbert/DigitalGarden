Type: task
Status: resolved
Blocked by: 04
Assignee: Gilbert (agent session)

## Question

Run `npx quartz build` (and `npx quartz serve` for a visual pass) on the branch from ticket
04. Iterate until: the build succeeds, `content/` renders and is browsable end to end, and
the fork's visual customizations (theme colors, custom CSS from the ticket-02 keep-list) are
visibly present. This is the acceptance bar from the charting session — no automated test
suite, no feature-parity audit required.

Log anything fixed along the way; if a fix requires a decision beyond "make the build pass"
(e.g. a customization from 02 doesn't fit v5's new architecture at all), spin a fresh ticket.

## Answer

Ran on branch `v5-migration` (ticket 04's branch). Build succeeded on the first pass (350
files, 1512 emitted) but with one warning; found and fixed two issues while validating —
both "make the build/visuals pass" fixes per this ticket's own instructions, not new
decisions:

1. **`@quartz-community/obsidian-plugin-excalidraw` was never actually installed** —
   referenced in `quartz.config.yaml` (ticket 04's config translation) but missing from
   `package.json`/`node_modules`, causing a repeated "Could not load plugin... Skipping"
   warning during build. `npx quartz plugin install --from-config` falsely reported
   "All configured plugins are already installed" (CLI bug — didn't verify the package
   actually resolves); fixed with a direct `npm install
   @quartz-community/obsidian-plugin-excalidraw@^0.1.0`. Rebuild: warning gone, 1514 files
   emitted (2 more than before — the plugin now runs). The `content/Excalidraw/MOC's.svg`
   asset itself was already serving fine either way (raw SVG passthrough, unaffected by the
   category-detection plugin).

2. **FontAwesome was never loaded — the tofu-box icons ticket 04 flagged as unverified were
   in fact missing.** Ticket 02's keep-list ported `site_link_icon.scss`/`custom.scss`
   (which reference `font-family: FontAwesome`) but not their dependency: the fork's
   `Head.tsx` had CSP + preconnect/dns-prefetch + a Font Awesome Kit `<script>`
   (`kit.fontawesome.com/1c9394c211.js`) that ticket 02 didn't identify as part of the same
   customization (`Head.tsx` is a layout-primitive file, still directly portable per the
   map's v5-architecture note — just wasn't diffed for this). Diffed `main`'s `Head.tsx`
   against v5's to isolate the exact addition (CSP meta + 3 lines) and ported it verbatim
   into `quartz/components/Head.tsx`. Confirmed visually: the blog-link rocket icon and
   footer Blog/LittleLink icons render as glyphs, not missing-glyph boxes, both
   before/after screenshots compared.

Visual pass (via headless browser against `npx quartz build --serve`, since v5 renamed
`quartz serve` → `quartz build --serve`):
- Home page: theme colors (dark Flexoki-style palette), typography, Recent Notes, Graph
  View, Table of Contents, Backlinks, giscus comment widget ("Sign in with GitHub") all
  present and styled per the fork's `custom.scss`.
- `Atomics/` folder listing: renders full tag-pill list, ~90 entries, browsable.
- Excalidraw SVG: serves directly as `image/svg+xml`, renders standalone.
- FontAwesome icons: confirmed live post-fix (see above).

**Known, deliberately unfixed (already logged in ticket 04, reconfirmed here, not new
scope):** Readwise notes (e.g. "Neuromancer", "A Gathering of Shadows") appear in Recent
Notes — the community `recent-notes` plugin has no declarative folder-exclude, so the
fork's `!f.slug?.startsWith("Readwise/")` filter has no home without a local plugin.
Cosmetic only, not a build/render blocker, not addressed here — stays a known gap unless a
future ticket decides to re-author it as a local plugin.

Acceptance bar met: build succeeds, `content/` renders and is browsable, fork's visual
customizations are present. Fixes committed on `v5-migration`
(`install missing excalidraw plugin dep, restore FontAwesome kit script/CSP in Head.tsx`).
