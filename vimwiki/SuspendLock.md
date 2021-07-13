/etc/systemd/system/suspend@.service
Enable with ff command: sudo systemctl enable suspend@username (in my case "takure" is the username

[Unit]
Description=User suspend actions
Before=sleep.target

[Service]
User=%I
Type=forking
Environment=DISPLAY=:0
ExecStartPre= -/usr/bin/pkill -u %u unison ; /usr/local/bin/pause-on-lock
ExecStart=/usr/local/bin/mantablockscreen -sc
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target

