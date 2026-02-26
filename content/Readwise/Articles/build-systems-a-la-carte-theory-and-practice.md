---
id: 44991716
updated: 2024-10-15
title:
author: "[[Andrey Mokhov|Andrey Mokhov]], [[Neil Mitchell|Neil Mitchell]], [[Simon Peyton Jones|Simon Peyton Jones]]"
share: true
readwise_url:
uri: https://readwise.io/bookreview/44991716
---



%%
ID: 44991716
Updated: 2024-10-15
%%

![]( https://readwise-assets.s3.amazonaws.com/media/reader/parsed_document_assets/57244772/aa6Ey-ChdZMwH3V8dE9aTpe6bwN7zJMh7RBDUCjYLj4-cover_FUMVz8e.png)

# About
Title: [[Build systems à la carte: Theory and practice|Build systems à la carte: Theory and practice]]
Authors: [[Andrey Mokhov|Andrey Mokhov]], [[Neil Mitchell|Neil Mitchell]], [[Simon Peyton Jones|Simon Peyton Jones]]
Category: #articles
Number of Highlights: ==2==
Source URL: https://ndmitchell.com/downloads/paper-build_systems_a_la_carte_theory_and_practice-21_apr_2020.pdf
Date: [[2024-10-15|2024-10-15]]
Last Highlighted: *2024-10-15*

---

# Highlights


  Build systems à la carte: Theory and practice ^799127320

---
  Keys, values, and the store. The goal of any build system is to bring up to date a store that implements a mapping from keys to values. In software build systems, the store is the ﬁle system, the keys are ﬁlenames, and the values are ﬁle contents. In EXCEL, the store is the worksheets, the keys are cell names (such as A1), and the values are numbers, strings, etc., displayed as the cell contents. Many build systems use hashes of values as compact summaries with a fast equality check.

Input, output, and intermediate values. Some values must be provided by the user as input. For example, main.c can be edited by the user who relies on the build system to compile it into main.o and subsequently main.exe. End build products, such as main.exe, are output values. All other values (in this case main.o)are intermediate; they are not interesting for the user but are produced in the process of turning inputs into outputs.

Persistent build information. As well as the key/value mapping, the store also contains information maintained by the build system itself, which persists from one invocation of the build system to the next – its “memory”.

Task description. Any build system requires the user to specify how to compute the new value for one key, using the (up-to-date) values of its dependencies. We call this speciﬁcation the task description. For example, in EXCEL, the formulae of the spreadsheet constitute the task description; in MAKE, the rules in the makeﬁle are the task description. Build system. A build system takes a task description, a target key, and a store, and returns a new store in which the target key and all its dependencies have up-to-date values. We model a build system concretely, as a Haskell program. To that end, Figure 5 pro- vides the type signatures for all key abstractions introduced in the paper. For example, Store ikv is the type of stores, with several associated functions (getValue, etc.). We use k as a type variable ranging over keys, v for values, and i for the persistent build information. Figure 6 lists standard library deﬁnitions. ^799127577

Note: Common vocabulary for build systems.
1. Keys, values, and the store
2. Input, output, and intermediate values
3. Persistent build information
4. Task description
5. Build system

---