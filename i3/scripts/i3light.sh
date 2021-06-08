#! /usr/bin/env bash

notification_time=250
light_delta=250

light=$(cat /sys/class/backlight/intel_backlight/brightness)
actual_light=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
max_light=$(cat /sys/class/backlight/intel_backlight/max_brightness)
up_light=$(($light+$light_delta))
down_light=$(($light-$light_delta))

if [ -z $1 ] ; then
    echo "Usage: i3light {up|down}"
    exit 2
elif [ $actual_light = "100.00" ] && [ $1 = "up" ] ; then
    exit 1
elif [ $actual_light = "0.00" ] && [ $1 = "down" ] ; then
    exit 1
else
    case "$1" in
        up)
		if [[ "$actual_light" -lt "4600" ]]; then
			echo $up_light > /sys/class/backlight/intel_backlight/brightness
			notify-send --expire-time=$notification_time "$(light -G) "
		else
			echo $max_light > /sys/class/backlight/intel_backlight/brightness
			notify-send --expire-time=$notification_time "$(light -G) "
		fi
        ;;
        down)
		if [[ "$actual_light" -ge "$light_delta" ]]; then
			echo $down_light > /sys/class/backlight/intel_backlight/brightness
			notify-send --expire-time=$notification_time "$(light -G) "
		else
			echo 0 > /sys/class/backlight/intel_backlight/brightness
			notify-send --expire-time=$notification_time "$(light -G) "
		fi
        ;;
        *)
            exit 2
        ;;
    esac
fi


