---
date: 2024-02-02
title: Dotfiles
share: true
tags:
  - technology
  - coding
  - flow
aliases: 
modified: 2024-02-04T14:19:53-08:00
cssclasses:
  - wiki-right
---
These are the files or folders that live your home directory that configure your applications. Some examples are: `.bashrc` `.config/`, `.zshrc`, etc.
Because these are typically “[[Plain Text|plain text]]” files they can easily be stored in a [[git|git]] repository you can easily copy them between your different machines.

You can find my dotfiles at: [HeyItsGilbert/dotfiles](https://github.com/HeyItsGilbert/dotfiles)
## Value of Dotfiles
Maintaing a dotfiles repository provides the following:
1. Maintain a [[Personal Development Environment|PDE]].
2. Automatically configure [GitHub codespaces](https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles).
3. Sync your environment across machines.
4. Share your configs with others.
## Managing Dotfiles
Most management is done by a set of tools that either copy or symlink your dotfiles.
### Chezmoi
- **OS**: ![[linux.svg|20]]![[apple.svg|20]]![[windows.svg|20]]
- **Site**: https://www.chezmoi.io/
- **GitHub**: [twpayne/chezmoi](https://github.com/twpayne/chezmoi)

I was first introduced chezmoi by Jaykul. Chezmoi works by creating a clone of your dotfile in the AppData directory. Then a `chezmoi` command sync what's in your home directory to that repo. It also supports doing other things like running scripts as part of the sync process.
### GNU Stow
- **OS**: ![[linux.svg|20]]![[apple.svg|20]]
- **Site**: https://www.gnu.org/software/stow/

This is a "symlink farm manager". Not available on Windows.
