#!/usr/bin/env bash

argenctl context switch general
argenctl layout switch 2x2

WPV_PGID=

cleanup() {
    trap - INT TERM EXIT

    if [ -n "$WPV_PGID" ]; then
        kill -TERM -- "-$WPV_PGID" 2>/dev/null
        sleep 1
        kill -KILL -- "-$WPV_PGID" 2>/dev/null
    fi

    exit 0
}

revert_layout() {
    trap - INT TERM EXIT

    argenctl context switch general
    argenctl layout switch stacktile
    argenctl context switch terminal

    cleanup
}

trap revert_layout INT
trap cleanup TERM EXIT

setsid bash -c '
    for command in "$@"; do
        eval "$command" &>/dev/null &
        sleep 0.05
    done

    wait
' wpv-viewers "$@" &

WPV_PGID="$!"

wait "$WPV_PGID"

