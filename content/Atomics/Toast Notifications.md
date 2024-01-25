---
date: 2022-08-05
tags:
  - "#PowerShell"
  - PowerShell
aliases: 
modified: 2024-01-25T07:40:16-08:00
share: true
---

These are the pop-ups that show up on users computers. These can be triggered by apps, but also with [[Windows Notification Service|Windows Notification Service]] and BurntToast.
## Burnt Toast
Written by Josh King in PowerShell. It generates an XML file that creates an appropriate toast notifcation. With v1 coming soon, there will be some breaking changes and will require PowerShell 7.

By default, it will show up with a burnt toast logo or as PowerShell. To have a different “app” you must use an AppID[^1]. If you want a unique logo for your AppID, you need to create a basic dummy WIX app[^2].

[^1]: https://toastit.dev/2018/02/04/burnttoast-appid-installer/
[^2]: https://toastit.dev/2018/03/03/burnttoast-wix/