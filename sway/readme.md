# Sway

Sway-specific files for this setup live in this directory.

## Install

From the repo root:

```bash
./setup-sway.sh
```

The script configures `tty1` to autologin as the user running `./setup-sway.sh` on the next boot and installs a Fish autostart hook for `sway --unsupported-gpu`.
This avoids a display manager entirely, which is often simpler on hybrid-GPU laptops.

## Shared Dev Tooling

`./setup-sway.sh` calls `./setup-mise.sh`, which:

- installs `mise` via `paru`
- copies `mise-setup/mise/config.toml` to `~/.config/mise/config.toml`
- installs the shared toolchain with `mise install`
- installs a Fish activation snippet in `~/.config/fish/conf.d/`

Neovim config is copied from `../mise-setup/nvim/init.lua`, so the nested `mise-setup` submodule is the only Neovim source of truth in this repo.

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

`setup-sway.sh` reuses shared files from `../hyprland/` and `../mise-setup/` instead of duplicating them here:

- wallpaper
- fuzzel config
- Waybar CSS
- swaync CSS
- gazelle config
- Neovim config from `../mise-setup/nvim/`

## Notes

- screenshots use `grim` + `slurp`, with `jq` for focused-window capture
- the polkit agent is `polkit-gnome`
- login is handled by `agetty` autologin on `tty1`
- Sway starts from `~/.config/fish/conf.d/cachyos-sway-autostart.fish` with `--unsupported-gpu`
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

but that defaults to 720p.

For a 1440p display:  

```bash
gamescope -f -W 2560 -H 1440 -w 2560 -h 1440 -- %command%
```

(anaolgously for other displays like the Zephyrus G14's 2880x1800 etc.)

## Zephyrus G14

For the ASUS-specific keyboard lighting and WirePlumber audio fix, run the shared hardware script from the repo root:

```bash
./setup-g14.sh
```

- Set `output * scale 1.5` in `~/.config/sway/config`. (1.6 breaks `imv` as buffer is not divisible by 2)
- Remap the G14 M4 macro button for screenshots by replacing `Print` with `XF86Launch1` in `sway/config`.

If need be for external monitors find the avaialble refresh rates:

```bash
swaymsg -t get_outputs
```

and set the desired one like this for thunderbolt:

```bash
swaymsg output DP-3 mode 2560x1440@144Hz
```

or like this for HDMI port:

```bash
swaymsg output HDMI-A-1 mode 2560x1440@144Hz
```

This should persist for the same monitor on reconnecting.
