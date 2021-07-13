# this will discard unused packages weekly
sudo systemctl enable paccache.timer
Created symlink /etc/systemd/system/timers.target.wants/paccache.timer → /usr/lib/systemd/system/paccache.timer.

Querying package databases
Pacman queries the local package database with the -Q flag, the sync database with the -S flag and the files database with the -F flag. See pacman -Q --help, pacman -S --help and pacman -F --help for the respective suboptions of each flag.

Pacman can search for packages in the database, searching both in packages' names and descriptions:

$ pacman -Ss string1 string2 ...
Sometimes, -s's builtin ERE (Extended Regular Expressions) can cause a lot of unwanted results, so it has to be limited to match the package name only; not the description nor any other field:

$ pacman -Ss '^vim-'
To search for already installed packages:

$ pacman -Qs string1 string2 ...
To search for package file names in remote packages:

$ pacman -F string1 string2 ...
To display extensive information about a given package:

$ pacman -Si package_name
For locally installed packages:

$ pacman -Qi package_name
Passing two -i flags will also display the list of backup files and their modification states:

$ pacman -Qii package_name
To retrieve a list of the files installed by a package:

$ pacman -Ql package_name
To retrieve a list of the files installed by a remote package:

$ pacman -Fl package_name
To verify the presence of the files installed by a package:

$ pacman -Qk package_name
Passing the k flag twice will perform a more thorough check.

To query the database to know which package a file in the file system belongs to:

$ pacman -Qo /path/to/file_name
To query the database to know which remote package a file belongs to:

$ pacman -F /path/to/file_name
To list all packages no longer required as dependencies (orphans):

$ pacman -Qdt
