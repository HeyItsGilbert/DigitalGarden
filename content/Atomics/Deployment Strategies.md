---
modified: 2024-02-11T07:56:05-08:00
date: 2024-02-07
share: true
tags:
  - coding
aliases: 
---
When deploying servers, services, or applications there are a few strategies to use to safely roll out changes.
## Blue Green
This requires settings up a second unique environment. The blue in this strategy is referring to your current instance, and the green being the new one.
## Rolling Deployments
This strategy rolls out changes gradually out, but there is no environment isolation.
The approach to which devices get the new version can differ.

One strategy I've used is to shard your fleet and then roll out in phases. 1%, 5%, 20%, 50%, and 100%.
## Safety and Confidence
The best way to ensure you know your deployments are rolling out safely is by continually measuring performance (see [[Observability|Observability]]).
One way to build confidence, in most coding situations, is tests (see [[Testing|Testing]]).