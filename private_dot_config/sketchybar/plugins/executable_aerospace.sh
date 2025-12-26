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

# Check which monitor this workspace belongs to
# Monitor 1 = external, Monitor 2 = built-in
EXTERNAL_WORKSPACES=$(aerospace list-workspaces --monitor 1 2>/dev/null)
IS_EXTERNAL=false
for ws in $EXTERNAL_WORKSPACES; do
    if [ "$ws" = "$SID" ]; then
        IS_EXTERNAL=true
        break
    fi
done

# Icon settings for monitor indication
# External monitor: monitor icon, Built-in: laptop icon
if [ "$IS_EXTERNAL" = true ]; then
    MONITOR_ICON="󰍹"
else
    MONITOR_ICON="󰌢"
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
