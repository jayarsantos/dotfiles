echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
cat /etc/dnf/dnf.conf

hostnamectl set-hostname fedoraHP

dnf upgrade --refresh
dnf check
dnf autoremove
fwupdmgr get-devices
fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update

dnf install -y gnome-extensions-app gnome-tweaks
dnf install -y gnome-shell-extension-appindicator

reboot now

