Syntax of bash case statement.

-- -- -- -- -- -- -- --
case expression in
    pattern1 )
        statements ;;
    pattern2 )
        statements ;;
    ...
esac
-- -- --- --- --- -- --

1.) Sending signal to a process

$ cat signal.sh

#!/bin/bash

if [ $# -lt 2 ]
then
        echo "Usage : $0 Signalnumber PID"
        exit
fi

case "$1" in

1)  echo "Sending SIGHUP signal"
    kill -SIGHUP $2
    ;;
2)  echo  "Sending SIGINT signal"
    kill -SIGINT $2
    ;;
3)  echo  "Sending SIGQUIT signal"
    kill -SIGQUIT $2
    ;;
9) echo  "Sending SIGKILL signal"
   kill -SIGKILL $2
   ;;
*) echo "Signal number $1 is not processed"
   ;;
esac

In the above example:

$1 and $2 are the signal number and process id respectively.
Using kill command, it sends the corresponding signal to the given process id.
It executes the sleep command for a number of seconds.
The optional last comparison *) is a default case and that matches anything.
Usage of the above shell script: Find out the process id of the sleep command and send kill signal to that process id to kill the process.

$ sleep 1000

$ ps -a | grep sleep
23277 pts/2    00:00:00 sleep

$ ./signal.sh 9 23277
Sending SIGKILL signal

$ sleep 1000
Killed
-- -- -- -- -- -- -- -- -- -- -- -- --
2.) Pattern Match in a File

This example prints the number of lines,number of words and delete the lines that matches the given pattern.

$ cat fileop.sh

#!/bin/bash

# Check 3 arguments are given #
if [ $# -lt 3 ]
then
        echo "Usage : $0 option pattern filename"
        exit
fi

# Check the given file is exist #
if [ ! -f $3 ]
then
        echo "Filename given \"$3\" doesn't exist"
        exit
fi

case "$1" in

# Count number of lines matches
-i) echo "Number of lines matches with the pattern $2 :"
    grep -c -i $2 $3
    ;;
# Count number of words matches
-c) echo "Number of words matches with the pattern $2 :"
    grep -o -i $2 $3 | wc -l
    ;;
# print all the matched lines
-p) echo "Lines matches with the pattern $2 :"
    grep -i $2 $3
    ;;
# Delete all the lines matches with the pattern
-d) echo "After deleting the lines matches with the pattern $2 :"
    sed -n "/$2/!p" $3
    ;;
*) echo "Invalid option"
   ;;
esac
Execution of the above script is shown below.

$ cat text
Vim is a text editor released by Bram Moolenaar in 1991 for the Amiga computer.
The name "Vim" is an acronym for "Vi IMproved" because Vim was created as an extended version of the vi editor, with many additional features designed to be helpful in editing program source code.
Although Vim was originally released for the Amiga, Vim has since been developed to be cross-platform, supporting many other platforms.
It is the most popular editor amongst Linux Journal readers.
Bash case regex output. After deleting the lines matches with the pattern Vim:

$ ./fileop.sh  -d Vim text
It is the most popular editor amongst Linux Journal readers.
Also, refer to our earlier article on Bash ~ [expansion](https://www.thegeekstuff.com/2010/06/bash-tilde-expansion/) and { } [expansion](https://www.thegeekstuff.com/2010/06/bash-shell-brace-expansion/).
-- -- -- -- -- -- -- -- -- -- -- -- --
3.) Find File type from the Extension
This example prints type of a file (text, Csource, etc) based on the extension of the filename.

$ cat filetype.sh

#!/bin/bash
for filename in $(ls)
do
	# Take extension available in a filename
        ext=${filename##*\.}
        case "$ext" in
        c) echo "$filename : C source file"
           ;;
        o) echo "$filename : Object file"
           ;;
        sh) echo "$filename : Shell script"
            ;;
        txt) echo "$filename : Text file"
             ;;
        *) echo " $filename : Not processed"
           ;;
esac
done

$ ./filetype.sh
a.c : C source file
b.c : C source file
c1.txt : Text file
fileop.sh : Shell script
obj.o : Object file
text : Not processed
t.o : Object file
-- -- -- -- -- -- -- -- -- -- -- -- --
4.) Prompt User with Yes or No
In most of the software installation, during license agreement, it will ask yes or no input from user. The following code snippet is one of the way to get the yes or no input from user.

$ cat yorno.sh
#!/bin/bash

echo -n "Do you agree with this? [yes or no]: "
read yno
case $yno in

        [yY] | [yY][Ee][Ss] )
                echo "Agreed"
                ;;

        [nN] | [n|N][O|o] )
                echo "Not agreed, you can't proceed the installation";
                exit 1
                ;;
        *) echo "Invalid input"
            ;;
esac

$ ./yorno.sh
Do you agree with this? [yes or no]: YES
Agreed
If there are several patterns separated by pipe characters, the expression can match any of them in order for the associated statements to be run. The patterns are checked in order until a match is found; if none is found, nothing happens.

Also, refer to our earlier [15 bash array examples](https://www.thegeekstuff.com/2010/06/bash-array-tutorial/) article.
-- -- -- -- -- -- -- -- -- -- -- -- --
5.) Startup script
Startup scripts in the /etc/init.d directory uses the case statement to start and stop the application.

You can use any kind of patterns, but its always recommended to use case statement, when you’re testing on values of primitives. (ie. integers or characters).

$ cat startpcapp

#!/bin/bash

case "$1" in
'start')
echo "Starting application"
/usr/bin/startpc
;;
'stop')
echo "Stopping application"
/usr/bin/stoppc
;;
'restart')
echo "Usage: $0 [start|stop]"
;;
esac

$ ./startpcapp start
Starting application
/usr/bin/startpc started

