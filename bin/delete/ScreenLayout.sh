#!/bin/bash

VGA=$(swaymsg -t get_outputs | grep 'VGA-1')
HDMI=$(swaymsg -t get_outputs | grep 'HDMI-1')

if [[ $VGA == *VGA-1* ]]; then
	swayoutputctl.py activate dualsamsung
	swaymsg focus output $VGA
	exit 0
elif [[ $HDMI == *HDMI-1* ]]; then
	swayoutputctl.py activate dualHDMI
	swaymsg focus output $HDMI
	exit 0
else
	swayoutputctl.py activate single
	exit 0
fi
