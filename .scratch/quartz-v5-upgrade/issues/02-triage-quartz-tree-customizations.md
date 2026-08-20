Type: grilling
Status: resolved
Blocked by: 01

## Question

For each file in bucket (c) from ticket 01 (fork changes under `quartz/` outside the config
files) — decide keep-and-port-forward vs. let-upstream-overwrite. The content-boundary
decision defaults everything here to "upstream overwrites", but that default was chosen
before seeing the actual file list; confirm it holds file-by-file, especially for anything
substantial (e.g. `quartz/styles/custom/grid_callouts.scss` at 462 lines,
`quartz/styles/custom/site_link_icon.scss`, fork-added `quartz/i18n/locales/*`,
`quartz/util/theme.ts`, `quartz/util/log.ts`, `quartz/worker.ts`, and anything else 01 turns
up).

Output: a short keep-list (files + one-line reason) that ticket 04 ports forward on top of
upstream v5; everything not on the keep-list is dropped in favor of upstream's version.

## Answer

Resolved in two rounds after ticket 08's research corrected the mental model (v5 moved most
former core files to external `quartz-community` plugins — no local file to patch for most
of the 81 modified files).

**Keep-list** (ticket 04 ports these onto v5):
- `quartz/components/Comments.tsx` (new file)
- `quartz/styles/custom/grid_callouts.scss` (462 lines, new file)
- `quartz/styles/custom/site_link_icon.scss` (new file)
- `quartz/components/styles/contentMeta.scss` (new file)
- OFM customization from `quartz/plugins/transformers/ofm.ts` (306-line diff) — **not**
  portable as a file patch (ofm.ts doesn't exist locally in v5); must be re-authored as a
  local plugin (`npx quartz plugin add ./plugins/<name>`) layered on top of
  `ExternalPlugin.ObsidianFlavoredMarkdown()`. This is real engineering work: first read
  what the 306 lines actually do, then reproduce it against v5's transformer plugin
  interface.

**Drop-list** (upstream v5's version/absence wins, no porting):
- New-file candidates not selected: `quartz/depgraph.ts` + `depgraph.test.ts` (dependency
  graph feature), `quartz/plugins/transformers/citations.ts`,
  `quartz/components/scripts/checkbox.inline.ts`, the full fork-added i18n locale set
  (`i18n/index.ts`, `definition.ts`, 22 locale files — superseded by upstream v5's own i18n
  system, which ships overlapping locale filenames).
- Large-diff candidates not selected: search customization (`search.inline.ts` 455 lines +
  `search.scss` 195 lines — use stock `Plugin.Search()`), `build.ts` (229 lines) and
  `componentResources.ts` (167 lines — use v5's stock versions even though these two still
  exist locally and would have been cheap to port), `explorer.inline.ts` (158 lines),
  `renderPage.tsx` (87 lines).
- The long tail (~70 remaining modified files under `quartz/`, all under ~50 lines) — dropped
  wholesale, confirmed after seeing ticket 08's internal/community split: most of these touch
  files that don't exist locally in v5 anyway. If build/visual validation (ticket 05) surfaces
  a real regression traceable to one of these, port that single file forward then.
