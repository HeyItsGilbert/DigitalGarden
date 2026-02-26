---
id: 27390957
updated: 2023-05-07
title:
author: "[[MDGRS Factory]]"
share: true
readwise_url:
uri: https://readwise.io/bookreview/27390957
---



%%
ID: 27390957
Updated: 2023-05-07
%%

![]( https://hashnode.com/utility/r?url=https%3A%2F%2Fcdn.hashnode.com%2Fres%2Fhashnode%2Fimage%2Fupload%2Fv1683377210116%2Fd4ec231b-4b96-476b-95a5-4e602874929c.png%3Fw%3D1200%26h%3D630%26fit%3Dcrop%26crop%3Dentropy%26auto%3Dcompress%2Cformat%26format%3Dwebp%26fm%3Dpng)

# About
Title: [[ScriptBlock and SessionState in PowerShell|ScriptBlock and SessionState in PowerShell]]
Authors: [[MDGRS Factory]]
Category: #articles
Tags: #powershell, #coding
Number of Highlights: ==2==
Source URL: https://mdgrs.hashnode.dev/scriptblock-and-sessionstate-in-powershell
Date: [[2023-05-07|2023-05-07]]
Last Highlighted: *2023-05-07*

---

# Highlights


  A PowerShell process has the default [Runspace](https://learn.microsoft.com/en-us/powershell/scripting/developer/hosting/creating-runspaces) which is the operating environment for the commands invoked by a host. In a Runspace, there is the global [SessionState](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/windows-powershell-session-state) object. When modules are imported to the global SessionState, a new SessionState object is created for each module. ^524325727

Tags: #work

---
  •   Do not pass a ScriptBlock that is bound to a Runspace to another Runspace (Thread). ^524325830

Tags: #powershell

---