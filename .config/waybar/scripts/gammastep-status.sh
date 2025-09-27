#!/bin/bash

STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/nightmode_state"

if [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "on" ]]; then
    echo '{"text": "🌙", "tooltip": "On", "class": "nightmode" }'
else
    echo '{"text": "☀️", "tooltip": "Off", "class": "nightmode"}'
fi
