Package management
Sync methods

Sync all repositories that are set to auto-sync including the Gentoo ebuild repository:
root #emaint -a sync

Sync the Gentoo ebuild repository using the mirrors by obtaining a snapshot that is (at most) a day old:
root #emerge-webrsync

Sync custom package repository and the Gentoo ebuild repository using eix:
root #eix-sync

If there are overlays created by app-portage/layman, to sync them:
root #layman -S

app-portage/layman can be installed by issuing:
root #emerge -a app-portage/layman

app-portage/eix can be installed by issuing:
root #emerge -a app-portage/eix

Gather more information on eix by reading its manual:
user $man eix
Package listings

qlist is provided by app-portage/portage-utils

List installed packages with version number and name of used overlay:
root #qlist -IRv

To view the list of packages in the world set along with their available versions it is possible to use app-portage/eix
root #eix --world | less

You can keep color in the output by calling it with the "color" switch:
root #eix --color -c --world | less -R
Package installation

In the following examples the www-client/firefox package will be used, but users can replace it with their package of interest.

List what packages would be installed without installing them:
root #emerge -pv www-client/firefox

Install a specific version of a package (Use '\='(backslash and equal sign) if the current shell attaches special meaning to '=' in a command):
root #emerge =www-client/firefox-24.8.0

Install a package without adding it to the world file:
root #emerge --oneshot www-client/firefox

or
root #emerge -1 www-client/firefox
Package removal
Recommended method

The recommended way to remove a package is by using deselect. This removes it from the @world set (i.e. says the package is no longer wanted). To clean up the system afterwards, run depclean as given below.
root #emerge --deselect www-client/firefox

And then depclean afterwards (the -p should be removed if after running, it shows will not remove any needed packages):
root #emerge --depclean -vp

Separately, to remove a package that no other packages depend on:
root #emerge --ask --verbose --depclean www-client/firefox

As a safety measure, depclean will not remove any packages unless all required dependencies have been resolved. As a consequence of this, it often becomes necessary to run:
root #emerge --update --newuse --deep --quiet @world

Avoid unnecessary rebuilds when USE flags only get added to or dropped from the repository and use the --quiet flag for quicker execution:
root #emerge --update --changed-use --deep --quiet @world
Unclean removal (ignoring dependencies)

Remove a package even if it is needed by other packages:
root #emerge -C www-client/firefox
Warning
Use with caution. The -C option can break software. Best if used to temporarily remove to satisfy a hard block.
Package upgrades

Upgrade all installed packages, dependencies, and deep dependencies that are outdated or have USE flag changes (avoiding unnecessary rebuilds when USE changes have no impact):
root #emerge -uDU --keep-going --with-bdeps=y @world
Package troubleshooting

Check for and rebuild missing libraries (not normally needed):
root #revdep-rebuild -v

equery is part of app-portage/gentoolkit. You can obtain it by issuing this command:
root #emerge -a gentoolkit

Tell which installed package provides a command using equery:
user $equery b `which vim`

Tell which (not) installed package provides a command using e-file:
user $e-file vim

Install e-file with:
root #emerge -a app-portage/pfl

Tell which packages depend on a specific package (cat/pkg in the example) using equery:
user $equery d www-client/firefox

Get information about a package using eix:
root #eix www-client/firefox
Warning
Do not unemerge sys-libs/glibc. It is needed by nearly every other package. If you inadvertedly remove it you may need a rescue stick/disk. You can fetch glibc after setting PORTAGE_BINHOST="http://packages.gentooexperimental.org/packages/amd64-stable/" in /etc/portage/make.conf.
Portage enhancements

Manage configuration changes after an emerge completes:
root #dispatch-conf

Or alternatively:
root #etc-update
After installations or updates

After updating perl-core packages:
root #perl-cleaner --all

or if previous didn't help:
root #perl-cleaner --reallyall -- -av

For haskell packages:
root #haskell-updater
USE flags

Obtain descriptions and usage of the USE flag X using euse:
user $euse -i X

Gather more information on euse by reading its manual page:
user $man euse

Show what packages have the mysql USE flag:
user $equery hasuse mysql

Show what packages are currently built with the mysql USE flag:
user $eix --installed-with-use mysql

Show what USE flags are available for a specific package:
user $equery uses <package-name>

Quickly add a required USE flag for a package install:
root #echo 'dev-util/cmake -qt5' >> /etc/portage/package.use
Important Portage files[i 1]

    /etc/portage/make.conf - Global settings (USE flags, compiler options).
    /etc/portage/package.use - USE flags of individual packages. Can also be a folder containing multiple files.
    /etc/portage/package.accept_keywords - Keyword individual packages; e.g. ~amd64, ~x86, or ∼arm.
    /etc/portage/package.license - Accepted licenses
    /var/lib/portage/world - List of explicitly installed package atoms.
    /var/db/pkg - Contains information for every installed package a set of files about the installation.

Log management
genlop

genlop is a Portage log processor, also estimating build times when emerging packages.

Install genlop by issuing:
root #emerge -a app-portage/genlop

You can gather more information on app-portage/genlop by reading its manual page:
root #man genlop

View the last 10 emerges (installs):
root #genlop -l | tail -n 10

View how long emerging LibreOffice took:
root #genlop -t libreoffice

Estimate how long emerge -uND --with-bdeps=y @world will take:
root #emerge -pU @world | genlop --pretend

Watch the latest merging ebuild during system upgrades:
root #watch genlop -unc
Overlays
eselect repository

app-eselect/eselect-repository can be installed by issuing:
root #emerge -a app-eselect/eselect-repository

List all existing overlays:
user $eselect repository list

List all installed overlays:
user $eselect repository list -i

See also Eselect/Repository
Layman

app-portage/layman can be installed by issuing:
root #emerge -a app-portage/layman

List all existing overlays:
user $layman -L

List all installed overlays:
user $layman -l

See also Layman
Services

Obtain root shell (if the current user is listed in the sudoers list):
user $sudo -i
OpenRC

Start the ssh daemon in the default runlevel at boot:
root #rc-update add sshd default

Start the sshd service now:
root #rc-service sshd start

Check if the sshd service is running:
root #rc-service sshd status
systemd

Start the ssh daemon at boot:
root #systemctl enable sshd

Start the sshd service now:
root #systemctl start sshd

Check if the sshd service is running:
root #systemctl status sshd
Gentoo Monthly Newsletter (GMN)

Search packages in Portage by regular expressions:
root #emerge -s "%^python$"

Overlays vary from very small to very large in size. As a result they slow down the majority of Portage operations. That happens because overlays do not contain metadata caches. The cache is used to speed up searches and the building of dependency trees. A neat trick is to generate local metadata cache after syncing overlays.
root #emerge --regen

This trick also works in conjunction with eix. eix-update can use metadata cache generated by emerge --regen to speed up things. To enable this, add the following variable to /etc/eixrc/00-eixrc:
FILE /etc/eixrc/00-eixrc

OVERLAY_CACHE_METHOD="assign"

qcheck

Use qcheck to verify installed packages:
root #qcheck -e vim-core

qcheck comes with app-portage/portage-utils and can be installed by running this command:
root #emerge -a app-portage/portage-utils

Learn more about qcheck by reading its manual page:
user $man qcheck
