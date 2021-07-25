#!/bin/sh
FILE=~/.config/awesome/main/archmenu.lua
if [ -f "$FILE" ]; then
	rm $FILE
	xdg_menu --format awesome --root-menu /etc/xdg/menus/xfce-applications.menu > $FILE
else
	xdg_menu --format awesome --root-menu /etc/xdg/menus/xfce-applications.menu > $FILE
fi
