---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git commit:*)
argument-hint: [tags...]
description: Create a git commit with JIRA tags
---

## Context

- Current git status: !`git status`
- Current git diff (only staged changes): !`git diff HEAD`

    > [!IMPORTANT]
    > If there is no staged changes, ABORT THIS COMMAND and WARN users that there is no staged changed.

- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

Create a single git commit with this format:

```
<HEAD - write a concise commit message>

<BODY - write a detailed explanation of the changes (optional)>

tags: $ARGUMENTS
```

The user provided these tags: $ARGUMENTS

You have the capability to call multiple tools in a single response. Write a descriptive HEAD and optional BODY based on the changes shown in the diff above, create the commit following the provided template. Do not use any other tools or do anything else. Do not send any other text or messages besides these tool calls.
