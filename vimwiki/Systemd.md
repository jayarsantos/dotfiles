~/.config/systemd/user/offlineimap@account.service #note to chech accounts specified in .offlineimap config
[Unit]
Description=Offlineimap Service for account %i
Documentation=man:offlineimap(1)

[Service]
ExecStart=/usr/bin/offlineimap -a %i -u basic
Restart=on-failure
RestartSec=60

[Install]
WantedBy=default.target
