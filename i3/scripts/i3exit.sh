#! /usr/bin/env bash

_lock() {
    icon="$HOME/.config/i3/lock.png"
    tmpbg='/tmp/lock.png'
    (( $# )) && { icon=$1; }
    scrot "$tmpbg"
    convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
    convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
	i3lock -i "$tmpbg"
}

before_lock() {
	#bluetoothctl disconnect
	#playerctl -a pause
	#reset_kbd
	#systemctl --user stop redshift.service
	systemctl --user stop dunst.service
}

after_lock() {
	#sleep 5
	#systemctl --user start redshift.service
	#if [[ $xdg == failed ]] || [[ $xdg == inactive ]]; then
	#	systemctl --user start xdg-desktop-portal-gtk.service
	#fi

	systemctl --user start dunst.service
	#sleep 10
	notify-send "dunst has been loaded."
}

lock() {
	case "$2" in
		-f)
			if hash i3lock-fancy 2>/dev/null; then
				i3lock-fancy -p
			else
				echo "i3lock-fancy is not installed. Please install it with: apt install i3lock-fancy"
				_lock
			fi
			;;
		*)
			_lock
	esac
}

case "$1" in
    lock)
        # lock $1 $2
        # use gnome instead
        before_lock
        dbus-send --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
        after_lock
        ;;
    logout)
        before_lock
        i3-msg exit
        ;;
    suspend)
        before_lock
        lock $1 $2 && systemctl suspend
        after_lock
        ;;
    hibernate)
        lock $1 $2 && systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    poweroff)
        systemctl poweroff
        ;;
    *)
        echo "Usage: i3exit {lock|logout|suspend|hibernate|reboot|poweroff}"
        exit 2
esac

exit 0
