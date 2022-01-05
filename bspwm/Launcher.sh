#!/bin/bash

## Add this to your wm startup file.
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
monitor=$(bspc query --monitors --names | grep -v LVDS-1 | head -n 1)
current=$(xrandr --query | awk '/\<current\>/{print $8}')

#if [[ $monitor = *VGA-1* ]] || [[ $monitor = *HDMI-1* ]] && [[ $current -ge 1700 ]]; then
#	polybar -c $HOME/.config/polybar/polybar-themes/polybar-8/config.ini main 2>$HOME/.config/polybar/log/log_main &
#	polybar -c $HOME/.config/polybar/polybar-themes/polybar-8/config.ini $monitor 2>$HOME/.config/polybar/log/log_extern &
#else
#	polybar -c $HOME/.config/polybar/polybar-themes/polybar-8/config.ini $monitor 2>$HOME/.config/polybar/log/log_main &
#fi

if [[ $monitor = *VGA-1* ]] || [[ $monitor = *HDMI-1* ]] && [[ $current -ge 1700 ]]; then
	polybar -c $HOME/.config/polybar/config main 2>$HOME/.config/polybar/log/log_main &
	polybar -c $HOME/.config/polybar/config $monitor 2>$HOME/.config/polybar/log/log_extern &
else
	polybar -c $HOME/.config/polybar/config main 2>$HOME/.config/polybar/log/log_main &
fi
