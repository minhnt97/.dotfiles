#!/bin/bash
# install: pywal, swww, waybar, wlogout

wallpaper=$1

# Create images for lock
magick $wallpaper -resize 75% -blur 50x30 ~/.cache/blurred_wallpaper.png 
magick $wallpaper -gravity Center -extent 1:1 ~/.cache/square_wallpaper.png

# Generate color scheme based on wallpaper
echo ":: Execute pywal with $wallpaper" 
wal -q -i $wallpaper 

# Set wallpaper
echo ":: Execute swww with $wallpaper" 
swww img $wallpaper 

# Reload Waybar
~/.config/hypr/scripts/launch-waybar.sh 

