from libqtile.utils import guess_terminal

MOD = "mod1"
TERMINAL = guess_terminal()
EDITOR = TERMINAL + "-e nvim"
BROWSER = "firefox"
LOCK = "XSECURELOCK_NO_COMPOSITE=1 XSECURELOCK_FORCE_GRAB=2 xsecurelock"
SUSPEND = LOCK + " & systemctl suspend"
LAUNCHER = "ulauncher"
