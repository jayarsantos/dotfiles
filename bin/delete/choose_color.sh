#!/bin/sh
COLORDIR="/home/jayar/.config/sway/colors/"
file="/home/.config/sway/color.sway"
BOLD="\e[1;34m"
COLORED="\e[1;33m"
NORMAL="\e[1;0m"

print_usage() {
	printf "${COLORED}------------------------------------------------${NORMAL}\n"

	printf "${BOLD}	Choose a Color:${NORMAL}\n"
	echo ""
	cd $COLORDIR
	printf "${BOLD}$(for i in $(ls -F); do echo ${i%%/}; done)${NORMAL}\n"
	echo ""
	printf "${COLORED}------------------------------------------------${NORMAL}\n"
}
print_error() {
	echo ""
	echo "Please be sure to type as it is written in the list"
	echo "without the filename "e.g. Naruto, Spiderman ... etc""
	echo "WallpaperChanger is not included in the choices"
	echo ""
	exit 1
}

function set_msg(){
	printf "${COLORED}------------------------------------------------${NORMAL}\n"
	printf "${BOLD}	$1${NORMAL}\n"
	printf "${COLORED}------------------------------------------------${NORMAL}\n"
}

print_usage

cd /home/jayar/.config/sway/
if [[ ! -f $file ]]; then
	rm color.sway
	read -p "Color: " input
	ln -s colors/$input color.sway
	swaymsg reload
else
	echo "file missing"
fi

exit 0
