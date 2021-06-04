#!/usr/bin/env bash

## Shows a drop down menu with power options

case "$(echo -e " Exit sway\n Lock\n Power Off\n Reboot\n Reboot-UEFI\n⏲ Suspend then hibernate\n" | "$HOME"/.local/bin/bemenu-run.sh -l 5 -p "Power:")" in
" Exit sway") swaymsg exit; loginctl terminate-user $USER ;;
" Lock") ~/.local/bin/lock.sh ;;
" Power Off") exec systemctl poweroff -i ;;
" Reboot") exec systemctl reboot ;;
" Reboot-UEFI") exec systemctl reboot --firmware-setup ;;
"⏲ Suspend then hibernate") exec systemctl suspend-then-hibernate ;;
esac
