#!/bin/sh

# layout change
if command -v setxkbmap &> /dev/null; then
    setxkbmap -layout "us,ru" -option "grp:alt_space_toggle"
fi

# if command -v feh &> /dev/null; then
#     feh --bg-scale ~/wallpaper.jpg
# fi

# transparent terminals
if command -v picom &> /dev/null; then
    picom -b
fi

if command -v nm-applet &> /dev/null; then
    nm-applet &>/dev/null &
fi

#red light filter
if command -v redshift &> /dev/null; then
    redshift -l 55.7615902:37.60946 -t 3400:3400 -m randr &>/dev/null &
fi

# screen locker
if command -v xautolock &> /dev/null; then
    if command -v xsecurelock &> /dev/null; then
        xautolock -time 25 -corners 0-0- -locker xsecurelock &>/dev/null &
    fi
    xautolock -time 60 -corners 0-0- -locker "sleep 1 && systemctl suspend" -detectsleep &>/dev/null &
fi

# set minimal light of screen
if command -v light &> /dev/null; then
    light -N 20
fi

# mouse sensetivity
xinput set-prop 10 "libinput Accel Speed" +0.9
# tapping enabled
xinput set-prop 10 "libinput Tapping Enabled" 1
