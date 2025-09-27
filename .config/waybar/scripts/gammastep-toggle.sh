#!/bin/bash

STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/nightmode_state"

DAY_TEMP=6500
NIGHT_TEMP=3500

# Check if gammastep is running, if not start it
# if ! pgrep -x "gammastep" > /dev/null; then
#    gammastep -l 40.7:-74.0 &  # Replace with your actual lat/lon
#    sleep 1
# fi

killall gammastep

if [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "on" ]]; then
    gammastep -P -O "$DAY_TEMP" &
    echo "off" > "$STATE_FILE"
else
    gammastep -P -O "$NIGHT_TEMP" &
    echo "on" > "$STATE_FILE"
fi
