#!/usr/bin/env bash

# Workspace ID passed as argument
SID="$1"

# Check if this workspace has any windows
WINDOW_COUNT=$(aerospace list-windows --workspace "$SID" 2>/dev/null | wc -l | tr -d ' ')

# Check if this workspace is visible on any monitor
VISIBLE_WORKSPACES=$(aerospace list-workspaces --monitor all --visible 2>/dev/null)
IS_VISIBLE=false
for ws in $VISIBLE_WORKSPACES; do
    if [ "$ws" = "$SID" ]; then
        IS_VISIBLE=true
        break
    fi
done

# Find which monitor this workspace belongs to and get its name
MONITOR_NAME=""
for mid in $(aerospace list-monitors --format '%{monitor-id}'); do
    if aerospace list-workspaces --monitor "$mid" 2>/dev/null | grep -qx "$SID"; then
        MONITOR_NAME=$(aerospace list-monitors --format '%{monitor-id}|%{monitor-name}' | grep "^$mid|" | cut -d'|' -f2)
        break
    fi
done

# Icon based on monitor name
# Built-in display: laptop icon, External display: monitor icon
if [[ "$MONITOR_NAME" == *"Built-in"* ]]; then
    MONITOR_ICON="󰌢"
else
    MONITOR_ICON="󰍹"
fi

# Tokyo Night theme colors:
# - Focused: Orange #ff9e64
# - Visible (other monitor): Green #9ece6a
# - Background (has windows, not visible): Blue #7aa2f7
# - Empty: Dim gray #565f89

if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
    # Focused workspace: orange background
    sketchybar --set $NAME background.drawing=on \
                           background.color=0xffff9e64 \
                           icon="$MONITOR_ICON" \
                           icon.drawing=on \
                           icon.color=0xff1a1b26 \
                           label.color=0xff1a1b26
elif [ "$IS_VISIBLE" = true ]; then
    # Visible on another monitor: green background
    sketchybar --set $NAME background.drawing=on \
                           background.color=0xff9ece6a \
                           icon="$MONITOR_ICON" \
                           icon.drawing=on \
                           icon.color=0xff1a1b26 \
                           label.color=0xff1a1b26
elif [ "$WINDOW_COUNT" -gt 0 ]; then
    # Has windows but not visible (background): blue background
    sketchybar --set $NAME background.drawing=on \
                           background.color=0xff7aa2f7 \
                           icon="$MONITOR_ICON" \
                           icon.drawing=on \
                           icon.color=0xff1a1b26 \
                           label.color=0xff1a1b26
else
    # Empty workspace: dim gray text, no background
    sketchybar --set $NAME background.drawing=off \
                           icon.drawing=off \
                           label.color=0xff565f89
fi
