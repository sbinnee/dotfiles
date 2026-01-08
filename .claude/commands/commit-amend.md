---
name: commit-amend
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git commit --amend:*), Bash(git log:*)
description: Amend the latest git commit using the staged diff and keep existing tags if present.
---


# Commit Amend

Use this skill when the user asks to amend the latest git commit by inspecting the staged diff and the current HEAD commit message.

## Workflow

1) Read the current repo state:
   - `git status`
   - `git diff --staged HEAD`

2) If there are no staged changes, STOP and warn that there is nothing to amend.

3) Read the latest commit message and its patch

   - `git log -1 -p --pretty=full`

4) Extract the latest commit subject/body from `git log -1 --pretty=full`.
   - If the commit message contains a `tags:` line, preserve it verbatim in the amended commit message.
   - If there is no `tags:` line, do not add one.

5) Compose a new commit message based on the staged diff:
   - HEAD: concise, action-oriented summary of the staged changes.
   - BODY: optional, only if it adds clarity beyond the HEAD.
   - Append `tags:` only if it existed in the previous commit message.

5) Amend the commit using only staged changes (never stage files in this skill):
   - `git commit --amend -m "<HEAD>" -m "<BODY>" [-m "tags: ..."]`

## Hard constraints

- Never run `git add` or stage files.
- Do not amend if there are no staged changes.
- Do not add tags unless they already exist in the previous commit message.
