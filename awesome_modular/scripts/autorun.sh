#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
	if (command -v $1 && ! pgrep $1); then
		$@&
	fi
}

run /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1
run /home/jayar/.config/awesome/scripts/screensetup.sh
run /usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd
run xfsettingsd
run xfce4-power-manager
run start-pulseaudio-x11
#run st --title Musicncmpcpp -e ncmpcpp -S visualizer
#run st --title MAIL -e neomutt
#run pidgin
#run redshift-gtk -l 17.157500:121.613500
sleep 2 &
#run steam -silent -login jayarsantosiii Iltd07261981APs/
