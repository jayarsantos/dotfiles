#!/usr/bin/env bash 

#nitrogen --restore &
#conky -c $HOME/.config/conky/doomone-qtile.conkyrc

# Auth with polkit-gnome:
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Desktop notifications
# mako
dunst &

# Network Applet
nm-applet --indicator &

# Turn on Numlock by default
if ! command -v numlockx &> /dev/null
then
    yes | sudo pacman -S numlockx
else
    echo "it is found"
    numlockx &
fi

# Welcome App
dex -a -s /etc/xdg/autostart/:~/.config/autostart/  
# picom &
