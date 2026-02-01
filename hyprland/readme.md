# Hyprland

Setting up a hyprland clean install of CachyOS for actual use.

> In the installer select limine+hyprland and make sure to use the wifi network you will continue the rest of the setup on.

![screenshot](./screenshot.png)

## Install core programs

```bash
paru -S waybar swww ghostty thunar \
swaync hyprpolkitagent hyprlock \
bluetuith-bin gazelle-tui hyprshot \
fuzzel nwg-look qt6-wayland helium-browser-bin \
neovim github-cli nordic-theme papirus-icon-theme \
nodejs npm tree-sitter-cli cmake go zig uv typst \
brightnessctl ttf-jetbrains-mono-nerd imv mpv \
audacious gimp viu
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

SDDM theme:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
```

and select `purple leaves`.

Remove bloat:

```bash
paru -R alacritty firefox dolphin kitty meld
```

## Configs

```bash
#wallpaper
cp ../wallpaper.png ~/.config/hypr/
#hyprland
cp hyprland.conf ~/.config/hypr/
#fuzzel
mkdir -p ~/.config/fuzzel
cp fuzzel.ini ~/.config/fuzzel/
#waybar
mkdir -p ~/.config/waybar
cp waybar-style.css ~/.config/waybar/style.css
cp waybar-config ~/.config/waybar/config
#neovim
mkdir -p ~/.config/nvim
cp ../neovim/init.lua ~/.config/nvim/
#hyprlock
cp hyprlock.conf ~/.config/hypr/
#swaync
mkdir -p ~/.config/swaync
cp swaync-style.css ~/.config/swaync/style.css
```

git config:

```bash
git config --global user.email "k_furman@outlook.com"
git config --global user.name "Krzysztof Furman"
git config --global init.defaultBranch main
```

