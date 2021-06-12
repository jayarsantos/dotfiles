#!/usr/bin/env bash

current_volume=$(amixer get Master | awk '/Front Left:/ { match($0, /\[[0-9]+%\]/); value=substr($0, RSTART, RLENGTH); match(value, /[0-9]+/); value=substr(value, RSTART, RLENGTH);  print value }')
target_volume=$(($current_volume + $1))

if [ "$target_volume" -gt 100 ]; then
	target_volume=100
elif [ "$target_volume" -lt 0 ]; then
	target_volume=0
fi

pactl set-sink-volume @DEFAULT_SINK@ $target_volume%
