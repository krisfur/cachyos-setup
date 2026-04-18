# Hyprland

Setting up a hyprland clean install of CachyOS for actual use.

> In the installer select limine+hyprland and make sure to use the wifi network you will continue the rest of the setup on.

![screenshot](./screenshot.png)

## Install

```bash
./setup-hyprland.sh
```

The script installs the Hyprland desktop packages, applies the SDDM theme, bootstraps the shared `mise` toolchain, copies the configs in this directory, enables Docker, and opens the required `ufw` rules for `localsend`.

## Shared Dev Tooling

`./setup-hyprland.sh` calls `./setup-mise.sh`, which:

- installs `mise` via `paru`
- copies `mise-setup/mise/config.toml` to `~/.config/mise/config.toml`
- installs the shared toolchain with `mise install`
- installs a Fish activation snippet in `~/.config/fish/conf.d/`

Neovim config is copied from `../mise-setup/nvim/init.lua`, so the nested `mise-setup` submodule is the only Neovim source of truth in this repo.

## Files Here

- `hyprland.conf`: main Hyprland config
- `hyprlock.conf`: lock screen config
- `waybar-config`: Hyprland version of the Waybar config
- `waybar-style.css`: shared Waybar styling
- `fuzzel.ini`: launcher config
- `swaync-style.css`: notification center styling
- `gazelle-config.json`: `gazelle-tui` config
- `sddm/`: Nordic Mountains SDDM theme
- `.desktop`: desktop entry used for `fex`

## Notes

- set the GTK theme with `nwg-look`; the expected choice is `nordic`
- `fastfetch` config is generated and then overwritten from `../fastfetch/`
- `docker` is enabled as a system service and the user is added to the `docker` group
- `localsend` uses TCP and UDP port `53317`
- `t3code` is installed via the `t3code-bin` AUR package
- log out and back in after running the script so shell activation and group membership changes apply cleanly
- for high-DPI displays, edit `~/.config/hypr/hyprland.conf` and adjust the monitor scale factor

## Theme

```bash
nwg-look
```

and set to `nordic`.

## Zephyrus G14

Run the shared hardware script from the repo root:

```bash
./setup-g14.sh
```

- Set the display scale to `1.6` in `hyprland.conf`.

- Remap M4 to PrtSc:

in `hyprland.conf` replace `Print` with `XF86Launch1`.
