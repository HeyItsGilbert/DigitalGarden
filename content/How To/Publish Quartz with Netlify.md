---
modified: 2024-01-22T07:58:47-08:00
date: 2024-01-22
share: true
---


> [!NOTE] Obisidian to Quartz
> You can see how I push my [[Obsidian|Obsidian]] note to [[Quartz|Quartz]] at [[Publish to Quartz Repo|Publish to Quartz Repo]]

The beautiful thing about Quartz is the build command is very straight forward. [Netlify](https://netlify.com) is a great way to build and host static sites for free.

Once you have your quartz repo up and running you can point Netlify to it and have it build and publish it. All you need to do is tell it to run `npx quartz build`! Also, remember that the main branch is called `v4`.

## Build Settings
- **Runtime**: Not set
- **Base directory**: /
- **Package directory**: Not set
- **Build command**: `npx quartz build`
- **Publish directory**: `public`
- **Functions directory**: netlify/functions
## Branches and deploy contexts
- **Production branch**: `v4`
- **Branch deploys**: Deploy only the production branch
- **Deploy Previews**: Don’t deploy pull requests

> [!NOTE] Tip
> Since I use "Github Publisher" extension to push to the main branch I don't want to waste the build time on PR's.