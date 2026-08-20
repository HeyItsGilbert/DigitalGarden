Type: grilling
Status: open
Blocked by: 05

## Question

Once the branch from ticket 04/05 is green: land it as `main` (fast-forward or replace, with
old `main` retagged e.g. `pre-v5-upgrade` for rollback) or keep it as a long-lived branch
merged in later? Also decide what happens to `origin/main` history — force-push a rewritten
`main`, or merge the new branch in as a normal commit to preserve `main`'s existing commit
graph.
