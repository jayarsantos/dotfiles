Check if File does Not Exist

Similar to many other languages, the test expression can be negated using the ! (exclamation mark) logical not operator:

FILE=/etc/docker
if [ ! -f "$FILE" ]; then
    echo "$FILE does not exist."
fi

Copy

Same as above:

[ ! -f /etc/docker ] && echo "$FILE does not exist."

Copy
Check if Multiple Files Exist

Instead of using complicated nested if/else constructs you can use -a (or && with [[) to test if multiple files exist:

if [ -f /etc/resolv.conf -a -f /etc/hosts ]; then
    echo "Both files exist."
fi

Copy

if [[ -f /etc/resolv.conf && -f /etc/hosts ]]; then
    echo "Both files exist."
fi

Copy

Equivalent variants without using the IF statement:

[ -f /etc/resolv.conf -a -f /etc/hosts ] && echo "Both files exist."

Copy

[[ -f /etc/resolv.conf && -f /etc/hosts ]] && echo "Both files exist."

Copy
File test operators

The test command includes the following FILE operators that allow you to test for particular types of files:

    -b FILE - True if the FILE exists and is a special block file.
    -c FILE - True if the FILE exists and is a special character file.
    -d FILE - True if the FILE exists and is a directory.
    -e FILE - True if the FILE exists and is a file, regardless of type (node, directory, socket, etc.).
    -f FILE - True if the FILE exists and is a regular file (not a directory or device).
    -G FILE - True if the FILE exists and has the same group as the user running the command.
    -h FILE - True if the FILE exists and is a symbolic link.
    -g FILE - True if the FILE exists and has set-group-id (sgid) flag set.
    -k FILE - True if the FILE exists and has a sticky bit flag set.
    -L FILE - True if the FILE exists and is a symbolic link.
    -O FILE - True if the FILE exists and is owned by the user running the command.
    -p FILE - True if the FILE exists and is a pipe.
    -r FILE - True if the FILE exists and is readable.
    -S FILE - True if the FILE exists and is a socket.
    -s FILE - True if the FILE exists and has nonzero size.
    -u FILE - True if the FILE exists, and set-user-id (suid) flag is set.
    -w FILE - True if the FILE exists and is writable.
    -x FILE - True if the FILE exists and is executable.

Find and Replace String with sed
The general form of searching and replacing text using sed takes the following form:
sed -i 's/SEARCH_REGEX/REPLACEMENT/g' INPUTFILE
Copy
-i - By default sed writes its output to the standard output. This option tells sed to edit files in place. If an extension is supplied (ex -i.bak) a backup of the original file will be created.
s - The substitute command, probably the most used command in sed.
/ / / - Delimiter character. It can be any character but usually the slash (/) character is used.
SEARCH_REGEX - Normal string or a regular expression to search for.
REPLACEMENT - The replacement string.
g - Global replacement flag. By default, sed reads the file line by line and changes only the first occurrence of the SEARCH_REGEX on a line. When the replacement flag is provided, all occurrences will be replaced.
INPUTFILE - The name of the file on which you want to run the command.
It is a good practice to put quotes around the argument so the shell meta-characters won’t expand.

Let’s see examples of how to use the sed command to search and replace text in files with some of its most commonly used options and flags.
For demonstration purposes, we will be using the following file:

file.txt
123 Foo foo foo
foo /bin/bash Ubuntu foobar 456
Copy
If you omit the g flag only the first instance of the search string in each line will be replaced:

sed -i 's/foo/linux/' file.txt
123 Foo linux foo
linux /bin/bash Ubuntu foobar 456
With the global replacement flag sed replaces all occurrences of the search pattern:

sed -i 's/foo/linux/g' file.txt
123 Foo linux linux
linux /bin/bash Ubuntu linuxbar 456
As you might have noticed, in the previous example the substring foo inside the foobar string is also replaced. If this is not the wanted behavior, use the word-boundery expression (\b) at both ends of the search string. This ensures the partial words are not matched.

sed -i 's/\bfoo\b/linux/g' file.txt
123 Foo linux linux
linux /bin/bash Ubuntu foobar 456
To make the pattern match case insensitive, use the I flag. In the example below we are using both the g and I flags:


sed -i 's/foo/linux/gI' file.txt
123 linux linux linux
linux /bin/bash Ubuntu linuxbar 456
If you want to find and replace a string that contains the delimiter character (/) you’ll need to use the backslash (\) to escape the slash. For example to replace /bin/bash with /usr/bin/zsh you would use

sed -i 's/\/bin\/bash/\/usr\/bin\/zsh/g' file.txt
The easier and much more readable option is to use another delimiter character. Most people use the vertical bar (|) or colon (:) but you can use any other character:

sed -i 's|/bin/bash|/usr/bin/zsh|g' file.txt
123 Foo foo foo
foo /usr/bin/zsh Ubuntu foobar 456
You can also use regular expressions. For example to search all 3 digit numbers and replace them with the string number you would use:

sed -i 's/\b[0-9]\{3\}\b/number/g' file.txt
number Foo foo foo
foo /bin/bash demo foobar number
Another useful feature of sed is that you can use the ampersand character & which corresponds to the matched pattern. The character can be used multiple times.
For example, if you want to add curly braces {} around each 3 digit number, type:

sed -i 's/\b[0-9]\{3\}\b/{&}/g' file.txt
{123} Foo foo foo
foo /bin/bash demo foobar {456}
Last but not least, it is always a good idea to make a backup when editing a file with sed. To do that just provide an extension to the -i option. For example, to edit the file.txt and save the original file as file.txt.bak you would use:

sed -i.bak 's/foo/linux/g' file.txt
If you want to make sure that the backup is created list the files with the ls command:

ls
file.txt file.txt.bak
Recursive Find and Replace
Sometimes you want to recursively search directories for files containing a string and replace the string in all files. This can be done by using commands such as find or grep to recursively find files in the directory and piping the file names to sed.

The following command will recursively search for files in the current working directory and pass the file names to sed.
find . -type f -exec sed -i 's/foo/bar/g' {} +
To avoid issues with files containing space in their names use the -print0 option which tells find to print the file name, followed by a null character and pipe the output to sed using xargs -0:

find . -type f -print0 | xargs -0 sed -i 's/foo/bar/g'
To exclude a directory use the -not -path option. For example, if you are replacing a string in your local git repo to exclude all files starting with dot (.), use:

find . -type f -not -path '*/\.*' -print0 | xargs -0 sed -i 's/foo/bar/g'
If you want to search and replace text only on files with specific extension you would use:

find . -type f -name "*.md" -print0 | xargs -0 sed -i 's/foo/bar/g'
Another option is to use the grep command to recursively find all files containing the search pattern and then pipe the filenames to sed:

grep -rlZ 'foo' . | xargs -0 sed -i.bak 's/foo/bar/g'
Conclusion
Although it may seem complicated and complex, at first, searching and replacing text in files with sed is very simple.
