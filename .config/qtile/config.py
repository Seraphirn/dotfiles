import os
import subprocess

import libqtile.resources
from libqtile import layout, hook
from libqtile.config import Group, Match
from libqtile.utils import send_notification
from const import TERMINAL, BROWSER

from screens import init_screens
from keys import init_keys

try:
    monitor_count = int(  # Count connected monitors
        subprocess.check_output("xrandr | grep ' connected' | wc -l", shell=True)
        .decode("utf-8")
        .strip()
    )
except Exception:
    monitor_count = 1


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/startup.sh")
    subprocess.call([home])


@hook.subscribe.startup
def run_every_startup():
    send_notification("qtile", "Started")


groups = [
    Group("1", label="vim", spawn=TERMINAL, screen_affinity=0),
    Group("2", label="trm", screen_affinity=0),
    Group(
        "3",
        label="soc",
        screen_affinity=0,
        layout="monadwide",
        layout_opts={"ratio": 0.85},
    ),
    Group("4", label="web", screen_affinity=0),
    Group("5", label="etc", screen_affinity=0),
    Group("0", label="vid", spawn=BROWSER, screen_affinity=monitor_count - 1),
]
# if monitor_count > 1:
#     groups += [
#         Group("0", label="etc2", screen_affinity=monitor_count - 1),
#     ]

keys, mouse = init_keys(groups)
screens, widget_defaults = init_screens(monitor_count=monitor_count)

layouts = [
    layout.MonadTall(
        single_border_width=0,
        border_focus="#295ccc",
    ),
    layout.MonadWide(
        single_border_width=0,
        border_focus="#295ccc",
    ),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
]


dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24
wmname = "LG3D"
