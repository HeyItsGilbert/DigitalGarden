---
date: 2024-01-20
share: true
---

So I discovered Quartz after I finished setting up the Mkdocs Obsidian template. I was constantly running into issues. Mkdocs is finicky with URL's case and that meant I would have to rename folders and files. Quartz didn't have those issues PLUS I was able to keep using the Publisher extension which I thought was great.
## Quick Guide

1. Create a repo from the [quartz repo](https://github.com/jackyzha0/quartz) template.
2. You can remove the `docs` folder (optional)
3. Install the [GitHub Publisher](https://github.com/ObsidianPublisher/obsidian-github-publisher) [[Obsidian|Obsidian]] extension.
4. You can click "Import Settings" and use the settings below.
5. You will need to update with your own token and repo.
  1. The branch will likely stay the same since v4 is the default branch.

## GitHub Publisher Settings
```json
{
  "github": {
    "branch": "v4",
    "automaticallyMergePR": true,
    "tokenPath": ".obsidian/plugins/obsidian-mkdocs-publisher/env",
    "api": {
      "tiersForApi": "Github Free/Pro/Team (default)",
      "hostname": ""
    },
    "workflow": {
      "commitMessage": "PUBLISHER",
      "name": ""
    },
    "verifiedRepo": true
  },
  "upload": {
    "behavior": "obsidian",
    "defaultName": "content",
    "rootFolder": "docs",
    "yamlFolderKey": "category",
    "frontmatterTitle": {
      "enable": true,
      "key": "filename"
    },
    "replaceTitle": [],
    "replacePath": [],
    "autoclean": {
      "enable": true,
      "excluded": [
        "docs/assets/js",
        "docs/assets/meta",
        "docs/assets/css",
        "tags.md"
      ]
    },
    "folderNote": {
      "enable": true,
      "rename": "_index.md",
      "addTitle": {
        "enable": true,
        "key": "title"
      }
    },
    "metadataExtractorPath": "",
    "subFolder": ""
  },
  "conversion": {
    "hardbreak": false,
    "dataview": true,
    "censorText": [],
    "tags": {
      "inline": true,
      "exclude": [],
      "fields": []
    },
    "links": {
      "internal": false,
      "unshared": false,
      "wiki": false,
      "slugify": false
    }
  },
  "embed": {
    "attachments": true,
    "overrideAttachments": [],
    "keySendFile": [
      "image"
    ],
    "notes": true,
    "folder": "docs/assets/img",
    "convertEmbedToLinks": "bake",
    "charConvert": "->",
    "bake": {
      "textBefore": "",
      "textAfter": "- From [{{title}}]({{url}})"
    }
  }
}
```

A few notes:
- This keeps the obisidian folder structure (my preference)
- The extension takes some plugins that generate markdown (i.e. Dataview), and use that current version of that. This also means that you need to republish the note if the data changes.
- The default folder to publish content to is `content`.
- There are probably some leftover cruft from my various testing (e.g. `docs/assets/img` 😬) 