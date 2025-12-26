import os

from libqtile import bar, qtile, widget
from libqtile.config import Screen
from libqtile.widget.base import _Widget

from const import TERMINAL, LAUNCHER
from typing import Callable, Any


class WidgetBlock:
    """Block of widgets separated from other blocks and is having a condition to render"""

    def __init__(
        self,
        *widgets: list[_Widget | Callable[[], _Widget]],
        is_enabled: Callable[[dict[str, Any]], bool] | None = None,
        is_separated: bool = True,
    ):
        self._widgets = widgets
        self._is_enabled = is_enabled
        if is_separated:
            self._widgets = (widget.Sep(padding=12),) + self._widgets

    def render(self, **kwargs) -> list[_Widget]:
        if self._is_enabled is not None and not self._is_enabled(kwargs):
            return []

        return [
            widget_() if callable(widget_) else widget_ for widget_ in self._widgets
        ]


class WidgetRenderer:
    def __init__(self, widget_blocks: list[WidgetBlock]):
        self._widget_blocks = widget_blocks

    def render(self, **kwargs) -> list[_Widget]:
        result = []
        for widgets_block in self._widget_blocks:
            result += widgets_block.render(**kwargs)
        return result


def init_screens(monitor_count: int) -> tuple[list[Screen], dict[str, Any]]:
    renderer = WidgetRenderer(
        [
            ############################  LEFT  #####################
            WidgetBlock(
                lambda: widget.CurrentLayout(
                    mode="icon",
                ),
                is_separated=False,
            ),
            WidgetBlock(
                lambda: widget.GroupBox(
                    this_current_screen_border="#295CCC",
                    this_screen_border="#C63966",
                    inactive="#808080",
                    highlight_method="block",
                    disable_drag=True,
                    use_mouse_wheel=False,
                ),
            ),
            WidgetBlock(
                lambda: widget.Prompt(padding=20),
                lambda: widget.WindowName(
                    max_chars=50,
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(LAUNCHER)},
                ),
            ),
            ############################  RIGHT  #####################
            WidgetBlock(
                widget.CPU(format="CPU {load_percent}%"),
                widget.ThermalSensor(),
                is_separated=False,
            ),
            WidgetBlock(
                widget.Memory(
                    measure_mem="G",
                    format="MEM {MemUsed:.1f}/{MemTotal:.1f}{mm}",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(TERMINAL + " -e htop")
                    },
                ),
            ),
            WidgetBlock(
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
                is_enabled=lambda kw: os.path.isdir("/sys/class/power_supply/BAT0"),
            ),
            WidgetBlock(
                widget.TextBox(
                    # text="",
                    text="SND ",
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("pavucontrol")},
                    padding=0,
                ),
                widget.Volume(
                    padding=0,
                ),
            ),
            WidgetBlock(
                widget.Systray(
                    padding=5,
                    hide_crash=True,
                ),
                is_enabled=lambda kw: (
                    kw["screen_num"] == kw["monitor_count"]
                ),  # only on last
            ),
            WidgetBlock(
                widget.Redshift(
                    temperature=3400,
                ),
            ),
            WidgetBlock(
                widget.KeyboardLayout(
                    configured_keyboards=['us', 'ru,us'],  # support xsecurelock layout switch
                    option='grp:alt_space_toggle',
                ),
            ),
            WidgetBlock(
                widget.Clock(format="%d %a %H:%M"),
            ),
        ]
    )

    screens = [
        Screen(
            top=bar.Bar(
                widgets=renderer.render(screen_num=i, monitor_count=monitor_count),
                size=32,
            ),
            wallpaper="~/wallpaper.jpg",
            wallpaper_mode="fill",
            # x11_drag_polling_rate = 60,
        )
        for i in range(1, monitor_count + 1)
    ]

    widget_defaults = dict(
        font="DejaVuSansMono",
        fontsize=16,
        padding=2,
    )
    return screens, widget_defaults
