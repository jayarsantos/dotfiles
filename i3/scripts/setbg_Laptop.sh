#! /usr/bin/bash
xrandr --auto --output LVDS-1 --mode 1366x768 --right-of VGA-1
xrandr --auto --output VGA-1 --mode 1600x900 --left-of LVDS-1 --primary
feh --bg-scale ~/.config/Wallpapers/2012_yamaha_yzf_r1-1600x900.jpg
