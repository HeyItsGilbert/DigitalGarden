Type: task
Status: resolved

## Question

Produce the fork-delta: the squashed patch representing everything `main` has that
`upstream` doesn't, since the merge-base (`ec00a40aefca73596ab76e3ebe3a8e1129b43688`).

Concretely:
- `git diff ec00a40..main` (or a `git diff --stat` first pass) scoped to the whole tree.
- Split the result into three buckets: (a) `content/` changes, (b) `quartz.config.ts` /
  `quartz.layout.ts` changes, (c) everything else the delta touches under `quartz/`, `docs/`,
  `.github/`, `Dockerfile`, `package.json`, root config files, etc.
- Bucket (c) is the input to ticket 02 (nothing there is pre-judged keep/discard yet).
- Save the buckets as patch files or a summary doc under `.scratch/quartz-v5-upgrade/` for
  the tickets that consume them.

## Answer

**Correction, made while resolving ticket 02:** the merge-base cited above
(`ec00a40aefca73596ab76e3ebe3a8e1129b43688`) was wrong — that's
`merge-base(upstream/v4, upstream/v5)`, not `merge-base(main, upstream/v5)`. The real
merge-base is `bf5a556cc15edd311cf5cb7faab2509569e6af0a` (2024-01-28), 712 commits earlier
on the v4 line. All buckets were regenerated against the correct base; see
`.scratch/quartz-v5-upgrade/fork-delta/README.md`'s Correction note for detail on what
changed (633→586 paths; the wrong base spuriously showed 34 `quartz/`-tree deletions,
including files that looked like core upstream features — those were never touched by
`main` at all, just upstream's own later add-then-remove on files that didn't exist yet at
the true merge-base).

Fork-delta = `git diff bf5a556c..main`, 586 changed paths, fully bucketed into
`.scratch/quartz-v5-upgrade/fork-delta/` (see its README.md for the table):

- `a-content.patch` (350 files, `content/`) — applies wholesale, no review needed.
- `b-config.patch` (2 files, `quartz.config.ts` + `quartz.layout.ts`) — feeds ticket 04.
- `c-quartz-tree.patch` (109 files: 28 added, 81 modified, `quartz/`) — feeds ticket 02.
- `c-docs-framework.patch` (~58 files, upstream-shaped subset of `docs/`) — feeds ticket 03.
- `c-infra.patch` (~10 files, CI/Docker/dev-tooling/repo-root config) — feeds ticket 03
  (03's scope was expanded to cover this; it wasn't fully anticipated when 03 was ticketed).
- `d-docs-personal.patch` (18 files) — **new finding**, not covered by any existing ticket:
  `docs/atomics`, `docs/how-to`, `docs/reviews`, `docs/Changelog.md`, `docs/graph.md` are
  fork-personal content living inside `docs/`, absent from both `upstream/v5` and the
  merge-base. Spun into ticket 07 (fate of `docs/` personal content), wired as a new blocker
  on ticket 04. This finding is unaffected by the merge-base correction — same file set
  either way.

