---
date: 2024-02-02
title: Dotfiles
share: true
tags:
  - technology
  - coding
  - flow
aliases: 
modified: 2024-02-02T17:27:26-08:00
cssclasses:
  - wiki-right
---

These are the files or folders that live your home directory that configure your applications. Some examples are: `.config/`, `.zshrc`, etc.
Because these are typically flat files they can easily be stored in a [[git|git]] repository you can easily copy them between your different machines.
## Value of Dotfiles
The value of maintaing a dotfiles repository is that you can create a 
## Managing Dotfiles
Most management is done by a set of tools that either copy or symlink your dotfiles.
### Chezmoi
> [!wiki] Info 
> |  |  |
> | --- | --- |
> | **OS** | ![[linux.svg|20]]![[apple.svg|20]]![[windows.svg|20]] |
> | **Site** | https://www.chezmoi.io/ |
> | **Github** | https://github.com/twpayne/chezmoi |

I was first introduced chezmoi by Jaykul. Chezmoi works by creating a clone of your dotile
### GNU Stow
> [!wiki]
> #### Info 
> |  |  |
> | --- | --- |
> | **OS** | ![[linux.svg|20]]![[apple.svg|20]] |
> | **Site** | https://www.gnu.org/software/stow/ |

This is a "symlink farm manager". Not available on Windows.
