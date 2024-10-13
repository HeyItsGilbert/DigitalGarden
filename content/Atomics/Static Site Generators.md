---
date: 2024-10-10
share: true
tags: 
aliases: 
---
Static site generators build sites from [[Markdown|Markdown]] and each offers a different set of features. What they produce is static set of html files that can be served by different hosts such as [[GitHub Pages|GitHub Pages]], [[Netlify|Netlify]], [[Vercel|Vercel]], and many more.

I've tried plenty of of generators, and here's my 2 cents of each of them.
## [[Docusaurs|Docusaurs]]
- **Language**: Typescript
- **Intended Audience**: [[Documentation|Documentation]]
- **Where I Use It**:
  - [Psake](https://psake.dev)
- **Positives**
  - Versioned Docs - This is very helpful to track when new versions break changes.
- **Negatives**
  - Slow to generate pages!
  - No automatic rebuild. This means killing the server and re-running.
  - No commenting options.
## [[Hugo|Hugo]]
- **Language**: Go
- **Intended Audience**: General
- **Where I Use It**:
  - [Blog](https://gilbertsanchez.com)
- **Positives**
  - Lot's of flexibility
  - Simple to modify templating system
  - Automatic RSS feed
- **Negatives**
  - Heavy use of submodules can be difficult to deal with.
  - All the flexibility can be overwhelming if you're not familiar with programming templates.
## [[Jeckyll|Jeckyll]]
- L**anguage**: Ruby
- It's been a VERY long time since I actively used Jeckyll. It was only markdown docs at the time.
- This is the default for GitHub Pages.
## [[MkDocs|MkDocs]]
- **Language**: Python
- **Intended Audience**: [[Documentation|Documentation]]
- **Where I Use It**:
  - PS Modules such as [ChocoLogParse](https://heyitsgilbert.github.io/ChocoLogParse/), [Log4NetParse](https://heyitsgilbert.github.io/Log4NetParse), [MazeRats](https://heyitsgilbert.github.io/MazeRats/), etc.
- **Positives**:
  - Simple configuration file.
  - Large plugin system.
  - [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- **Negatives**:
  - Issues with trailing slashes.
  - Default case sensitive.
## [[Quartz|Quartz]]
- **Language**: Typescript
- **Intended Audience**: [[DigitalGarden|DigitalGarden]] and Notes as A WebSite
- **Where I Use It**:
  - This site!
- **Positives**:
  - Easy to use with [[Obsidian|Obsidian]]. (see [[Publish to Quartz Repo|Publish to Quartz Repo]])
  - Graph view of interconnected notes.
- **Negatives**:
  - Smaller community. (Positive is it's very active)
  - "Plugins" aren't really a thing. You copy changes shared by others in the discord.
