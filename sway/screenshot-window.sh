#!/bin/bash
set -euo pipefail

screenshots_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshots_dir"

region=$(swaymsg -t get_tree | jq -r 'first(.. | objects | select((.type? == "con" or .type? == "floating_con") and .focused and (((.nodes | length) + (.floating_nodes | length)) == 0)) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)") // empty')

if [[ -z "$region" ]]; then
    exit 1
fi

exec grim -g "$region" "$screenshots_dir/$(date +%Y-%m-%d_%H-%M-%S).png"
