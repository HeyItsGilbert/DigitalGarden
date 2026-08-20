# Fork-delta buckets

`git diff <merge-base>..main`, split into pathspec-based patch files.

**Correction (found while resolving ticket 02):** the merge-base originally used here
(`ec00a40a`) was wrong — that's `merge-base(upstream/v4, upstream/v5)` (where upstream's own
v4 and v5 lines diverged from each other), not `merge-base(main, upstream/v5)`. The real
merge-base is **`bf5a556c`** (2024-01-28), 712 commits earlier on the upstream v4 line. All
buckets below were regenerated against the correct base. 586 changed paths total (was 633
under the wrong base), all accounted for (verified: `--name-only` count for the full diff
equals the count when scoped to the union of these pathspecs).

One consequence of the wrong base: it made 34 `quartz/`-tree files look fork-deleted
(`fileTrie.ts`, `og.tsx`, `emoji.ts`, `favicon.ts`, `ogImage.tsx`, giscus CSS, several i18n
locales, etc.) — alarming, since some looked like core upstream features. Under the correct
base **none of those are deletions**: those files never existed at `bf5a556c` either — they
were added by upstream and then removed/renamed again entirely on upstream's own timeline,
outside anything `main` did. `quartz/` tree diff is cleanly 28 additions + 81 modifications,
zero deletions.

| File | Pathspec | Files | Consumed by |
|---|---|---|---|
| `a-content.patch` | `content` | 350 | applied wholesale (content boundary) |
| `b-config.patch` | `quartz.config.ts`, `quartz.layout.ts` | 2 | ticket 04, reconciled against v5's config shape |
| `c-quartz-tree.patch` | `quartz` | 109 (28 added, 81 modified) | ticket 02 (triage keep/discard) |
| `c-docs-framework.patch` | `docs/{advanced,features,plugins}`, `docs/{configuration,hosting,index,showcase}.md`, `docs/tags` | ~58 | ticket 03 |
| `c-infra.patch` | `.github`, `.vscode`, `.devcontainer`, `README.md`, `CODE_OF_CONDUCT.md`, `Dockerfile`, `tsconfig.json`, `index.d.ts`, `globals.d.ts`, `package.json`, `package-lock.json`, `.node-version` | ~10 | ticket 03 |
| `d-docs-personal.patch` | `docs/atomics`, `docs/how-to`, `docs/reviews`, `docs/Changelog.md`, `docs/graph.md` | 18 | ticket 07 |

## `quartz/`-tree breakdown for ticket 02 (109 files, correct base)

**28 additions** — genuinely new to the fork, not present at `bf5a556c`:
- Whole new features: `quartz/depgraph.ts` + `depgraph.test.ts` (228+118 lines — dependency
  graph), `quartz/plugins/transformers/citations.ts` (citation support),
  `quartz/components/Comments.tsx`, `quartz/components/scripts/checkbox.inline.ts` (Obsidian
  checkbox rendering).
- Styling: `quartz/styles/custom/grid_callouts.scss` (462 lines),
  `quartz/styles/custom/site_link_icon.scss`, `quartz/components/styles/contentMeta.scss`.
- Full i18n locale set: `quartz/i18n/index.ts`, `definition.ts`, and 22 locale files
  (`ar-SA`…`zh-CN`, ~82-96 lines each). **Note:** upstream v5 ships its own i18n system with
  overlapping locale filenames (confirmed by the earlier aborted merge attempt, which showed
  these as `AA` — both-sides-added — conflicts). This looks like the fork independently built
  i18n in parallel with upstream rather than a divergent translation effort; likely
  superseded by upstream's, not merged content-by-content.

**81 modifications**, ranked by size — top of the list looks like real customization, the
long tail is ambiguous:
- Large, likely-real customization: `quartz/components/scripts/search.inline.ts` (455
  lines), `quartz/plugins/transformers/ofm.ts` (306 — Obsidian-flavored-markdown behavior),
  `quartz/build.ts` (229), `quartz/components/styles/search.scss` (195),
  `quartz/plugins/emitters/componentResources.ts` (167), `quartz/styles/custom.scss` (159),
  `quartz/components/scripts/explorer.inline.ts` (158), `quartz/components/renderPage.tsx`
  (87).
- Long tail (~70 files, mostly under 50 lines changed): the rest of `quartz/components/*`,
  `quartz/plugins/{emitters,transformers}/*`, `quartz/util/*`. `main` was on the upstream v4
  line for a long time and absorbed real upstream v4 development through periodic sync
  merges (visible in `git log --all --merges` history) — this diff can't distinguish "the
  fork's own hand-written tweak" from "upstream v4 code `main` already merged in that v5 has
  now superseded anyway". Treating the whole tail as low-confidence, default-to-drop unless
  the user flags a specific file.
