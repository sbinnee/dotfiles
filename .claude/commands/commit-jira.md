---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git commit:*)
argument-hint: [-v|--verbose] [-x|--explanation [<explanation>]] [tags...]
description: Create a git commit with JIRA tags
---

## Context

- Current git status: !`git status`
- Current git diff (only staged changes): !`git diff --staged HEAD`

    > [!IMPORTANT]
    > If there is no staged changes, ABORT THIS COMMAND and WARN users that there is no staged changed.

- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Explanation (optional argument)
When `-x` or `--explanation` is given with text, you need to consider it serisouly and try to reflect it either in <HEAD> or <BODY> of the commit message. It tends to explain why or rationale of the changes.

## Your task

Create a single git commit with this format:

```
<HEAD - write a concise commit message (try to respect 50 chars or less)>

<BODY - write a short explanation of the changes unless `verbose` option is given (optional)>

tags: $ARGUMENTS
```

The user provided these tags: $ARGUMENTS

You have the capability to call multiple tools in a single response. Write a descriptive HEAD and optional BODY based on the changes shown in the staged diff above, create the commit following the provided template. Do not add unstaged files. Do not use any other tools or do anything else. Do not send any other text or messages besides these tool calls.
