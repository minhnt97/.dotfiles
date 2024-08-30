#!/bin/bash

# Quit all running waybar instances
if pgrep -x "waybar" >/dev/null ;then
    echo ":: Kill previous waybar"
    killall waybar
fi

echo ":: Restart waybar"
waybar &
