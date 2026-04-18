#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Installing Zephyrus G14 utilities..."
paru -S --needed --noconfirm asusctl

echo "Preparing ASUS control daemon..."
sudo install -d -m 755 /etc/asusd
sudo systemctl reset-failed asusd || true
sudo systemctl start asusd

echo "Configuring keyboard lighting..."
asusctl aura effect static --colour 5E81AC

echo "Configuring slash lighting if supported..."
asusctl slash --mode Static 2>/dev/null || printf 'Skipping slash lighting; not supported on this model.\n'

echo "Ensuring Sway session supports NVIDIA..."
sway_session=/usr/share/wayland-sessions/sway.desktop
if [ -f "$sway_session" ]; then
    if grep -Eq '^Exec=.*--unsupported-gpu([[:space:]]|$)' "$sway_session"; then
        printf 'Sway session already includes --unsupported-gpu.\n'
    elif grep -q '^Exec=' "$sway_session"; then
        sudo sed -i '/^Exec=/ s|$| --unsupported-gpu|' "$sway_session"
        printf 'Patched Sway session to launch with --unsupported-gpu.\n'
    else
        printf 'Skipping Sway session patch; no Exec line found in %s.\n' "$sway_session"
    fi
else
    printf 'Skipping Sway session patch; %s not found.\n' "$sway_session"
fi

echo "Installing WirePlumber G14 soft-mixer fix..."
sudo install -d -m 755 /etc/wireplumber/wireplumber.conf.d
printf '%s\n' \
    'monitor.alsa.rules = [' \
    '  {' \
    '    matches = [' \
    '      {' \
    '        device.name = "~alsa_card.*"' \
    '      }' \
    '    ]' \
    '    actions = {' \
    '      update-props = {' \
    '        api.alsa.soft-mixer = true' \
    '        api.alsa.ignore-dB = true' \
    '      }' \
    '    }' \
    '  }' \
    ']' | sudo tee /etc/wireplumber/wireplumber.conf.d/51-g14-softmixer.conf >/dev/null

echo "Restarting audio services..."
systemctl --user restart wireplumber pipewire pipewire-pulse

echo "Applying mixer levels..."
amixer -c 2 set Master 100%
amixer -c 2 set Speaker 100%
amixer -c 2 set PCM 100%
amixer -c 2 set 'Bass Speaker' on
amixer -c 2 set 'AMP1 Speaker' 0dB
amixer -c 2 set 'AMP2 Speaker' 0dB
sudo alsactl store

patch_sway_config() {
    local config="$HOME/.config/sway/config"
    local tmp

    if [ ! -f "$config" ]; then
        printf 'Skipping Sway config patch; %s not found.\n' "$config"
        return
    fi

    tmp="$(mktemp)"
    sed -E \
        -e 's|^output \* scale .*$|output * scale 1.5|' \
        -e 's|^bindsym Print |bindsym XF86Launch1 |' \
        -e 's|^bindsym \$mod\+Shift\+Print |bindsym $mod+Shift+XF86Launch1 |' \
        -e 's|^bindsym \$mod\+Print |bindsym $mod+XF86Launch1 |' \
        "$config" > "$tmp"

    if cmp -s "$config" "$tmp"; then
        printf 'Sway config already has G14 scale and screenshot remaps.\n'
    else
        chmod --reference="$config" "$tmp"
        mv "$tmp" "$config"
        printf 'Patched Sway config for G14 scale and screenshot remaps.\n'
        return
    fi

    rm -f "$tmp"
}

patch_hyprland_config() {
    local config="$HOME/.config/hypr/hyprland.conf"
    local tmp

    if [ ! -f "$config" ]; then
        printf 'Skipping Hyprland config patch; %s not found.\n' "$config"
        return
    fi

    tmp="$(mktemp)"
    sed -E \
        -e 's|^monitor=,preferred,auto,.*$|monitor=,preferred,auto,1.5|' \
        -e 's|^bind = , *Print, exec, hyprshot -m region$|bind = , XF86Launch1, exec, hyprshot -m region|' \
        -e 's|^bind = \$mainMod SHIFT, *Print, exec, hyprshot -m output$|bind = $mainMod SHIFT, XF86Launch1, exec, hyprshot -m output|' \
        -e 's|^bind = \$mainMod, *Print, exec, hyprshot -m window$|bind = $mainMod, XF86Launch1, exec, hyprshot -m window|' \
        "$config" > "$tmp"

    if cmp -s "$config" "$tmp"; then
        printf 'Hyprland config already has G14 scale and screenshot remaps.\n'
    else
        chmod --reference="$config" "$tmp"
        mv "$tmp" "$config"
        printf 'Patched Hyprland config for G14 scale and screenshot remaps.\n'
        return
    fi

    rm -f "$tmp"
}

echo "Patching installed compositor configs for G14..."
patch_sway_config
patch_hyprland_config

echo "G14 setup complete."
