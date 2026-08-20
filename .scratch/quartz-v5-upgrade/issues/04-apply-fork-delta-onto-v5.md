Type: task
Status: resolved
Blocked by: 01, 02, 03, 07

## Question

Follow the *official* v5 migration path (ticket 08), not a patch-apply:

1. Back up `content/` outside the repo, then set up the v5 branch per the migration guide
   (`git fetch upstream v5`, fresh branch off `upstream/v5`, `npm i`).
2. Run `npx quartz create` — pick the template closest to the fork's old setup, "Copy"
   content strategy pointing at the backed-up `content/`.
3. Translate `quartz.config.ts`/`quartz.layout.ts`'s *values* (not the files — they don't
   exist in v5) into the generated `quartz.config.yaml`, using the migration guide's plugin
   reference table to map old `Plugin.X()`/`Component.X()` calls to their
   `ExternalPlugin.X()`/`Plugin.X()` v5 equivalents.
4. `npx quartz plugin install --from-config` to pull every referenced plugin.
5. Port ticket 02's keep-list: copy `Comments.tsx`, `grid_callouts.scss`,
   `site_link_icon.scss`, `contentMeta.scss` into their v5 locations directly (these are
   still plain local files); re-author the OFM customization as a local plugin
   (`npx quartz plugin add ./plugins/<name>`) layered on `ExternalPlugin.
   ObsidianFlavoredMarkdown()` — read the original 306-line `ofm.ts` diff first to know what
   behavior to reproduce.
6. Apply the ticket-03 decision for CI/Docker/docs/infra, including the new
   `npx quartz plugin install` CI step the migration guide calls out.
7. Apply the ticket-07 decision for `docs/`'s fork-personal content.

Resolve any conflicts/placement questions that come up doing this as part of the task; if a
genuinely new decision surfaces (not covered by 01/02/03/07/08), spin it into a fresh ticket
rather than guessing.

## Answer

Executed on branch `v5-migration` (created off `upstream/v5` @ `075afd3f7`, not `main`),
committed as a single WIP commit — **not merged/fast-forwarded onto `main`**, that's ticket
06's call.

