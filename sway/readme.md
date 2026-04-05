# Sway

Sway-specific files for this setup live in this directory.

## Install

From the repo root:

```bash
./setup-sway.sh
```

The script installs and enables `greetd` with `tuigreet`, so the machine should boot to a login prompt and start `sway` after you log in.
`tuigreet` is configured with `--remember`, so the last username is pre-filled on the next boot.

## Files here

- `config`: main Sway config
- `waybar-config`: Sway version of the Waybar config
- `swaylock.conf`: lock screen config
- `gtk-3.0-settings.ini`: GTK 3 theme settings
- `gtk-4.0-settings.ini`: GTK 4 theme settings
- `sway-portals.conf`: portal backend selection for Sway

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
- portals use `xdg-desktop-portal-gtk` by default and `xdg-desktop-portal-wlr` for screenshots and screencasts
- for high-DPI displays, edit `~/.config/sway/config` and adjust `output * scale`
