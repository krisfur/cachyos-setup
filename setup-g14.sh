#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Installing Zephyrus G14 utilities..."
paru -S --needed --noconfirm asusctl

echo "Enabling ASUS control daemon..."
sudo systemctl enable --now asusd

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

echo "G14 setup complete."
