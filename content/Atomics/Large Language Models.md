---
date: 2026-02-21
share: true
tags:
aliases:
  - llm
  - llms
---
  
> [!WARNING] Work in Progress  
> Of all the notes with a WIP warnings it's this one. The AI "boom" means things are changing daily!  I'm no expert - but I did stay in a holiday inn express.  
  
The "AI" boom is really a Large Language Model Boom.  
"We tell the public it's AI. We tell investors it's machine learning. We tell developers it's stochastic programming. It's actually linear interpolation." - https://youtu.be/8NEhApDFfNQ?si=6Ofl0y8cDmsqNBsq  
  
High Level Rules  
1. A Good Plan Saves Tokens  
2. "Point, Don't Dump"   
## Context  
Context is the tokens that are passed back to the AI. There is a typically a max context size and to continue there is often a compression step. This can result in context rot[^1] which is when the summarized version performs worse over time.  
### Context Rot  
When LLM's compress your context into shorter summaries. This typically means that nuance gets lost. The LLM also has to process all the context in it's answers. This can result in higher liklihood of hallucinations.  
Some ways to handle context rot is by creating fresh chats or leveraging subagents.  
## Agents.md, Claude.md, Etc.  
These are the entry points for LLM's to start getting context about how a project is laid out, where to find configuration, etc. This reduces the total context because the LLM no longer needs to read each file to understand what's going on.   
  
>Point, don't dump  
  
By having, "for brand voice read foo.md" it allows the LLM to only read that file if it needs it. That allows the context to stay small.  
## Instruction Files  
These are files that can describe how things should be implemented. The metadata can set where to apply by settings a glob pattern to match. Unlike   
## Skills  
Agent skills are prepackaged instructions. They are similar to Instruction Files but follow a specific standard https://agentskills.io/home. Specifically they are 500 lines or less. They also "progressive" disclosure which means that the metadata is loaded into the context, and only if the skill seems relevant will it read the rest. Skills can read other   
## Spec Driven Development  
Unlike one shot prompts Spec Driven Development (SDD) creates a series of markdown files that allow context to be retrieved freshly for different agents to act of them.  
  
In my experience this hasn't worked well in the past (using spec-kit). It burned through a ton of tokens and once getting into implementations the quality was poor.  
  
References:  
[^1]: https://research.trychroma.com/context-rot