1. Backed up `content/` (369 files) to `%TEMP%\DigitalGarden-content-backup`, branched, `npm i`.
2. `npx quartz create -t obsidian -X copy -s <backup> -b garden.gilbertsanchez.com -l
   shortest` — non-interactive via CLI flags (checked `--help` first, no need to drive the
   wizard's prompts). `obsidian` template chosen: closest baseline to the fork's OFM/wikilink
   setup, and it happened to already ship `comments`, `note-properties`, and
   `obsidian-plugin-excalidraw` plugins matching fork usage.
3. Config translation (`quartz.config.ts`/`quartz.layout.ts` values → `quartz.config.yaml`):
   pageTitle, `enableSPA: false`, `analytics: null` (fork ran no analytics), `defaultDateType:
   created`, theme typography (Titillium Web/Bitter/JetBrains Mono) + full light/dark color
   palette, footer links (Blog/LittleLink), `explorer.folderClickBehavior: link`, enabled
   `tag-list` (was in fork's beforeBody, template had it off), enabled `recent-notes` (limit
   5, showTags false — **dropped** the fork's `filter: (f) =>
   !f.slug?.startsWith("Readwise/")** since the community plugin's options schema has no
   declarative folder-exclude, only `hideTagPages`/`hideFolderPages`; re-authoring a local
   plugin for one cosmetic sidebar filter wasn't worth it — Readwise notes will now appear in
   Recent Notes, flagging for ticket 05's visual check), enabled `comments` (provider
   giscus, options translated directly from `Comments.tsx`'s data attributes — repo, repoId,
   category, categoryId, mapping: pathname, strict: false).
4. `npx quartz plugin install --from-config` — no-op, template pre-bundled everything
   referenced.
5. Keep-list, revised from ticket 02's plan after inspecting what's actually still true in
   v5:
   - **`Comments.tsx` → pure YAML**, not a ported file: the `@quartz-community/comments`
     plugin's `provider: giscus` options map 1:1 to the fork's script's `data-*` attributes.
     Simpler and more correct than porting a file.
   - **`grid_callouts.scss`, `site_link_icon.scss`** ported verbatim into new `quartz/styles/
     custom/`. Build failed once: `grid_callouts.scss` referenced `$mobileBreakpoint`, which
     v5's `variables.scss` renamed/restructured into a `$breakpoints` map + `$mobile`/
     `$tablet`/`$desktop` media-query strings. Fixed the one usage: `@media all and
     (max-width: $mobileBreakpoint)` → `@media #{$mobile}`.
   - **`custom.scss`** (the file that `@use`s the two above) carried far more fork content
     than ticket 02's keep-list named — the Flexoki color variables, MOC image styling,
     sidebar recent-notes sizing, dark/light tag-link coloring, and Explorer FontAwesome
     icons all live inline in `custom.scss` itself, not in a separate file. Ticket 02 named
     the two `@use`d partials but not their parent; treated this as the same "keep visual
     customizations" call already made (matches the map's grilled acceptance bar: "the
     fork's visual customizations... are present"), not a new decision — ported the whole
     file.
   - **`contentMeta.scss` → dropped, not ported.** Inspected the installed
     `@quartz-community/content-meta` package's bundled CSS: it already ships
     `.content-meta { margin-top: 0; color: var(--darkgray); }` plus the same
     `[show-comma=true]` comma-separator rule. Only real difference from the fork's version
     was `var(--gray)` vs `var(--darkgray)` — not worth a component-scoped override for one
     color token.
   - **OFM customization → not re-authored as a local plugin, contrary to tickets 02/08's
     plan.** Read the full 306-line `ofm.ts` diff, then checked the installed
     `@quartz-community/obsidian-flavored-markdown` package's `dist/index.js` directly:
     `enableCheckbox` (with the exact same `checkbox-toggle` class + localStorage-persisted
     checked-state script) is now a native option (already `true` in the generated config).
     Arrow-mapping (`rArr`/`lArr`/etc HTML entities), YouTube playlist-embed support
     (identical `?list=` URL construction), and the general callout/table-wikilink rework are
     all present natively. The fork's OFM diff, written against a much older v4 base, has
     been substantially absorbed by upstream's own v5 rewrite. This is a factual correction
     (verified by reading the shipped bundle), not a fresh tradeoff — no new ticket needed,
     and it eliminates what would have been the task's largest chunk of engineering work.
6. Ticket-03 CI/Docker/docs/infra decision: nothing to actively port — the CI workflow,
   `package.json`, `Dockerfile`, `tsconfig.json`, etc. are upstream's v5 versions by
   construction (fresh branch off `upstream/v5`, not a merge). Confirmed the CI workflow
   already has the `npx quartz plugin install` step ticket 08 said the migration guide
   calls for — no manual addition needed. Ported `.vscode/tasks.json`,
   `.devcontainer/devcontainer.json`, `.github/dependabot.yml` unchanged (untouched by
   `quartz create`, since it only writes `quartz.config.yaml` + copies `content/`).
7. Ticket-07 docs-personal decision: also satisfied by construction — `docs/` here is
   upstream's framework docs only; the old fork's `docs/atomics` etc. were never copied
   (only `content/` was, via the backup), so there was nothing to delete.

`npx quartz build` succeeds: 350 markdown files parsed, 1512 files emitted to `public/`.
One non-fatal warning repeated during the build: `Could not load plugin
"@quartz-community/obsidian-plugin-excalidraw" to detect category. Skipping.` — didn't
block the build or omit Excalidraw content; flagging for ticket 05 to check whether
Excalidraw embeds actually render.

**Known items for ticket 05 (local build validation) to check visually:** Recent Notes
including Readwise entries (regression, noted above); the Excalidraw plugin warning;
whether FontAwesome (used by `site_link_icon.scss` and the Explorer icon styling) is still
loaded in v5 — didn't verify the font is actually available, only that the CSS references
compile.
