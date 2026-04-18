#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Fetching latest submodules..."
git submodule update --init --remote --recursive

echo "Installing core programs..."
paru -S --needed --noconfirm waybar awww ghostty thunar \
    swaync hyprpolkitagent hyprlock xarchiver \
    bluetuith-bin gazelle-tui hyprshot \
    fuzzel nwg-look qt6-wayland helium-browser-bin \
    nordic-theme papirus-icon-theme \
    brightnessctl ttf-jetbrains-mono-nerd imv mpv \
    gimp viu wl-clipboard localsend \
    docker gvfs gvfs-mtp libmtp android-udev \
    fastfetch

echo "Adding user to input group..."
sudo usermod -aG input "$USER"

echo "Setting up shared development tooling..."
./setup-mise.sh

echo "Creating config directories..."
mkdir -p \
    "$HOME/.config/hypr" \
    "$HOME/.config/fuzzel" \
    "$HOME/.config/waybar" \
    "$HOME/.config/nvim" \
    "$HOME/.config/swaync" \
    "$HOME/.config/gazelle" \
    "$HOME/.config/fastfetch" \
    "$HOME/.local/share/applications"

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
cp hyprland/fuzzel.ini ~/.config/fuzzel/
cp hyprland/waybar-style.css ~/.config/waybar/style.css
cp hyprland/waybar-config ~/.config/waybar/config
cp mise-setup/nvim/init.lua ~/.config/nvim/
cp hyprland/hyprlock.conf ~/.config/hypr/
cp hyprland/swaync-style.css ~/.config/swaync/style.css
cp hyprland/gazelle-config.json ~/.config/gazelle/config.json
cp hyprland/.desktop ~/.local/share/applications/

echo "Adding ufw rules for localsend..."
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp

echo "Configuring git..."
git config --global user.email "k_furman@outlook.com"
git config --global user.name "Krzysztof Furman"
git config --global init.defaultBranch main

echo "Removing bloat..."
paru -R --noconfirm alacritty firefox dolphin kitty meld 2>/dev/null || true

echo "Creating docker group..."
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

echo "Setup complete! Log out and back in for all changes to take effect."
echo ""
echo "NOTE: For high-DPI displays (3K+, 4K+), edit ~/.config/hypr/hyprland.conf"
echo "and adjust the monitor scale factor (e.g., 1.5 or 2.0). See the commented"
echo "example in the MONITORS section of the config."
