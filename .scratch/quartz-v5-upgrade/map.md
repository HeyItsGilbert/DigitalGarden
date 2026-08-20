# Map: Quartz v5 upgrade

## Destination

`main` runs on upstream Quartz v5 (currently `upstream/v5` @ `31b835c8e`, merge-base with `main` is `bf5a556c` — see Notes for a merge-base mixup that was caught and corrected),
with all garden content (`content/`) intact and every genuine fork customization re-applied
on top — as `quartz.config.yaml` values (v5 has no `.ts` config anymore) and, for anything
beyond config, as **local v5 plugins** (`npx quartz plugin add ./plugins/<name>`), since v5's
plugin architecture doesn't support patching most former core files directly (see Notes).
Reached via the official `quartz create` migration path (fresh v5 checkout + "Copy" content
strategy), not a git merge or patch-apply — the fork-delta bucketing from ticket 01 is still
useful as the *inventory* of what to consider re-authoring, just not as literal patches to
apply.

## Notes

- Terminology:
  - **fork-delta** — the single squashed patch representing everything `main` has that
    `upstream` (at the merge-base `bf5a556cc15edd311cf5cb7faab2509569e6af0a`, 2024-01-28) didn't: `git diff bf5a556c..main`.
  - **content boundary** — `content/` is the fork's, applied wholesale via the `quartz
    create` wizard's "Copy" content strategy. `quartz.config.ts`/`quartz.layout.ts` don't
    exist in v5 (see the v5-architecture note below) — their *values* get translated into
    `quartz.config.yaml` by hand, not diffed as files. Everything else under `quartz/`
    defaults to upstream's version unless a ticket explicitly carves out an exception.
  - **upstream v5** — `upstream/v5` remote-tracking branch; note `upstream/v4` is a *stale
    sibling*, not an ancestor of v5 (diverged at `ec00a40`), so v4 history is irrelevant here.
- **Merge-base correction:** ticket 01 initially computed the fork-delta against
  `ec00a40a` — that's `merge-base(upstream/v4, upstream/v5)` (where v4/v5 diverged from each
  other), not `merge-base(main, upstream/v5)`. Caught while resolving ticket 02, when it
  produced 34 spurious-looking `quartz/`-tree "deletions" including files that resembled
  core upstream features. Real merge-base is `bf5a556c` (712 commits earlier); all fork-delta
  buckets were regenerated against it. Any ticket that consumed the fork-delta before this
  point needs its numbers treated as stale — check the ticket's own Answer for a correction
  note before trusting file counts.
- A live merge attempt (`git merge upstream/v5 --no-ff`) surfaced ~150 conflicted files —
  upstream v5 moved most of `quartz/components` + `quartz/plugins` into an installed package
  (`@quartz-community/content-index`), so this is a structural rewrite, not incremental drift.
  That merge was aborted; nothing from it is kept.
- rerere is *not* expected to carry weight here — the restructure is one-time, not a repeated
  pattern across 421 commits. Squash-first was chosen specifically to avoid replaying it.
- Skills to consult while resolving tickets: `/grilling`, `/domain-modeling` for decision
  tickets. `/research` (ticket 08) already fired once, resolved directly in-session rather
  than via a subagent — reading two doc pages didn't warrant the dispatch overhead.
- Acceptance bar (from grilling): `npx quartz build` succeeds locally, `content/` renders
  intact, and the fork's visual customizations (theme / custom CSS) are present. No automated
  test suite or feature-parity audit required.
- **v5 architecture (ticket 08 research, changes the whole plan):** config is YAML now
  (`quartz.config.yaml`, no `quartz.layout.ts`). Most v4 built-ins (`ofm.ts`, `gfm.ts`,
  `latex.ts`, `Explorer`/`Graph`/`Search`/`Backlinks`/`Darkmode`/`Footer`/`TableOfContents`
  components, page types) moved to standalone `quartz-community` plugin repos, installed via
  `npx quartz plugin add` and referenced as `ExternalPlugin.X()`/`Plugin.X()` in the YAML —
  confirmed these files no longer exist locally in `upstream/v5`'s tree. A handful of
  "internal" pieces are unchanged and still live locally: `quartz/build.ts`,
  `quartz/plugins/emitters/{assets,componentResources,helpers,static}.ts`, layout-primitive
  components (`Body`, `Head`, `PageList`, etc.) — these *are* still directly diffable/
  portable the old way. Everything else that used to be a core file the fork customized
  (`ofm.ts`, `search.inline.ts`/`search.scss`, etc.) has no file to patch anymore; keeping
  that behavior means re-authoring it as a **local plugin** — `npx quartz plugin add
  ./path/to/plugin` symlinks a local directory into `.quartz/plugins/`, no GitHub repo
  required, conforming to the `QuartzTransformerPlugin`/etc. interfaces from
  `@quartz-community/types`. CI needs a new `npx quartz plugin install` step before
  `npx quartz build`. Full detail: ticket 08.

## Decisions so far

- [Extract fork-delta](.scratch/quartz-v5-upgrade/issues/01-extract-fork-delta.md) — 586-path diff (against the *corrected* merge-base `bf5a556c`) bucketed into `content`/`config`/`quartz-tree`/`docs-framework`/`infra`/`docs-personal` under `.scratch/quartz-v5-upgrade/fork-delta/`; surfaced a new finding (`docs/` mixes upstream framework docs with fork-personal content) spun into ticket 07, which now also blocks ticket 04. Ticket itself records a merge-base correction made mid-flight — see its Answer.
- [v5 plugin architecture](.scratch/quartz-v5-upgrade/issues/08-v5-plugin-architecture.md) — config is YAML, most v4 core files became external `quartz-community` plugins (no longer locally patchable), local plugins are still fully supported via `npx quartz plugin add ./path`, official migration path is the `quartz create` wizard not a merge/patch. Invalidated ticket 02/04's original file-patch framing — both rewritten.
- [Triage quartz-tree customizations](.scratch/quartz-v5-upgrade/issues/02-triage-quartz-tree-customizations.md) — keep-list: `Comments.tsx`, `grid_callouts.scss`, `site_link_icon.scss`, `contentMeta.scss` (ported as plain files), plus the OFM customization re-authored as a local plugin. Everything else (depgraph, citations, checkbox script, fork's i18n set, search/build.ts/componentResources.ts/explorer/renderPage customizations, and the ~70-file long tail) drops in favor of upstream v5.
- [Decide CI/deploy/docs handling](.scratch/quartz-v5-upgrade/issues/03-decide-ci-deploy-docs-handling.md) — everything outside the content boundary needs no reconciliation: `package.json`, `Dockerfile`, `tsconfig.json`, `index.d.ts`, `globals.d.ts`, `README.md`, framework-docs `docs/` subset, and `ci.yaml` all take upstream v5 wholesale (verified vanilla via `git log`; Dockerfile is unused — deploy is Netlify dashboard-integration, no `netlify.toml` in-repo); `.vscode/tasks.json`, `.devcontainer/devcontainer.json`, `.github/dependabot.yml` port unchanged (genuine fork customization, quartz-independent); deleted OSS scaffolding stays deleted.
- [Docs-personal content fate](.scratch/quartz-v5-upgrade/issues/07-docs-personal-content-fate.md) — `docs/atomics`, `docs/how-to`, `docs/reviews`, `docs/graph.md`, `docs/Changelog.md` (18 files) all drop entirely: every file already has a newer live counterpart in `content/Atomics`/`content/How To`/`content/Reviews` (verified by name + diff, `content/` last touched months after `docs/`); `graph.md`/`Changelog.md` are dead Jan-2024 scaffolding with wikilinks into the old pre-`content/`-boundary layout. Not a migration decision — cleanup of leftovers from a move that already happened.
- [Apply fork delta onto v5](.scratch/quartz-v5-upgrade/issues/04-apply-fork-delta-onto-v5.md) — executed on branch `v5-migration` (off `upstream/v5`, not merged onto `main` — that's ticket 06), committed as WIP. `npx quartz build` succeeds (350 files, 1512 emitted). Revised ticket 02's keep-list after inspecting v5 reality: `Comments.tsx` became pure YAML (giscus options map 1:1), OFM customization dropped entirely — verified upstream's `@quartz-community/obsidian-flavored-markdown` already natively ships `enableCheckbox`/arrow-mapping/YouTube-playlist support the fork's 306-line diff added, no local plugin needed — `contentMeta.scss` dropped (upstream's version is near-identical), `grid_callouts.scss`/`site_link_icon.scss`/`custom.scss` (the whole file, not just the two `@use`d partials) ported with one variable-rename fix (`$mobileBreakpoint` → `$mobile`). One known regression: Recent Notes lost its Readwise-folder exclusion filter (no declarative equivalent in the community plugin's options). Left a checklist in the ticket's Answer for ticket 05 to verify visually.
- [Local build validation](.scratch/quartz-v5-upgrade/issues/05-local-build-validation.md) — `npx quartz build`/`--serve` (v5 renamed `serve`→`build --serve`) validated end to end on `v5-migration`; found and fixed two real gaps missed by ticket 04: the excalidraw plugin was referenced in config but never actually installed (`quartz plugin install --from-config` falsely claimed it was), and FontAwesome was never loaded (ticket 02's keep-list ported the CSS rules but not `Head.tsx`'s CDN kit script/CSP — now ported, diffed against fork `main`). Visual pass confirmed theme, layout, comments, and icons all present. Readwise-in-Recent-Notes regression reconfirmed as a known, deliberately unfixed cosmetic gap (needs a local plugin to resolve, not in scope here).

## Not yet specified

- Whether to fast-forward `main` onto the patched v5 result or land it as a new branch with
  `main` retagged for rollback — sharp enough to ticket (06), not left fogged.

## Out of scope

(none yet)
