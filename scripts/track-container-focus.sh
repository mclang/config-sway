#!/bin/sh
#
# Helper script for tracking Sway container/windows focus so that
# `Alt+Tab` between two latest windows work like in Windows.
#
# Original Gist:
# https://gist.github.com/ckafi/0a5b79105c8301466cc324a08200aad7
#

# Kill possible OLD processes that might be lingering around due to `exec_always`:
pkill -ef --older 1 "$0"

# These MUST be set after `pkill` b/c the return value of `pkill` is `1` if NO precesses were signaled!
# set -euo pipefail

prev_focus=$(swaymsg -r -t get_seats | jq '.[0].focus')

swaymsg -m -t subscribe '["window"]' | \
    jq --unbuffered 'select(.change == "focus").container.id' | \
    while read new_focus; do
        swaymsg "[con_id=${prev_focus}] mark --add _prev" &>/dev/null
        prev_focus=$new_focus
    done

