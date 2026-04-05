# Sway

Sway-specific files for this setup live in this directory.

## Install

From the repo root:

```bash
./setup-sway.sh
```

The script installs and enables `greetd` with `tuigreet`, so the machine should boot to a login prompt and start `sway` after you log in.
`tuigreet` is configured with a user menu, remembered user/session, masked password feedback, and a clock.

## Files here

- `config`: main Sway config
- `waybar-config`: Sway version of the Waybar config
- `swaylock.conf`: lock screen config
- `gtk-3.0-settings.ini`: GTK 3 theme settings
- `gtk-4.0-settings.ini`: GTK 4 theme settings
- `sway-portals.conf`: portal backend selection for Sway
- `cycle-workspace.sh`: clamped workspace cycling helper for gestures
- `screenshot-window.sh`: focused-window screenshot helper

## Shared assets

`setup-sway.sh` reuses shared files from `../hyprland/` instead of duplicating them here:

- wallpaper
- fuzzel config
- Waybar CSS
- swaync CSS
- gazelle config

## Notes

- screenshots use `grim` + `slurp`, with `jq` for focused-window capture
- the polkit agent is `polkit-gnome`
- login is handled by `greetd` + `tuigreet`
- `tuigreet` uses `--user-menu --remember --remember-user-session --asterisks --time`
- locking uses `swaylock-effects` with a blurred version of the wallpaper
- there is no idle autolock; locking is manual or triggered by closing the laptop lid
- three-finger horizontal swipes move across numbered workspaces and clamp to one past the highest occupied workspace
- portals use `xdg-desktop-portal-gtk` by default and `xdg-desktop-portal-wlr` for screenshots and screencasts
- for high-DPI displays, edit `~/.config/sway/config` and adjust `output * scale`

## Steam

If you use output scaling above `1`, XWayland games can end up blurry or lose native resolutions under stock Sway.
`gamescope` is installed as the minimal workaround for Steam games.

In a game's Steam launch options, start with:

```bash
gamescope -f -- %command%
```

For a 4K display where you want the game rendered at 1080p and presented fullscreen at 4K:

```bash
gamescope -f -w 1920 -h 1080 -W 3840 -H 2160 -- %command%
```
