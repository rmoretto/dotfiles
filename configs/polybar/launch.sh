#!/usr/bin/env bash

polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

LEFT='DP-3'
CENTER='DP-4'
RIGHT='DP-2'

polybar center 2>&1 | tee -a /tmp/polybar1.log & disown
MONITOR=$LEFT polybar left 2>&1 | tee -a /tmp/polybar1.log & disown
MONITOR=$RIGHT polybar right 2>&1 | tee -a /tmp/polybar1.log & disown

# exit 0
#
# # Terminate already running bar instances
# killall -qr polybar
#
# # Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#
# # Verify if we are using a laptop or desktop for choosing the bars
# DMI_DESKTOP_ID=3
# [ "$(cat /sys/class/dmi/id/chassis_type)" -ne ${DMI_DESKTOP_ID} ] && IS_LAPTOP=1 || IS_LAPTOP=0
#
# echo "Is laptop: ${IS_LAPTOP}"
#
# # Get the primary and secondary monitors
# PRIMARY_MONITOR=$(xrandr | grep " connected primary" | cut -f1 -d' ')
# SECONDARY_MONITOR=$(xrandr | grep -P " connected ([\d]*)x([\d]*)\+([\d]*)\+([\d]*) \(" | grep -v "primary" | cut -f1 -d' ')
# TERCEARY_MONITOR=$(xrandr | grep -P " connected ([\d]*)x([\d]*)\+([\d]*)\+([\d]*) right" | grep -v "primary" | cut -f1 -d' ')
#
# if [ ${IS_LAPTOP} -eq 0 ]; then
#   # We are in the Desktop land, use the default bars
#   MONITOR=${PRIMARY_MONITOR} NET_IF=enp3s0 polybar -c ~/.config/polybar/config.ini --reload main &
#   [ -n "${SECONDARY_MONITOR}" ] && MONITOR=${SECONDARY_MONITOR} polybar -c ~/.config/polybar/config.ini --reload secondary &
#   [ -n "${TERCEARY_MONITOR}" ] && MONITOR=${TERCEARY_MONITOR} NET_IF=wlo1 polybar -c ~/.config/polybar/config.ini --reload secondary &
# else
#   # We are in the Laptop land, use the default bars
#   MONITOR=${PRIMARY_MONITOR} polybar -c ~/.config/polybar/config.ini --reload main_notebook &
#   [ -n "${SECONDARY_MONITOR}" ] && MONITOR=${SECONDARY_MONITOR} NET_IF=wlo1 polybar -c ~/.config/polybar/config.ini --reload secondary_notebook &
# fi
#
# echo "Bars launched..."
