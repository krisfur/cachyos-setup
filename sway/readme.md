# Sway

Sway-specific files for this setup live in this directory.

## Install

From the repo root:

```bash
./setup-sway.sh
```

## Files here

- `config`: main Sway config
- `waybar-config`: Sway version of the Waybar config
- `swaylock.conf`: lock screen config

## Shared assets

`setup-sway.sh` reuses shared files from `../hyprland/` instead of duplicating them here:

- wallpaper
- fuzzel config
- Waybar CSS
- swaync CSS
- gazelle config
- SDDM theme

## Notes

- screenshots use `grim` + `slurp`
- the polkit agent is `polkit-gnome`
- for high-DPI displays, edit `~/.config/sway/config` and adjust `output * scale`
