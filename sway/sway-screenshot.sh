#!/bin/bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    printf 'Usage: %s {region|output|window}\n' "${0##*/}" >&2
    exit 2
fi

mode="$1"
screenshots_dir="$HOME/Pictures/Screenshots"
file="$screenshots_dir/$(date +%Y-%m-%d_%H-%M-%S).png"

mkdir -p "$screenshots_dir"

case "$mode" in
    region)
        region="$(slurp)"
        [[ -n "$region" ]]
        grim -g "$region" "$file"
        ;;
    output)
        output="$(slurp -o -f "%o")"
        [[ -n "$output" ]]
        grim -o "$output" "$file"
        ;;
    window)
        region="$(swaymsg -t get_tree | jq -r 'first(.. | objects | select((.type? == "con" or .type? == "floating_con") and .focused and (((.nodes | length) + (.floating_nodes | length)) == 0)) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)") // empty')"
        [[ -n "$region" ]]
        grim -g "$region" "$file"
        ;;
    *)
        printf 'Unknown mode: %s\n' "$mode" >&2
        exit 2
        ;;
esac

wl-copy --type image/png < "$file"
