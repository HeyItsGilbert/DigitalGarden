Type: task
Status: open
Blocked by: 04
Assignee: Gilbert (agent session)

## Question

Run `npx quartz build` (and `npx quartz serve` for a visual pass) on the branch from ticket
04. Iterate until: the build succeeds, `content/` renders and is browsable end to end, and
the fork's visual customizations (theme colors, custom CSS from the ticket-02 keep-list) are
visibly present. This is the acceptance bar from the charting session — no automated test
suite, no feature-parity audit required.

Log anything fixed along the way; if a fix requires a decision beyond "make the build pass"
(e.g. a customization from 02 doesn't fit v5's new architecture at all), spin a fresh ticket.
