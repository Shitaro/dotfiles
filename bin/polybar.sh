#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get connected monitors
monitor_list=$(xrandr -q | grep " connected" | cut -d ' ' -f 1)

# Launch bars
for monitor in ${monitor_list}; do
    polybar --reload ${monitor} &
done
