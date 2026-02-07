#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Installing core programs..."
paru -S --needed --noconfirm waybar swww ghostty thunar \
    swaync hyprpolkitagent hyprlock \
    bluetuith-bin gazelle-tui hyprshot \
    fuzzel qt6-wayland helium-browser-bin \
    neovim github-cli nordic-theme papirus-icon-theme \
    nodejs npm tree-sitter-cli cmake go zig uv typst \
    brightnessctl ttf-jetbrains-mono-nerd imv mpv \
    audacious gimp viu wl-clipboard opencode-bin

echo "Adding user to input group..."
sudo usermod -aG input "$USER"

echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "Installing Bun..."
curl -fsSL https://bun.sh/install | bash

echo "Installing Paclook..."
curl -fL https://github.com/krisfur/paclook/releases/download/v0.9.2/paclook-v0.9.2-linux-x86_64.tar.gz | tar -xz
sudo install -m 755 paclook-v0.9.2-linux-x86_64/paclook /usr/local/bin/paclook
rm -r paclook-v0.9.2-linux-x86_64/

echo "Setting up Fastfetch..."
fastfetch --gen-config
cp fastfetch/* ~/.config/fastfetch/
fastfetch --logo-recache

echo "Setting up SDDM theme..."
sudo cp -r hyprland/sddm/ /usr/share/sddm/themes/nordic-mountains/
echo -e "[Theme]\nCurrent=nordic-mountains" | sudo tee /etc/sddm.conf

echo "Copying configs..."
cp hyprland/wallpaper.png ~/.config/hypr/
cp hyprland/hyprland.conf ~/.config/hypr/
mkdir -p ~/.config/fuzzel
cp hyprland/fuzzel.ini ~/.config/fuzzel/
mkdir -p ~/.config/waybar
cp hyprland/waybar-style.css ~/.config/waybar/style.css
cp hyprland/waybar-config ~/.config/waybar/config
mkdir -p ~/.config/nvim
cp neovim/init.lua ~/.config/nvim/
cp hyprland/hyprlock.conf ~/.config/hypr/
mkdir -p ~/.config/swaync
cp hyprland/swaync-style.css ~/.config/swaync/style.css
mkdir -p ~/.config/gazelle
cp hyprland/gazelle-config.json ~/.config/gazelle/config.json

echo "Configuring git..."
git config --global user.email "k_furman@outlook.com"
git config --global user.name "Krzysztof Furman"
git config --global init.defaultBranch main

echo "Removing bloat..."
paru -R --noconfirm alacritty firefox dolphin kitty meld 2>/dev/null || true

echo "Setup complete! Log out and back in for all changes to take effect."
echo ""
echo "NOTE: For high-DPI displays (3K+, 4K+), edit ~/.config/hypr/hyprland.conf"
echo "and adjust the monitor scale factor (e.g., 1.5 or 2.0). See the commented"
echo "example in the MONITORS section of the config."
