from libqtile.utils import guess_terminal

MOD = "mod1"
TERMINAL = guess_terminal()
EDITOR = TERMINAL + "-e nvim"
BROWSER = "firefox"
LOCK = "xsecurelock"
SUSPEND = "xsecurelock & systemctl suspend"
LAUNCHER = "ulauncher"
