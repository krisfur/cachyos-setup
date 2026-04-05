# Sway

Sway-specific files for this setup live in this directory.

## Install

From the repo root:

```bash
./setup-sway.sh
```

The script installs and enables `greetd` with `tuigreet`, so the machine should boot to a login prompt and start `sway` after you log in.

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

## Notes

- screenshots use `grim` + `slurp`
- the polkit agent is `polkit-gnome`
- login is handled by `greetd` + `tuigreet`
- for high-DPI displays, edit `~/.config/sway/config` and adjust `output * scale`
