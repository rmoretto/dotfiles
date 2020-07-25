#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar on multiple screens
MONITOR=DP-2 polybar -c ~/.config/polybar/config.ini --reload main &
MONITOR=DP-4 polybar -c ~/.config/polybar/config.ini --reload secondary &

echo "Bars launched..."