The following commands install Samba and set it to run via systemctl. This also sets the firewall to allow access to Samba from other computers.

sudo dnf install samba
sudo systemctl enable smb --now
firewall-cmd --get-active-zones
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=samba
sudo firewall-cmd --reload

* List details for Windows Shared Folder
    smbclient -L //ip.of.windowsOS

* connect to Windows Shared Folder
    smb://ip.of.windows
        - Type the username and password of windows user that made the shares
