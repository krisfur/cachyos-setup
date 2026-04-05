#!/bin/bash
set -euo pipefail

direction=${1:-}
min_workspace=1
max_workspace=10

case "$direction" in
    next|prev)
        ;;
    *)
        printf 'Usage: %s <next|prev>\n' "$0" >&2
        exit 1
        ;;
esac

current_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .num')
if [[ ! "$current_workspace" =~ ^[0-9]+$ ]]; then
    current_workspace=$min_workspace
fi

highest_occupied=$(swaymsg -t get_tree | jq -r '
    [
        ..
        | objects
        | select(.type? == "workspace")
        | select((.name // "") | test("^[0-9]+$"))
        | select(((.nodes | length) + (.floating_nodes | length)) > 0)
        | (.name | tonumber)
    ] | max // 1
')

max_reachable=$((highest_occupied + 1))
if (( max_reachable < min_workspace )); then
    max_reachable=$min_workspace
fi
if (( max_reachable > max_workspace )); then
    max_reachable=$max_workspace
fi
if (( current_workspace > max_reachable )); then
    max_reachable=$current_workspace
fi

case "$direction" in
    next)
        target_workspace=$((current_workspace + 1))
        if (( target_workspace > max_reachable )); then
            target_workspace=$max_reachable
        fi
        ;;
    prev)
        target_workspace=$((current_workspace - 1))
        if (( target_workspace < min_workspace )); then
            target_workspace=$min_workspace
        fi
        ;;
esac

exec swaymsg workspace number "$target_workspace" >/dev/null
