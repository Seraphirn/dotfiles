import os
import subprocess

import libqtile.resources
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal, send_notification

MOD = "mod1"
TERMINAL = guess_terminal()
EDITOR = TERMINAL + "-e nvim"
BROWSER = "firefox"
LOCK = "xsecurelock"


@hook.subscribe.startup_once
def autostart():
    send_notification("qtile", "First started")
    home = os.path.expanduser("~/.config/qtile/startup.sh")
    subprocess.call([home])


@hook.subscribe.startup
def run_every_startup():
    send_notification("qtile", "Started")


keys = [
    Key([MOD], "comma", lazy.to_screen(0), desc="Focus to monitor 1"),
    Key([MOD], "period", lazy.to_screen(1), desc="Focus to monitor 2"),
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    Key(
        [MOD, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [MOD, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([MOD, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [MOD, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([MOD, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([MOD, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([MOD, "control"], "l", lazy.layout.grow()),
    Key([MOD, "control"], "j", lazy.layout.grow()),
    Key([MOD, "control"], "h", lazy.layout.shrink()),
    Key([MOD, "control"], "k", lazy.layout.shrink()),
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([MOD, "shift"], "Return", lazy.spawn(TERMINAL), desc="Launch terminal"),
    Key([MOD, "shift"], "f", lazy.spawn(BROWSER), desc="Launch firefox"),
    Key([MOD, "shift"], "e", lazy.spawn(EDITOR), desc="Launch editor"),
    # Toggle between different layouts as defined below
    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD], "t", lazy.to_layout_index(0), desc="Tall"),
    Key([MOD], "u", lazy.to_layout_index(1), desc="Wide"),
    Key([MOD], "m", lazy.to_layout_index(2), desc="max"),
    Key([MOD], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [MOD],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    # Key(
    #     [MOD],
    #     "t",
    #     lazy.window.toggle_floating(),
    #     desc="Toggle floating on the focused window",
    # ),
    Key([MOD, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([MOD], "p", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([MOD, "shift"], "u", lazy.spawn("light -A 10"), desc="Add brightness"),
    Key([MOD, "shift"], "d", lazy.spawn("light -U 10"), desc="Low brightness"),
    Key([MOD, "shift"], "o", lazy.spawn(LOCK), desc="Lock screen"),
    # Key(
    #     [MOD, "shift"],
    #     "h",
    #     lazy.spawn("amixer -D pulse sset Master 5%-"),
    #     desc="Add volume",
    # ),
    # Key(
    #     [MOD, "shift"],
    #     "l",
    #     lazy.spawn("amixer -D pulse sset Master 5%+"),
    #     desc="Low volume",
    # ),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [
    Group("1", label="code", spawn=TERMINAL, screen_affinity=0),
    Group("2", label="term", screen_affinity=0),
    Group("3", label="soc", screen_affinity=0),
    Group("4", label="media", spawn=BROWSER, screen_affinity=1),
    Group("5", label="else", screen_affinity=0),
]


@lazy.function
def go_to_group(qtile, name: str):
    if len(qtile.screens) == 1:
        qtile.groups_map[name].toscreen()
        return

    if name in "1235":
        qtile.focus_screen(0)
        qtile.groups_map[name].toscreen()
    else:
        qtile.focus_screen(1)
        qtile.groups_map[name].toscreen()


for i in groups:
    keys.extend(
        [
            # MOD + group number = switch to group
            Key(
                [MOD],
                i.name,
                # lazy.group[i.name].toscreen(0),
                go_to_group(i.name),
                desc=f"Switch to group {i.name}",
            ),
            # MOD + shift + group number = switch to & move focused window to group
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc=f"Move focused window to group {i.name}",
            ),
        ]
    )

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
    layout.TreeTab(),
    # layout.VerticalTile(),
]

widget_defaults = dict(
    font="sans",
    fontsize=16,
    padding=2,
)
extension_defaults = widget_defaults.copy()

separator = widget.Sep(
    padding=12,
)

main_widgets = [
    separator,
    widget.CurrentLayout(),
    separator,
    widget.GroupBox(
        highlight_method="line",
    ),
    separator,
    widget.Prompt(padding=20),
    widget.WindowName(),
    widget.CPU(format="CPU {load_percent}%"),
    widget.ThermalSensor(),
    separator,
    widget.Memory(
        measure_mem="G",
        format="MEM {MemUsed: .1f}{mm}/{MemTotal: .1f}{mm}",
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(TERMINAL + " -e htop")},
    ),
]

if os.path.isdir("/sys/class/power_supply/BAT0"):
    main_widgets += [
        separator,
        widget.Battery(
            charge_char="🔌",
            discharge_char="🔋",
            error_message="error",
            empty_char="🛑",
            full_char="⚡",
            not_charging_char="",
            # format="{percent:2.0%}{char} ({hour:d}:{min:02d})",
            format="PWR {percent:2.0%}{char}",
            update_interval=10,
            hide_crash=True,
        ),
    ]

main_widgets += [
    separator,
    widget.TextBox(
        # text="",
        text="SND ",
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("pavucontrol")},
        padding=0,
    ),
    widget.Volume(
        padding=0,
    ),
    separator,
    widget.Systray(
        padding=5,
        hide_crash=True,
    ),
    separator,
    widget.KeyboardLayout(
        update_interval=1,
    ),
    separator,
    widget.Clock(format="%A %d %H:%M"),
]

secondary_widgets = main_widgets.copy()
del secondary_widgets[-5:-3]  # del systray

# home_directory = Path.home()
screens = [
    Screen(
        top=bar.Bar(
            [widget.CurrentScreen()] + main_widgets,
            32,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        background="#100000",
        wallpaper="~/wallpaper.jpg",
        wallpaper_mode="fill",
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen(
        top=bar.Bar(
            [widget.CurrentScreen()] + secondary_widgets,
            32,
        ),
        wallpaper="~/wallpaper.jpg",
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [MOD],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([MOD], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
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

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
