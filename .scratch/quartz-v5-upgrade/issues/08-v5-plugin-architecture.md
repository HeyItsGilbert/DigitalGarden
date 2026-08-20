Type: research
Status: resolved

## Question

How does Quartz v5 support custom, locally-authored code (transformers, emitters,
components) that isn't published to `quartz-community` — is there any way to keep
fork-specific logic (depgraph, citations transformer, OFM tweaks, custom search behavior,
etc.) at all, or is v5's plugin model closed to anything not an external package?

## Answer

Read the official [Migrating to Quartz 5](https://quartz.jzhao.xyz/getting-started/migrating)
guide and the v5 `docs/advanced/making plugins.md` + `docs/cli/plugin.md` (read directly from
`upstream/v5`'s tree). Key facts, all of which reshape tickets 02/03/04:

1. **Config format changed entirely**: `quartz.config.ts` + `quartz.layout.ts` (TypeScript)
   are gone in v5, replaced by a single `quartz.config.yaml`. Layout position is now a
   per-plugin property in that YAML, not a separate layout file. The content-boundary
   decision named the two `.ts` files as "the fork's" — that's now moot; there's nothing to
   diff them against. Ticket 04 needs to *translate* the fork's config *values* into YAML,
   not port the files.

2. **Most v4 built-in plugins moved to standalone `quartz-community` git repos**, installed
   via `npx quartz plugin add github:...` and referenced in `quartz.config.yaml` as
   `ExternalPlugin.X()`. Confirmed by inspecting `upstream/v5`'s actual tree:
   `quartz/plugins/transformers/` is now just a stub `index.ts` — `ofm.ts`, `gfm.ts`,
   `latex.ts`, etc. don't exist locally anymore. `quartz/components/` lost `Explorer.tsx`,
   `Graph.tsx`, `Search.tsx`, `Backlinks.tsx`, `Darkmode.tsx`, `Footer.tsx`,
   `TableOfContents.tsx` — all now `Plugin.X()` community components.
   **This means the fork's line-diffs against `ofm.ts` (306 lines) and
   `search.inline.ts`/`search.scss` (455+195 lines) have no file to apply onto anymore** —
   those customizations, if kept, must be re-authored as a plugin override/extension, not
   patched.

3. **A few "Internal" pieces are unchanged and still live locally** — confirmed present in
   `upstream/v5`'s actual tree: `quartz/build.ts`, `quartz/plugins/emitters/{assets,
   componentResources,helpers,static}.ts`, `quartz/components/{Body,Head,PageList,...}.tsx`
   (layout primitives only). **The fork's `build.ts` (229 lines) and
   `componentResources.ts` (167 lines) diffs are still directly portable** the traditional
   way — these files exist in both.

4. **Locally-authored plugins are fully supported, not just `quartz-community` ones**:
   `npx quartz plugin add ./path/to/my-plugin` symlinks a local directory into
   `.quartz/plugins/` — no need to publish to GitHub. This is the path for keeping
   depgraph, the citations transformer, custom OFM behavior, etc., if wanted: package each
   as a small local plugin under the plugin interface (`QuartzTransformerPlugin`,
   `QuartzEmitterPluginInstance`, etc. from `@quartz-community/types`), not a copy-paste into
   `quartz/`.

5. **Official migration path** is `quartz create` (interactive wizard: pick a template, pick
   "Copy" content strategy pointing at a backed-up `content/`) rather than a git merge/patch.
   Then `npx quartz plugin install --from-config` to pull every plugin the generated config
   references.

6. **CI needs a new step**: `npx quartz plugin install` (or `--from-config`) before
   `npx quartz build`, plus optional caching keyed on `quartz.lock.json`.

7. **URL casing changed**: v5 lowercases/hyphenates all generated URLs (v4 preserved
   original casing). The `AliasRedirects` plugin (community, enabled by default) auto-
   generates redirects for old-cased URLs, so this is handled, not a new decision — noted for
   awareness only, not spun into a ticket.

These facts invalidate the original framing of ticket 02 (diff-by-file triage) and ticket 04
(patch-apply) — see the ticket 02 re-grill and ticket 04 rewrite that followed.
