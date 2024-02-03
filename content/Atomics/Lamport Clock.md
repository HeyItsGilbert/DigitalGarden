---
date: 2022-09-01
tags:
  - technology
aliases: 
modified: 2024-02-02T21:24:09-08:00
share: true
---

A way to keep track of changes across multiple systems. Time can drift between systems and can result in not knowing which change was the latest. A lamport clock keeps an int of the version and increase on each change. If a system sees a higher version it will select it. 

One issue is if there is a conflict between clock versions. One solution is to decide a winner proactively and let the other get its settings. For example, when a conflict happens letting the server version win, get bumped and then push that back to the client. 
## References
- https://martinfowler.com/articles/patterns-of-distributed-systems/lamport-clock.html
- https://jakub-m.github.io/2022/07/17/laport-clocks-formal.html