---
share: true
date: 2024-09-15
tags:
  - development
---
I got tired of updating my resume after realizing the last update was written in... Apple Pages. The brilliant [[Mikey Lombardi|Mikey Lombardi]] told me about this in passing at some point. When I needed to give an updated resume, I decided to give a shot and instantly loved it.

Perks:
- JSON
- Self hosting - not necessary but easy to do.
- Lot's of built in tools
- A few nice themes.
## Simple Start
I started with writing a GitHub gist named `resume.json` (e.g. https://gist.github.com/HeyItsGilbert/f2746e7f16b51429e655de5d8dceebe1). You can leave it at that and just navigate to https://registry.jsonresume.org/HeyItsGilbert. For you, it would be your GitHub username.
## Self Hosting
I liked being able to self host my static sites. I also thought it would be nice to host it under something like https://resume.gilbertsanchez.com.

To do this, I need to create a repository (https://github.com/HeyItsGilbert/resume) and add the following things:
1. `resume.json` - This should match the gist.
2. `package.json` - NPM config to install resumed and the theme.
3. `.github/workflows/gist.yml` - A workflow that will publish the resume.json from this repo to the gist.
4. A `public` directory (with a `.gitkeep`). It's what netlify will use.
### Package.json
The `package.json` defines the different scripts to run as well as what dependancies. 
```json
{
  "private": true,
  "type": "module",
  "scripts": {
    "init": "resumed init",
    "start": "resumed --theme jsonresume-theme-elegant",
    "build": "resumed --theme jsonresume-theme-elegant && cp resume.html public/index.html"
  },
  "dependencies": {
    "jsonresume-theme-elegant": "^1.16.1",
    "jsonresume-theme-even": "^0.17.0",
    "resumed": "^3.0.0"
  }
}
```
### Netlify
- **Build Command**: `yarn build`
- **Publish directory**: `public`
Netlify will see changes to the repository and run the build command in the `package.json`.
### Gist Workflow
This action will run on push and updates the `resume.json` under my gist. You will need to update it to match your `gist_id`.
```yaml
name: Update Resume Gist
on: push
jobs:
  update-resume-gist:
    runs-on: ubuntu-latest 
    steps:
    - name: Checkout Repository
      uses: actions/checkout@v3
    - name: Update Resume Gist
      uses: exuanbo/actions-deploy-gist@v1
      with:
        token: ${{ secrets.TOKEN }}
        gist_id: f2746e7f16b51429e655de5d8dceebe1
        file_path: resume.json
```