#!/bin/sh

# systray battery icon
cbatticon -u 5 &
# systray volume
volumeicon &

nitrogen --restore &
#conky -c $HOME/.config/conky/doomone-qtile.conkyrc

# Graphical authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Desktop notifications
# mako
dunst &

# Network Applet
nm-applet --indicator &

# Turn on Numlock by default
if ! command -v numlockx &> /dev/null
then
    yes | sudo pacman -S numlockx &
    numlockx &
else
    numlockx &
fi

# Welcome App
dex -a -s /etc/xdg/autostart/:~/.config/autostart/  
# picom &
