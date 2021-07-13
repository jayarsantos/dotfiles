#!/bin/sh
#VGA=$(cat /sys/class/drm/card0-VGA-1/status)

VGA=$(xrandr --query | grep 'VGA1' | awk '{print $2}')
HDMI=$(xrandr --query | grep 'HDMI1' | awk '{print $2}')

GetExtern() {
if [[ $VGA = connected ]]; then
	echo "VGA1"
elif [[ $HDMI == connected ]]; then
	echo "HDMI1"
else
	echo "none"
fi
}

setup=dual
LAPTOP=LVDS1
EXTERNAL=$(GetExtern)

#default display
MONITOR=LVDS1

# functions to switch from LVDS1 to VGA and vice versa

ActivateLock() {
	#echo "Switching to VGA1"
	xrandr --output $EXTERNAL --auto --primary --output $LAPTOP --off
	MONITOR=$EXTERNAL
	exit 0
}
ActivateExternal() {
	#echo "Switching to VGA1"
	xrandr --output $EXTERNAL --auto --primary --output $LAPTOP --off
	MONITOR=$EXTERNAL
	sleep 1
	echo 'awesome.restart()' | awesome-client
	exit 0
}
DeactivateExternal() {
	#echo "Switching to LVDS1"
	xrandr --output $EXTERNAL --off --output $LAPTOP --auto --primary
	MONITOR=$LAPTOP
	sleep 1
	echo 'awesome.restart()' | awesome-client
	exit 0
}
ActivateDual() {
	xrandr --output $EXTERNAL --auto --primary --scale 1.0x1.0 --output $LAPTOP --right-of $EXTERNAL --auto --scale 1.0x1.0
	MONITOR=$EXTERNAL
	sleep 1
	echo 'awesome.restart()' | awesome-client
	exit 0
}
ActivateSettings() {
	if [[ $setup == "dual" ]]; then
		ActivateDual
	else
		ActivateExternal
	fi
}

# functions to check if VGA is connected and in use
VGAActive() {
	[ $MONITOR = "$EXTERNAL" ]
}
VGAConnected() {
	! xrandr | grep "^$EXTERNAL" | grep disconnected >/dev/null
}

Mysettings=$(ActivateSettings)

case "$1" in
	lock)
		ActivateLock
		;;
	loadsettings)
		ActivateSettings
		;;
	dualscreen)
		ActivateDual
		;;
	external)
		ActivateExternal
		;;
	internal)
		DeactivateExternal
		;;
	*)
		echo "Usage: $0 {lock|loadsettings|dualscreen|external|internal}"
		exit 2
esac
