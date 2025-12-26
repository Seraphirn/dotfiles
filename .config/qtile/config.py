import os
import subprocess

import libqtile.resources
from libqtile import layout, hook
from libqtile.config import Group, Match
from libqtile.utils import send_notification
from const import TERMINAL, BROWSER

from screens import init_screens
from keys import init_keys

tokio_night = dict(
    bg="#1a1b26",
    bg_dark="#16161e",
    bg_dark1="#0C0E14",
    bg_highlight="#292e42",
    blue="#7aa2f7",
    blue0="#3d59a1",
    blue1="#2ac3de",
    blue2="#0db9d7",
    blue5="#89ddff",
    blue6="#b4f9f8",
    blue7="#394b70",
    comment="#565f89",
    cyan="#7dcfff",
    dark3="#545c7e",
    dark5="#737aa2",
    fg="#c0caf5",
    fg_dark="#a9b1d6",
    fg_gutter="#3b4261",
    green="#9ece6a",
    green1="#73daca",
    green2="#41a6b5",
    magenta="#bb9af7",
    magenta2="#ff007c",
    orange="#ff9e64",
    purple="#9d7cd8",
    red="#f7768e",
    red1="#db4b4b",
    teal="#1abc9c",
    terminal_black="#414868",
    yellow="#e0af68",
)
colors = {
    "widgets": [
        # (tokio_night["blue7"], tokio_night["blue6"]),
        (tokio_night["bg"], tokio_night["blue"]),
        # (tokio_night["bg_highlight"], tokio_night["blue5"]),
        (tokio_night["blue7"], tokio_night["blue6"]),
        # (tokio_night["blue"], tokio_night["bg"]),
    ],
    "current": tokio_night["blue6"],
    "other": tokio_night["comment"],
    "active": tokio_night["blue6"],
    "inactive": tokio_night["fg_dark"],
    "focus": tokio_night["blue"],
}


# colors = {
#     "pure_black": "000000",
#     "black": "#264653",
#     "purple": "#9B59B6",
#     "blue": "#3498DB",
#     "green": "#2ECC71",
#     "cyan": "#1ABC9C",
#     "yellow": "#F1C40F",
#     "orange": "#E67E22",
#     "red": "#E74C3C",
#     "white": "#ECF0F1",
#     "grey": "#56c3b7",
# }

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
    Group("0", label="vid", spawn=BROWSER, layout="max", screen_affinity=monitor_count - 1),
]
# if monitor_count > 1:
#     groups += [
#         Group("0", label="etc2", screen_affinity=monitor_count - 1),
#     ]

keys, mouse = init_keys(groups)
screens, widget_defaults = init_screens(monitor_count=monitor_count, colors=colors)

layout_defaults = dict(
    border_focus=colors["focus"],  # Border colour(s) for the focused window.
    border_normal=colors["inactive"],  # Border colour(s) for un-focused windows.
    border_width=3,  # Border width.
    change_ratio=0.02,  # Resize ratio.
    change_size=20,  # Resize change in pixels.
    margin=10,  # Margin of the layout.
    max_ratio=0.95,  # The percent of the screen-space the master pane should occupy at maximum.
    min_ratio=0.1,  # The percent of the screen-space the master pane should occupy at minimum.
    min_secondary_size=50,  # Minimum size in pixel for a secondary pane window.
    new_client_position="after",  # Place new windows: after_current - after the active window. before_current - before the active window, top - at the top of the stack, bottom - at the bottom of the stack.
    ratio=0.65,  # The percent of the screen-space the master pane should occupy by default.
    single_border_width=None,  # Border width for single window.
    single_margin=None,  # Margin size for single window.
)

layouts = [
    layout.MonadTall(
        **layout_defaults
        # border_focus="#295ccc",
    ),
    layout.MonadWide(**layout_defaults),
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
