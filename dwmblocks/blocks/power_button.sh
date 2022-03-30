#!/usr/bin/env bash

THEME="$HOME/wm/dwm-6.3/dwmblocks/blocks/power_button.rasi"


rofi_command="rofi -no-config -theme $THEME"

# Options
shutdown="Shutdown"
reboot="Restart"
lock="Lock"
suspend="Suspend"
logout="Logout"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/light-locker-command ]]; then
			light-locker-command -l
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
		systemctl suspend
        ;;
    $logout)
        loginctl kill-session $XDG_SESSION_ID
        ;;
esac
