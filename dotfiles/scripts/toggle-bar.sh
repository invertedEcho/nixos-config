#!/bin/sh
if pgrep -f 'waybar' >/dev/null
then
    notify-send "Killing waybar..."
    ps aux | grep 'waybar' | grep -v grep | awk '{print $2}' | xargs kill
else
    notify-send "Starting waybar..."
    waybar
fi
