#!/usr/bin/env bash

while true; do
    if output=$(argenctl context list --json 2>/dev/null); then
        echo "$output" |
            jq -r 'sort_by(.id) | map(if .current then "  x" else "  " end) | join("")'
    else
        echo "  "
    fi

    sleep 0.5
done
