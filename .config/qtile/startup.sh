#!/bin/sh

# if command -v feh &> /dev/null; then
#     feh --bg-scale ~/wallpaper.jpg
# fi

#red light filter
# if command -v redshift &> /dev/null; then
#     redshift -l 55.7615902:37.60946 -t 3400:3400 -m randr -r &>/dev/null &
# fi
#
# layout change
# if command -v setxkbmap &> /dev/null; then
#     setxkbmap -layout "us,ru" -option "grp:alt_space_toggle"
# fi

# set 144 frame rate on home monitor
if command -v xrandr &> /dev/null; then
    xrandr --output HDMI-A-0 --mode 1920x1080 --rate 144
fi

if command -v blueman-applet &> /dev/null; then
    blueman-applet &>/dev/null &
fi

# transparent terminals
if command -v picom &> /dev/null; then
    picom -b
fi

# applet for wifi
if command -v nm-applet &> /dev/null; then
    nm-applet &>/dev/null &
fi

# screen locker
if command -v xautolock &> /dev/null; then
    if command -v xsecurelock &> /dev/null; then
        xautolock -corners 0-0- \
            -time 25 -locker 'XSECURELOCK_NO_COMPOSITE=1 XSECURELOCK_FORCE_GRAB=2 xsecurelock' \
            -notify 30 -notifier "notify-send -u critical -t 10000 'Screen locking in 30 seconds!'" \
            &>/dev/null &
    fi
    if command -v xss-lock &> /dev/null; then
        xset s 2400
        xss-lock --ignore-sleep -- systemctl suspend &>/dev/null &
    fi
fi

# Turn off standard x11 screensaver (10min) and set autooff monitor on 25 min
if command -v xset &> /dev/null; then
    xset dpms 15010 15010 15010
fi

# set minimal light of screen
if command -v light &> /dev/null; then
    light -N 20
fi

# mouse sensetivity
xinput set-prop 11 "libinput Accel Speed" +0.85
# tapping enabled
xinput set-prop 11 "libinput Tapping Enabled" 1
