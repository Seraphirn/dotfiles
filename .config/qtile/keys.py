from libqtile.config import Key, Drag, Click
from libqtile.lazy import lazy
from const import MOD, TERMINAL, EDITOR, BROWSER, LOCK, SUSPEND, LAUNCHER

@lazy.function
def go_to_group(qtile, name: str):
    if len(qtile.screens) == 1:
        qtile.groups_map[name].toscreen()
        return

    if name in "1234":
        qtile.focus_screen(0)
        qtile.groups_map[name].toscreen()
    else:
        qtile.focus_screen(1)
        qtile.groups_map[name].toscreen()



def init_keys(groups):
    keys = [
        Key([MOD], "comma", lazy.to_screen(0), desc="Focus to monitor 1"),
        Key([MOD], "period", lazy.to_screen(1), desc="Focus to monitor 2"),

        Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
        Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),

        Key([MOD, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
        Key([MOD, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

        Key([MOD, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        Key([MOD, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([MOD, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([MOD, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

        Key([MOD, "control"], "l", lazy.layout.grow()),
        Key([MOD, "control"], "j", lazy.layout.grow()),
        Key([MOD, "control"], "h", lazy.layout.shrink()),
        Key([MOD, "control"], "k", lazy.layout.shrink()),

        Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

        # Key([MOD], "p", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
        Key([MOD], "p", lazy.spawn(LAUNCHER), desc="Opens app launcher"),
        Key([MOD, "shift"], "Return", lazy.spawn(TERMINAL), desc="Launch terminal"),
        Key([MOD, "shift"], "f", lazy.spawn(BROWSER), desc="Launch firefox"),
        Key([MOD, "shift"], "e", lazy.spawn(EDITOR), desc="Launch editor"),

        Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([MOD], "t", lazy.to_layout_index(0), desc="Tall"),
        Key([MOD], "u", lazy.to_layout_index(1), desc="Wide"),
        Key([MOD], "m", lazy.to_layout_index(2), desc="max"),

        Key([MOD], "w", lazy.window.kill(), desc="Kill focused window"),
        # Key([MOD], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
        # Key([MOD], "t", lazy.window.toggle_floating(), desc="Toggle floating"),

        Key([MOD, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

        Key([MOD, "shift"], "r", lazy.widget["redshift"].click(), desc="toggle redshift"),
        Key([MOD, "shift"], "u", lazy.widget["redshift"].increase_brightness(), desc="+brightness"),
        Key([MOD, "shift"], "d", lazy.widget["redshift"].decrease_brightness(), desc="-brightness"),

        Key([MOD, "shift"], "o", lazy.spawn(LOCK), desc="Lock screen"),
        Key([MOD, "shift"], "Backspace", lazy.spawn(SUSPEND, shell=True), desc="Suspend"),

        Key([MOD, "shift"], "h", lazy.widget["volume"].decrease_vol(), desc="Add volume"),
        Key([MOD, "shift"], "l", lazy.widget["volume"].increase_vol(), desc="Low volume"),
        # Key([MOD, "shift"], "m", lazy.widget["volume"].mute(), desc="Mute"),
        Key([], "XF86AudioLowerVolume", lazy.widget["volume"].decrease_vol(), desc="Add volume"),
        Key([], "XF86AudioRaiseVolume", lazy.widget["volume"].increase_vol(), desc="Low volume"),
        # Key([], "XF86AudioMute", lazy.widget["volume"].mute(), desc="Mute"),
    ]

    for i in groups:
        keys.extend([ 
            Key([MOD], i.name, go_to_group(i.name), desc=f"Switch to group {i.name}",),
            Key([MOD, "shift"], i.name, lazy.window.togroup(i.name), desc=f"Move focused window to group {i.name}",),
        ])

    mouse = [
        Drag([MOD, "shift"], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([MOD, "shift"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        Click([MOD, "shift"], "Button2", lazy.window.bring_to_front()),
    ]

    return keys, mouse
