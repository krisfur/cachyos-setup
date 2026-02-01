# Hyprland

Setting up a hyprland clean install of CachyOS for actual use.

> In the installer select limine+hyprland and make sure to use the wifi network you will continue the rest of the setup on.

## Install core programs

```bash
paru -S waybar swww ghostty thunar \
swaync hyprpolkitagent hyprlock \
bluetuith-bin gazelle-tui hyprshot \
fuzzel nwg-look qt6-wayland helium-browser-bin \
neovim github-cli nordic-theme papirus-icon-theme \
nodejs npm tree-sitter-cli cmake go zig uv typst
```

and add user to input group for waybar:

```bash
sudo usermod -aG input $USER
```

`Claude Code`:
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

`Rust`:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

`Bun`:
```bash
curl -fsSL https://bun.sh/install | bash
```

Theme stuff:

```bash
nwg-look
```

and set to `nordic`.

Fastfetch:

```bash
fastfetch --gen-config
cp ../fastfetch/* ~/.config/fastfetch/
fastfetch --logo-recache
```

## Configs

```bash
cp ../wallpaper.png ~/.config/hypr/
cp hyprland.conf ~/.config/hypr/
mkdir -p ~/.config/fuzzel
cp fuzzel.ini ~/.config/fuzzel/
mkdir -p ~/.config/waybar
cp style.css ~/.config/waybar/
mkdir -p ~/.config/nvim
cp ../neovim/init.lua ~/.config/nvim/
```
