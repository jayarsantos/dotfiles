1.) [Toggle Screen](https://unix.stackexchange.com/questions/315726/how-to-create-xrandr-output-toggle-script)

xrandr --listactivemonitors | grep <BBB> >/dev/null && xrandr --output <BBB> --off || xrandr --output <BBB> --right-of <AAA> --mode 1920x1080

Explanation:

xrandr --listactivemonitors prints only the monitors that are currently on.
grep <BBB> >/dev/null Searches the previous output for the name of the monitor we want to toggle. If it is found, grep will return an exit code that the shell interprets as true. If it is not found, it will return an exit code that the shell interprets as false. The output is sent to /dev/null to avoid cluttering the screen.
&& xrandr --output <BBB> --off If grep found the monitor in the list of active monitors, then this will run, turning the monitor off. But if grep exited with a falsey exit code, then this will not run because no matter what it evaluates to, the logical and clause as a whole is already known to be false.
|| xrandr --output <BBB> --right-of <AAA> --mode 1920x1080 If grep did not find it, then this clause will run, turning the monitor on. It runs because the previous clause (grep ... && xrandr ...) evaluated to false. In order to know if this logical or clause is true, the shell must evaluate the right hand side. On the other hand, if the left-handside has already evaluated to true, then there is no need to evaluate the right-hand side and so this will not be executed.

One limitation of this answer is that both outputs need to be connected. Thus, in case of external screen is ON and then disconnecting it, you cannot change it back. My solution is to prepend an additional check, if the external screen is connected at all: xrandr | grep 'VGA1 disconnected' > /dev/null && xrandr --output LVDS1 --auto || xrandr --listactivemonitors | grep VGA1 > /dev/null && xrandr --output VGA1 --off --output LVDS1 --auto || xrandr --output VGA1 --auto --output LVDS1 --off NOTE: VGA1 is my external outlet

2.) [My Script](MyScript) - A collection of working scripts for a laptop with VGA and HDMI connectors
