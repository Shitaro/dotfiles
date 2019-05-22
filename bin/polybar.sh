#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar DP-0 &
polybar DVI-D-0 &
polybar eDP-1-1 &
polybar HDMI-1-1 &
polybar DP1 &
polybar HDMI1 &

echo "Bars launched..."
