#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
	if (command -v $1 && ! pgrep $1); then
		$@&
	fi
}

#run st --title Musicncmpcpp -e ncmpcpp -S visualizer
#run st --title MAIL -e neomutt
#run redshift-gtk -l 17.157500:121.613500
sleep 2 &
#run steam -silent -login jayarsantosiii Iltd07261981APs/
