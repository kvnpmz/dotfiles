#!/usr/bin/env bash

render_contexts() {
    if ! output=$(argenctl context list --json 2>/dev/null); then
        printf " error\n"
        return
    fi

    local line=""
    for name in browser terminal files general; do
        local is_current
        is_current=$(echo "$output" | jq -r --arg n "$name" '.[] | select(.name == $n) | .current')
        
        if [ "$is_current" = "true" ]; then
            line="${line} ${name}  "
        else
            line="${line} ${name}  "
        fi
    done
    echo "$line"
}

# Handle signal for instant updates (e.g., trap USR1 or RTMIN+8 equivalent)
trap 'render_contexts' USR1

# Initial render
render_contexts

# Poll every 10 seconds
while true; do
    sleep 10 &
    wait $!
    render_contexts
done
