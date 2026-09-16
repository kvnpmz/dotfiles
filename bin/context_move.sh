#!/usr/bin/env bash

target_context="$1"

# Get the focused window ID and current context name
window_id=$(argenctl window list --json | jq -r '.[] | select(.focused == true) | .id')
[ -z "$window_id" ] && exit 1

current_context=$(argenctl context list --json | jq -r '.[0].name')
[ "$current_context" = "$target_context" ] && exit 0

# Ensure the target context exists, create it if missing
if ! argenctl context list --json | jq -e --arg name "$target_context" '.[] | select(.name == $name)' > /dev/null; then
    argenctl context new "$target_context"
fi

# Move window: switch to target, attach it, switch back, and detach from old
argenctl context switch "$target_context"
argenctl window attach "$window_id"
argenctl context switch "$current_context"
argenctl window detach "$window_id"
