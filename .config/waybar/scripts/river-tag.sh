#!/usr/bin/bash

target_index="$1"
current_tag="$(cat "$XDG_RUNTIME_DIR/river-focused-tag" 2>/dev/null)"

if [ "$target_index" = "$current_tag" ]; then
    printf '{"text":"","class":["active"]}\n'
else
    printf '{"text":"","class":["inactive"]}\n'
fi
