Type: grilling
Status: resolved

## Question

Decide how to handle the non-content-boundary top-level files that the merge attempt showed
conflicting or that ticket 01's `c-infra.patch` / `c-docs-framework.patch` buckets found:
`.github/workflows/ci.yaml`, `.github/dependabot.yml`, `.github`'s deleted OSS-community
scaffolding (`FUNDING.yml`, issue/PR templates, `build-preview.yaml`, `deploy-preview.yaml`,
`docker-build-push.yaml` — main deleted these, presumably deliberately, for a personal fork
not taking external PRs), `Dockerfile`, `.vscode/tasks.json`, `.devcontainer/devcontainer.json`,
`.node-version`, `README.md`, `CODE_OF_CONDUCT.md`, `tsconfig.json`, `index.d.ts`,
`globals.d.ts`, `package.json`/`package-lock.json`, and the **framework subset** of `docs/`
(`docs/advanced`, `docs/features`, `docs/plugins`, `docs/configuration.md`, `docs/hosting.md`,
`docs/index.md`, `docs/showcase.md`, `docs/tags` — NOT `docs/atomics`, `docs/how-to`,
`docs/reviews`, `docs/Changelog.md`, `docs/graph.md`, which are fork-personal content and
belong to ticket 07, not this one).

Options to weigh: adopt upstream's version wholesale (simplest, matches the "everything
outside the content boundary is upstream's" spirit); keep the fork's CI/Docker/dev-tooling
config because it encodes real deploy specifics (hosting target, secrets, build args) or
deliberate scaffolding removal; or reconcile line-by-line per file. The framework-docs subset
of `docs/` almost certainly should just take upstream's version since it documents the
framework, not the garden — confirm that's not controversial. `package.json`/lockfile: decide
whether to diff for fork-specific added dependencies before letting upstream's file win, or
regenerate the lockfile fresh post-integration (ticket 04/05 will run `npm install` anyway).

## Answer

Grilled (single round, no downstream branching — all facts were repo-checkable, not user
judgment calls except deploy mechanism):

- **Adopt upstream v5 wholesale, no reconciliation**: `package.json`/`package-lock.json`
  (regenerate lockfile fresh — ticket 04/05 run `npm install` anyway), `Dockerfile`,
  `tsconfig.json`, `index.d.ts`, `globals.d.ts`, `README.md`, the framework-docs subset of
  `docs/` (`docs/advanced`, `docs/features`, `docs/plugins`, `docs/configuration.md`,
  `docs/hosting.md`, `docs/index.md`, `docs/showcase.md`, `docs/tags`), `.node-version`
  (doesn't exist on the fork — nothing to preserve), `CODE_OF_CONDUCT.md` (doesn't exist on
  the fork either). Verified by `git log` on each: no fork-authored commits, only upstream-
  style commits or automated Snyk bumps — genuinely vanilla. `Dockerfile` was the one file
  that looked deploy-critical (actively Snyk-patched) but isn't: deploy is via Netlify
  (dashboard-configured GitHub integration, no `netlify.toml` in-repo), so the Dockerfile is
  unused and joins this bucket rather than needing careful carry-forward.
- **Port unchanged as plain files** (same treatment as ticket 02's keep-list): `.vscode/
  tasks.json`, `.devcontainer/devcontainer.json`, `.github/dependabot.yml` — all three have
  genuine fork-authored history (`Devcontainer + add some colors and icons`, `feat: enable
  dependabot`, `deps: reduce dependabot frequency`) and are independent of quartz's plugin
  architecture, so nothing about the v5 restructure affects them.
- **`.github/workflows/ci.yaml`**: adopt upstream's v5 version as-is. It's currently inert on
  the fork (`if: github.repository == 'jackyzha0/quartz'` guard never matches), so this is a
  no-op either way; fixing or dropping the dead guard is out of scope for this migration.
- **Deleted OSS-community scaffolding** (`FUNDING.yml`, issue/PR templates,
  `build-preview.yaml`, `deploy-preview.yaml`, `docker-build-push.yaml`): stays deleted, don't
  resurrect from upstream v5's copies — confirmed deliberate (personal fork, no external PRs).

Net effect: **nothing outside the content boundary needs special-case reconciliation** for
this ticket's scope. Three fork-authored files (dev-tooling/dependabot) port unchanged;
everything else — including the CI workflow and the Dockerfile — takes upstream's v5 version
wholesale.
