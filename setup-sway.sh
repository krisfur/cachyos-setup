#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Fetching latest submodules..."
git submodule update --init --remote --recursive

echo "Installing core programs..."
paru -S --needed --noconfirm waybar sway gamescope ghostty thunar \
    greetd greetd-regreet cage \
    swaync polkit-gnome swaylock-effects swayidle swaybg \
    xarchiver bluetuith-bin gazelle-tui grim slurp \
    dconf xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr \
    ninja fuzzel nwg-look qt6-wayland helium-browser-bin jq \
    neovim github-cli nordic-theme papirus-icon-theme \
    nodejs npm tree-sitter-cli cmake go zig uv typst \
    brightnessctl ttf-jetbrains-mono-nerd imv mpv \
    gimp viu wl-clipboard opencode-bin localsend \
    clang docker gvfs gvfs-mtp libmtp android-udev \
    odin fastfetch swift-bin

echo "Adding user to input group..."
sudo usermod -aG input "$USER"

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo "Installing fex..."
cargo install fex

echo "Installing Bun..."
curl -fsSL https://bun.sh/install | bash

echo "Creating config directories..."
mkdir -p \
    "$HOME/.config/sway" \
    "$HOME/.config/swaylock" \
    "$HOME/.config/gtk-3.0" \
    "$HOME/.config/gtk-4.0" \
    "$HOME/.config/xdg-desktop-portal" \
    "$HOME/.config/fuzzel" \
    "$HOME/.config/waybar" \
    "$HOME/.config/nvim" \
    "$HOME/.config/swaync" \
    "$HOME/.config/gazelle" \
    "$HOME/.config/fastfetch" \
    "$HOME/.local/share/applications"

echo "Setting up Fastfetch..."
fastfetch --gen-config-force
cp fastfetch/* ~/.config/fastfetch/
fastfetch --logo-recache

echo "Copying configs..."
cp hyprland/wallpaper.png ~/.config/sway/
cp sway/config ~/.config/sway/config
install -m 755 sway/cycle-workspace.sh ~/.config/sway/cycle-workspace.sh
cp hyprland/fuzzel.ini ~/.config/fuzzel/
cp hyprland/waybar-style.css ~/.config/waybar/style.css
cp sway/waybar-config ~/.config/waybar/config
cp sway/gtk-3.0-settings.ini ~/.config/gtk-3.0/settings.ini
cp sway/gtk-4.0-settings.ini ~/.config/gtk-4.0/settings.ini
cp sway/sway-portals.conf ~/.config/xdg-desktop-portal/sway-portals.conf
cp neovim/init.lua ~/.config/nvim/
cp sway/swaylock.conf ~/.config/swaylock/config
cp hyprland/swaync-style.css ~/.config/swaync/style.css
cp hyprland/gazelle-config.json ~/.config/gazelle/config.json
cp hyprland/.desktop ~/.local/share/applications/

echo "Configuring greetd..."
sudo install -d -m 755 /etc/greetd
sudo install -d -o greeter -g greeter -m 755 /var/lib/regreet
sudo install -d -o greeter -g greeter -m 755 /var/log/regreet
sudo install -m 644 sway/regreet.toml /etc/greetd/regreet.toml
sudo install -m 644 sway/regreet.css /etc/greetd/regreet.css
sudo install -m 644 hyprland/wallpaper.png /etc/greetd/wallpaper.png
printf '%s\n' \
    '[terminal]' \
    'vt = 1' \
    '' \
    '[default_session]' \
    'command = "env GTK_USE_PORTAL=0 GDK_DEBUG=no-portals cage -s -- regreet"' \
    'user = "greeter"' | sudo tee /etc/greetd/config.toml >/dev/null
sudo systemctl enable greetd.service
sudo systemctl set-default graphical.target

echo "Adding ufw rules for localsend..."
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp

echo "Configuring git..."
git config --global user.email "k_furman@outlook.com"
git config --global user.name "Krzysztof Furman"
git config --global init.defaultBranch main

echo "Removing bloat..."
paru -R --noconfirm alacritty firefox alacritty foot meld 2>/dev/null || true

echo "Creating docker group..."
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

echo "Setup complete! Log out and back in for all changes to take effect."
echo ""
echo "A greetd login prompt will start on boot and launch Sway after login."
echo "NOTE: For high-DPI displays (3K+, 4K+), edit ~/.config/sway/config"
echo "and adjust the output scale factor (e.g., 1.5 or 2.0). See the commented"
echo "example near the top of the config."
