#!/bin/bash
# macOS Dialog Notification
input=$(cat)

# Stop
# {
#   "session_id": "abc123",
#   "transcript_path": "~/.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
#   "cwd": "/Users/...",
#   "permission_mode": "default",
#   "hook_event_name": "Stop",
#   "stop_hook_active": true,
#   "last_assistant_message": "I've completed the refactoring. Here's a summary..."
# }

# Notification
# {
#   "session_id": "abc123",
#   "transcript_path": "/Users/.../.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
#   "cwd": "/Users/...",
#   "hook_event_name": "Notification",
#   "message": "Claude needs your permission to use Bash",
#   "title": "Permission needed",
#   "notification_type": "permission_prompt"
# }
tmux_source="$(tmux display-message -p "[#S] #I:#W")"
hook_event_name=$(jq -r '.hook_event_name' <<< $input)
if [ "$hook_event_name" = "Stop" ]
then
    last_assistant_message=$(jq -r '.last_assistant_message' <<< $input)
    osascript -e 'display dialog "'"tmux: $tmux_source\n[$hook_event_name] ${last_assistant_message:0:80}"'" buttons {"Got it"} default button "Got it" with title "Claude Code"'
elif [ "$hook_event_name" = "Notification" ]
then
    notification_type=$(jq -r '.notification_type' <<< $input)
    if [ "$notification_type" = "idle_prompt" ]
    then
        osascript -e 'display notification "'"tmux: $tmux_source\n[$notification_type]"'" with title "Claude Code"'
    else
        osascript -e 'display dialog "'"tmux: $tmux_source\n[$notification_type]"'" buttons {"Got it"} default button "Got it" with title "Claude Code"'
    fi
fi
