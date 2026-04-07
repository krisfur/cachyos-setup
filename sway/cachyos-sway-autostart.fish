if status is-login; and status is-interactive
    if test (tty) = /dev/tty1; and not set -q DISPLAY; and not set -q WAYLAND_DISPLAY
        sway --unsupported-gpu
    end
end
