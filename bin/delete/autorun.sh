#!/usr/bin/env bash

function run {
	if (command -v $1 && ! pgrep $1); then
		$@&
	fi
}

xdg=$(systemctl --user status xdg-desktop-portal-gtk.service | grep failed)

if [[ $xdg == *failed* ]]; then
	systemctl --user start xdg-desktop-portal-gtk.service
fi

exit 0
