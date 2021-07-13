dex is a very handy utility for working with .desktop files. Used with the path to a .desktop file, it will start the application. Used with the -a option, it will start applications with .desktop files in the 'autostart' directories, and it is smart enough to decide which of them to start depending on the desktop environment or window manager used.

Since few applications know about i3 (yet ;-) ), some tweaking of .desktop files may be needed.

First, test what applications would be started without any tweaks by running:

$ dex -vad
This will show what dex would do with each .desktop file in the autostart directories /etc/xdg/autostart and ${HOME}/.config/autostart, showing for each of them if it would be ignored, and if not, what command would be executed for starting the application. Some applications may not be appropriate or useful in i3, others would be useful in i3, but would not be started because they specify a specific desktop environment to start in. All this can be fixed by doing some tweaking, see below.

For each application whose startup you wish to modify, edit the application's .desktop file in /etc/xdg/autostart/<application>.desktop (or copy it to ${HOME}/.config/autostart/<application>.desktop first).

(1) To not start an application if i3 is running, add the following line:

NotShowIn=i3;
(2) To start an application only if i3 is running, remove any NotShowIn= line, then add:

OnlyShowIn=i3;
(3) To tweak an application's startup command only if i3 is running, first do step (1), then make a fresh copy of the original .desktop file, naming it something like <application>-i3.desktop, do step (2) on this file, then finally change the line:

Exec=<command>
to your liking. To test the change, use:

$ dex </path/to/application.desktop>
Now, to verify that all your changes are correct, tell dex to simulate autostart using the i3 window manager:

$ dex -vade -i3
and fix any problems. Finally, edit ${HOME}/.i3/config, remove any now redundant exec <command> lines, and add the line:

exec dex -ae i3
at the very end, then log out and back in.
