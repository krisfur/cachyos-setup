#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Installing mise..."
paru -S --needed --noconfirm mise

echo "Creating mise config directories..."
mkdir -p "$HOME/.config/mise" "$HOME/.config/fish/conf.d"

echo "Configuring mise..."
install -m 644 mise-setup/mise/config.toml ~/.config/mise/config.toml
printf '%s\n' 'mise activate fish | source' > "$HOME/.config/fish/conf.d/mise-activate.fish"

echo "Installing development tools with mise..."
mise install
