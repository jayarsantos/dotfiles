Reference:
https://www.gentoo.org/support/news-items/2020-04-14-elogind-default.html
https://wiki.gentoo.org/wiki/Elogind

startx integration

To have an elogind session created when using startx to start the X server (instead of a display manager), add the following to the user's ~/.xinitrc file:
FILE ~/.xinitrc

exec dbus-launch --exit-with-session <WINDOW_MANAGER>

WINDOW_MANAGER in the above example needs to be replaced by a window manager or a single application.
Hook scripts to be run when suspending/hibernating and/or when resuming/thawing

Any suspend/resume and hibernate/thaw hook scripts need to be in the directory /lib64/elogind/system-sleep/ and use the variables $1 ('pre' or 'post') and $2 ('suspend', 'hibernate', or 'hybrid-sleep'). For example, in the case of elogind a hook script could have the following format:
CODE

#!/bin/bash
case $1/$2 in
  pre/*)
    # Put here any commands you want to be run when suspending or hibernating.
    ;;
  post/*)
    # Put here any commands you want to be run when resuming from suspension or thawing from hibernation.
    ;;
esac

Usage
loginctl

The command loginctl may be used to control and introspect the login manager. For example, to shut down or reboot the system:
user $loginctl poweroff
user $loginctl reboot

For example, to suspend, hibernate or hybrid-suspend the system:
user $loginctl suspend
user $loginctl hibernate
user $loginctl hybrid-sleep
