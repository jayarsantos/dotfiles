Inspiration in this [LINK](https://frdmtoplay.com/i3-udev-xrandr-hotplugging-output-switching/)

#!/bin/sh

# Get out of town if something errors
# set -e

# Get info on the monitors
LVDS_STATUS=$(</sys/class/drm/card0/card0-LVDS-1/status )
HDMI_STATUS=$(</sys/class/drm/card0/card0-HDMI-A-1/status )
VGA_STATUS=$(</sys/class/drm/card0/card0-VGA-1/status )

LVDS_ENABLED=$(</sys/class/drm/card0/card0-LVDS-1/enabled)
HDMI_ENABLED=$(</sys/class/drm/card0/card0-HDMI-A-1/enabled)
VGA_ENABLED=$(</sys/class/drm/card0/card0-VGA-1/enabled)

# Check to see if our state log exists
if [ ! -f /tmp/monitor ]; then
	touch /tmp/monitor
	STATE=5
else
	STATE=$(</tmp/monitor)
fi

# The state log has the NEXT state to go to in it

# If monitors are disconnected, stay in state 1
if [ "disconnected" == "$HDMI_STATUS" -a "disconnected" == "$VGA_STATUS" ]; then
	STATE=1
fi

case $STATE in
	1)
	# LVDS is on, projectors not connected
	/usr/bin/xrandr --output LVDS-1 --auto
	STATE=2
	;;
	2)
	# LVDS is on, projectors are connected but inactive
	/usr/bin/xrandr --output LVDS-1 --auto --output HDMI-1 --off --output VGA-1 --off
	STATE=3
	;;
	3)
	# LVDS is off, projectors are on
	if [ "connected" == "$HDMI_STATUS" ]; then
		/usr/bin/xrandr --output LVDS-1 --off --output HDMI-1 --auto
		TYPE="HDMI"
	elif [ "connected" == "$VGA_STATUS" ]; then
		/usr/bin/xrandr --output VGA-1 --off --output VGA-1 --auto
		TYPE="VGA"
	fi
	/usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE"
	STATE=4
	;;
	4)
	# LVDS is on, projectors are mirroring
	if [ "connected" == "$HDMI_STATUS" ]; then
		/usr/bin/xrandr --output LVDS-1 --auto --output HDMI-1 --auto
		TYPE="HDMI"
	elif [ "connected" == "$VGA_STATUS" ]; then
		/usr/bin/xrandr --output VGA-1 --auto --output VGA-1 --auto
		TYPE="VGA"
	fi
	/usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE mirroring"
	STATE=5
	;;
	5)
	# LVDS is on, projectors are extending
	if [ "connected" == "$HDMI_STATUS" ]; then
		/usr/bin/xrandr --output LVDS-1 --auto --output HDMI-1 --auto --left-of LVDS-1
		TYPE="HDMI"
	elif [ "connected" == "$VGA_STATUS" ]; then
		/usr/bin/xrandr --output VGA-1 --auto --output VGA-1 --auto --left-of LVDS-1
		TYPE="VGA"
	fi
	/usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE extending"
	STATE=2
	;;
	*)
	# Unknown state, assume we're in 1
	STATE=1
esac

echo $STATE > /tmp/monitor
