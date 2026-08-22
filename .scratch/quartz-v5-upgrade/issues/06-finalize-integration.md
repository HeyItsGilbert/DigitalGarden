Type: grilling
Status: resolved
Blocked by: 05
Assignee: Gilbert (agent session)

## Question

Once the branch from ticket 04/05 is green: land it as `main` (fast-forward or replace, with
old `main` retagged e.g. `pre-v5-upgrade` for rollback) or keep it as a long-lived branch
merged in later? Also decide what happens to `origin/main` history — force-push a rewritten
`main`, or merge the new branch in as a normal commit to preserve `main`'s existing commit
graph.

## Answer

Land now, via force-push replace — not a merge.

1. **Land now.** Ticket 05 already validated the build end to end (visual pass, both
   discovered fixes committed). Nothing outstanding gates a merge to `main`; a long-lived
   branch would only accumulate drift against a `main` that's otherwise frozen (last commit
   `31b835c8e`, unmoved since charting) and against `upstream/v5` (already moved to
   `075afd3f7` since charting).
2. **Force-push, not merge.** `v5-migration` isn't a descendant of `main` — it branched fresh
   off `upstream/v5` (421 commits diverge each way per ticket 04's approach), so a normal
   `git merge` would either conflict wholesale or produce a merge commit reconciling two
   unrelated trees, contradicting the "official migration path, not a merge/patch-apply"
   framing locked into the map's Destination. `main` is confirmed unprotected
   (`branches/main/protection` → 404) on a solo-maintained fork, so there's no collaborator
   history or required-checks constraint to preserve.

**Mechanics (execution, not part of this decision ticket — plan/don't-do):**
`git tag pre-v5-upgrade main && git branch -f main v5-migration && git push --force origin main`
(plus pushing the new tag).

**Surfaced during resolution:** 11 open Snyk/Dependabot PRs target `main`
(`HeyItsGilbert/DigitalGarden` #214–#219, #176–#180), all pre-v5 dependency bumps against the
old tree. They become stale/conflicting against the rewritten `main` regardless of
merge-vs-replace choice. Recommend closing them as superseded by the v5 migration when the
force-push lands — routine cleanup per this decision, not a new ticket.

Confirmed by Gilbert in-session ("Agree").
