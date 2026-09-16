#!/usr/bin/bash
target_name="$1"

if ! output=$(argenctl context list --json 2>/dev/null); then
    printf '{"text": "", "class": ["error"]}\n'
    exit 0
fi

is_current=$(echo "$output" | jq -r --arg name "$target_name" '.[] | select(.name == $name) | .current')

if [ "$is_current" = "true" ]; then
    printf '{"text": "", "alt": "%s", "class": ["active"]}\n' "$target_name"
else
    printf '{"text": "", "alt": "%s", "class": ["inactive"]}\n' "$target_name"
fi
