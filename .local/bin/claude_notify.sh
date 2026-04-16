#!/bin/bash
# TODO
# - [ ] Linux
#
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
#
#
center_dialog_message() {
    local input_string="$1"
    local target_width="${2:-60}" # Default width is 60

    echo "$input_string" | awk -v w="$target_width" '{ 
        # Calculate padding: (Target - Length) / 2 * Proportional Multiplier
        pad = int((w - length($0)) / 2 * 1.6); 
        if (pad < 0) pad = 0;
        # Create the padded string
        printf "%*s%s", pad, " ", $0 
    }'
}

tmux_source="$(tmux display-message -p "[#S] #I:#W")"
hook_event_name=$(jq -r '.hook_event_name' <<< $input)
if [ "$hook_event_name" = "Stop" ]
then
    last_assistant_message=$(jq -r '.last_assistant_message' <<< $input)
    _msg_source="$(center_dialog_message "tmux: $tmux_source")"
    _msg_event="$(center_dialog_message "[$hook_event_name]")"
    _msg_break="$(center_dialog_message "---")"
    osascript -e 'display dialog "'"$_msg_source\n$_msg_break\n$_msg_event\n${last_assistant_message:0:100}"'" buttons {"Got it"} default button "Got it" with title "Claude Code"'
elif [ "$hook_event_name" = "Notification" ]
then
    notification_type=$(jq -r '.notification_type' <<< $input)
    _msg_source="$(center_dialog_message "tmux: $tmux_source")"
    _msg_event="$(center_dialog_message "[$notification_type]")"
    _msg_break="$(center_dialog_message "---")"
    _msg=$(jq -r '.message' <<< $input)
    if [ "$notification_type" = "idle_prompt" ]
    then
        osascript -e 'display notification "'"$_msg_source\n$_msg_break\n$_msg_event\n$_msg"'" with title "Claude Code"'
    else
        osascript -e 'display dialog "'"$_msg_source\n$_msg_break\n$_msg_event\n$_msg"'" buttons {"Got it"} default button "Got it" with title "Claude Code"'
    fi
fi
