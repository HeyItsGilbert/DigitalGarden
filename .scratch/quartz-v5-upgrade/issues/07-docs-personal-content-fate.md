Type: grilling
Status: resolved

## Question

Ticket 01 found that `docs/` isn't purely upstream's framework docs — it also holds fork-only
personal content that predates (or was just never moved into) `content/`: `docs/atomics/`
(atomic notes), `docs/how-to/`, `docs/reviews/` (book reviews), `docs/Changelog.md`,
`docs/graph.md`. None of these paths exist in `upstream/v5` or the merge-base.

Decide their fate now that `main` is moving wholesale onto v5's `docs/` (ticket 03 territory
for the framework-doc subset of `docs/`):
- Move them into `content/` (they're garden content, same as `content/Atomics`) — likely the
  cleanest fit given the content-boundary decision already treats `content/` as the one
  preserved-content directory.
- Or keep a `docs/` carve-out alongside upstream's `docs/` (mixed directory, more error-prone
  going forward since future `upstream/v5` docs changes will keep conflicting with it).
- Or something else entirely (e.g. these are stale/abandoned and can be dropped).

See `.scratch/quartz-v5-upgrade/fork-delta/d-docs-personal.patch` and the "Finding" section
of `.scratch/quartz-v5-upgrade/fork-delta/README.md` for the exact file list.

## Answer

Grilled (single round — facts settled it, not a real tradeoff): **drop all 18 files
entirely**, don't move to `content/` and don't carve out a `docs/` exception.

Verified every file already has a newer live counterpart already in `content/`:
- `docs/atomics/*` (15 files) — all 15 basenames exist in `content/Atomics` (a few
  case/rename variants: `mqtt.md`→`MQTT.md`, `permav.md`→`PERMAV.md`,
  `ego_depletion.md`→`Ego Depletion.md`, `strategic_life_unit_area.md`→`Strategic Life
  Unit's (SLU) and Areas (SLA).md`). `content/Atomics` last touched 2026-05-21 vs `docs/
  atomics`'s 2025-08-20; diffed one shared file (`Installing MQTT.md` analog) and got real
  content changes, not just a copy.
- `docs/how-to/Installing MQTT.md` — present in `content/How To` (which also has 4 more
  files docs/ never got). Diff shows real edits since.
- `docs/reviews/*` (6 files) — all 6 present in `content/Reviews` (which has 10 files
  total, growing since). Diffed `Manage Your Day-to-Day.md`: real edits since.
- `docs/graph.md`, `docs/Changelog.md` — frozen Jan 2024 pages (`Changelog.md` is a manual
  file-index table with dead wikilinks into `atomics/`, `how-to/`, `reviews/` relative
  paths — the pre-`content/`-boundary layout). No `content/` counterpart because neither
  is content — both are dead scaffolding from before the fork's own migration into
  `content/` happened. Quartz's own graph view/changelog tooling (if any) replaces these,
  not a ported file.

Conclusion: this was never a "where do these go" migration decision — the fork already
moved its content into `content/` at some point pre-dating this map; `docs/` just never
had the stale originals deleted. The v5 migration is the natural point to clean them up.
