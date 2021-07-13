/etc/udev/rules.d/95-monitor-hotplug.rules

KERNEL=="card0", SUBSYSTEM=="drm", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/jayar/.Xauthority", RUN+="/usr/bin/su jayar -c /home/jayar/.local/bin/Xscreenlock/ScreenLayout.sh"

/etc/udev/rules.d/99-powertargets.rules

SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="0", RUN+="/usr/sbin/systemctl start battery.target"
SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="1", RUN+="/usr/sbin/systemctl start ac.target"
