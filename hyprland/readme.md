# Hyprland

Setting up a hyprland clean install of CachyOS for actual use.

> In the installer select limine+hyprland and make sure to use the wifi network you will continue the rest of the setup on.

## Install core programs

```bash
paru -S waybar swww ghostty thunar \
swaync hyprpolkitagent hyprlock \
bluetuith-bin gazelle-tui hyprshot \
fuzzel nwg-look qt6-wayland helium-browser-bin \
neovim github-cli nordic-theme papirus-icon-theme
```

Theme stuff:

```bash
nwg-look
```

and set to `nordic`.

## Configs

```bash
cp hyprland.conf ~/.config/hypr/
cp ../wallpaper.png ~/.config/hypr/
mkdir -p ~/.config/fuzzel
cp fuzzel.ini ~/.config/fuzzel/
mkdir -p ~/.config/waybar
cp style.css ~/.config/waybar/
```
