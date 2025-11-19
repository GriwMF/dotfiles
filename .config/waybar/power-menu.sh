#!/bin/bash

# Power menu script for Waybar

if command -v wofi &> /dev/null; then
    MENU_CMD="wofi --dmenu -p Power"
elif command -v rofi &> /dev/null; then
    MENU_CMD="rofi -dmenu -p Power"
else
    notify-send "Error" "wofi or rofi required"
    exit 1
fi

OPTIONS="Lock
Logout
Suspend
Reboot
Shutdown"

choice=$(echo -e "$OPTIONS" | $MENU_CMD)

# Execute the chosen action
case "$choice" in
    *Lock*)
        hyprlock || notify-send "Error" "hyprlock not found"
        ;;
    *Logout*)
        hyprctl dispatch exit
        ;;
    *Suspend*)
        systemctl suspend
        ;;
    *Reboot*)
        systemctl reboot
        ;;
    *Shutdown*)
        systemctl poweroff
        ;;
    *)
        # User cancelled or no selection
        exit 0
        ;;
esac
