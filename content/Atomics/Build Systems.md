---
date: 2024-10-27
share: true
tags:
aliases: []
---
Build systems are an aspect of [[Continuous Integration & Continous Delivery|Continuous Integration & Continous Delivery]].
## Tools 
- [[Psake|Psake]]
- Make
- Rake
- Bazel
- Buck
- Cake
## Terminology
- **Task**: An step in the build system that is typically composed of different actions. This could be a shell out to another tool, or executing commands.
## Distinguishers
- **Dependency Management**: Static vs Dynamic dependancy resolution.
- **Local & Remote**: Whether the tools target working in different environments.
- **Deterministic & Non Deterministic**: Deterministic builds means that everything going into the build is the same. This means that builds should be consistent across systems.
- **Parallelism**: The ability to execute tasks in parallel.
## Links
- [Build systems à la carte: Theory and practice](https://ndmitchell.com/downloads/paper-build_systems_a_la_carte_theory_and_practice-21_apr_2020.pdf)
