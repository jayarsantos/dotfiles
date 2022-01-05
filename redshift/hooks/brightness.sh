#!/bin/sh

# Set brightness via xbrightness when redshift status changes

# Set brightness values for each status.
# Range from 1 to 100 is valid
brightness_day=100
brightness_transition=50
brightness_night=50
# Set fade time for changes to one minute
fade_time=60000

if [ "$1" = period-changed ]; then
	case $3 in
		night)
			ddcutil setvcp 10 $brightness_night
			;;
		daytime)
			ddcutil setvcp $brightness_day
			;;
	esac
fi
