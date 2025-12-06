#!/bin/sh
#red light filter
redshift -l 55.7615902:37.60946 -t 3400:3400 -m randr &>/dev/null &

sudo nm-applet &>/dev/null &

# screen locker
xautolock -time 25 -corners 0-+- -locker xsecurelock &>/dev/null &
xautolock -time 60 -corners 0-+- -locker "sleep 1 && systemctl suspend" -detectsleep &>/dev/null &

# set minimal light of screen
light -N 20

# mouse sensetivity
xinput set-prop 10 "libinput Accel Speed" +0.9
# tapping enabled
xinput set-prop 10 "libinput Tapping Enabled" 1

# layout change
setxkbmap -layout "us,ru" -option "grp:alt_space_toggle"

#exec $BROWSER &>/dev/null &
#exec $TERMINAL -e $EDITOR &>/dev/null &
#exec $TERMINAL &>/dev/null &
