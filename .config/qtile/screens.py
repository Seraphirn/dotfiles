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
        separate_direction: str | None = "left",
        colors: tuple[str, str] | None = None,
        prev_background: str | None = None
    ):
        self._widgets = widgets
        self._is_enabled = is_enabled
        self._separate_direction = separate_direction
        self.colors = colors
        self.prev_background = prev_background

    def render(self, **kwargs) -> list[_Widget]:
        if self._is_enabled is not None and not self._is_enabled(kwargs):
            return []

        background, foreground = self.colors or (None, 'ffffff')

        widgets = [
            widget_() if callable(widget_) else widget_ for widget_ in self._widgets
        ]
        for widget_ in widgets:
            widget_.foreground = foreground
            widget_.background = background

        if self._separate_direction is not None:
            separator = widget.TextBox(
                text="" if self._separate_direction == 'left' else "",
                font="DroidSansMNerdFontMono",
                fontsize=28,
                padding=0,
                background=background if self._separate_direction == 'right' else self.prev_background,
                foreground=self.prev_background if self._separate_direction == 'right' else background,
            )
            widgets = [separator,] + widgets

        return widgets


class WidgetRenderer:
    def __init__(self, widget_blocks: list[WidgetBlock]):
        self._widget_blocks = widget_blocks

    def render(self, colors: list[tuple[str]], **kwargs) -> list[_Widget]:
        result = []

        colors *= round(len(self._widget_blocks) / len(colors)) + 1  # copy colors on widgets list

        for i, widget_block in enumerate(self._widget_blocks):
            if widget_block.colors is not None:
                # previous copy make this change to not repeat
                colors.insert(i, widget_block.colors)
            else:
                widget_block.colors = colors[i]
            widget_block.prev_background = colors[(i-1) % len(colors)][0]
            result += widget_block.render(**kwargs)
        return result


def init_screens(monitor_count: int, colors: dict) -> tuple[list[Screen], dict[str, Any]]:
    renderer = WidgetRenderer(
        [
            ############################  LEFT  #####################
            WidgetBlock(
                lambda: widget.CurrentLayout(
                    mode="icon",
                    scale=0.7,
                    padding=10,
                ),
                separate_direction=None,
            ),
            WidgetBlock(
                lambda: widget.GroupBox(
                    this_current_screen_border=colors['current'],
                    this_screen_border=colors['other'],
                    inactive=colors['inactive'],
                    active=colors['active'],
                    disable_drag=True,
                    use_mouse_wheel=False,
                    padding=6,
                ),
            ),
            WidgetBlock(
                lambda: widget.Prompt(padding=20),
                lambda: widget.WindowName(
                    max_chars=50,
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(LAUNCHER)},
                ),
                separate_direction="right",
            ),
            ############################  RIGHT  #####################
            WidgetBlock(
                widget.CPU(format="CPU {load_percent:.0f}%"),
                widget.ThermalSensor(format='{temp:.0f}{unit}'),
            ),
            WidgetBlock(
                widget.Memory(
                    measure_mem="G",
                    format="MEM {MemUsed:.1f}{mm}",
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
                widget.Redshift(
                    temperature=3400,
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
    widget_defaults = dict(
        font="DroidSansMNerdFontMono",
        fontsize=16,
        padding=5,
    )

    screens = [
        Screen(
            top=bar.Bar(
                widgets=renderer.render(
                    screen_num=i,
                    monitor_count=monitor_count,
                    colors=colors['widgets'],
                ),
                size=32,
            ),
            wallpaper="~/wallpaper.jpg",
            wallpaper_mode="fill",
            # x11_drag_polling_rate = 60,
        )
        for i in range(1, monitor_count + 1)
    ]

    return screens, widget_defaults
