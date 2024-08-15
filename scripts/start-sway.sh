#!/bin/sh
# Sway startup script taken from
# https://man.sr.ht/~kennylevinsen/greetd/#how-to-set-xdg_session_typewayland

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

# Wayland stuff for Native GTK/QT/SDL2 applications:
# NOTES (04.04.2024):
# - Both gtk3 and gtk4 will default to the Wayland backend.
# - Install `qt5-wayland` and `qt6-wayland` for QT support.
# - Steam might still need `SDL_VIDEODRIVER=x11`, either while starting `steam` or game run options.
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM="wayland;xcb"
export SDL_VIDEODRIVER=wayland

# Electron, Java (for heavens sake...)
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

exec sway --unsupported-gpu "$@"

