from libqtile.utils import guess_terminal

MOD = "mod1"
TERMINAL = guess_terminal()
EDITOR = TERMINAL + "-e nvim"
BROWSER = "firefox"
LOCK = "xsecurelock"
# LOCK = "XSECURELOCK_NO_COMPOSITED=1 xsecurelock"
SUSPEND = "systemctl suspend && " + LOCK
LAUNCHER = "ulauncher"
SCREENSHOT = "flameshot gui -c"
