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
        self.is_enabled = is_enabled if is_enabled is not None else lambda kwargs: True
        self._separate_direction = separate_direction
        self.colors = colors
        self.prev_background = prev_background

    def render(self, colors: tuple[str, str], **kwargs) -> list[_Widget]:
        if not self.is_enabled(kwargs):
            return []

        background, foreground = self.colors or colors or (None, 'ffffff')

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
                fontsize=30,
                padding=0,
                margin=0,
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

        widget_blocks = [wb for wb in self._widget_blocks if wb.is_enabled(kwargs)]

        colorsl = colors.copy()
        colorsl *= round(len(widget_blocks) / len(colorsl)) + 1  # copy colors on widgets list

        for i, widget_block in enumerate(widget_blocks):
            if widget_block.colors is not None:
                # previous copy make this change to not repeat
                colorsl.insert(i, widget_block.colors)
                render_colors = None
            else:
                render_colors = colorsl[i]
            widget_block.prev_background = colorsl[(i-1) % len(colorsl)][0]
            result += widget_block.render(colors=render_colors, **kwargs)
        return result

def get_icon(suffix: str) -> str:
    return os.path.join(os.path.dirname(__file__), "icons" , suffix)


def init_screens(monitor_count: int, colors: dict) -> tuple[list[Screen], dict[str, Any]]:
    renderer = WidgetRenderer(
        [
            ############################  LEFT  #####################
            WidgetBlock(
                widget.Spacer(length=5),
                lambda: widget.CurrentLayout(
                    mode="icon",
                    scale=0.8,
                    padiing_x=10,
                ),
                separate_direction=None,
            ),
            WidgetBlock(
                lambda: widget.WindowCount(show_zero=True),
                separate_direction="right",
            ),
            WidgetBlock(
                widget.Spacer(length=5),
                lambda: widget.GroupBox(
                    this_current_screen_border=colors['thiscurrent'],
                    other_current_screen_border=colors['noncurrent'],
                    this_screen_border=colors['othercurrent'],
                    other_screen_border=colors['noncurrent'],
                    inactive=colors['inactive'],
                    active=colors['active'],
                    disable_drag=True,
                    use_mouse_wheel=False,
                    margin=2,
                    padding=0,
                    padding_x=6,
                    spacing=2,
                    fontsize=25,
                    borderwidth=3,
                ),
                separate_direction="right",
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
                widget.Net(
                    format='{down:02.0f} {down_suffix}s',
                    use_bits=True,
                    prefix='M',
                ),
                widget.TextBox(
                    text="",
                    fontsize=36,
                ),
                widget.Net(
                    format='{up:02.0f} {up_suffix}s',
                    use_bits=True,
                    prefix='M',
                ),
            ),
            WidgetBlock(
                widget.CPU(format="{load_percent:02.0f}%"),
                widget.TextBox(
                    text="",
                    fontsize=36,
                ),
                widget.ThermalSensor(format='{temp:02.0f}{unit}'),
            ),
            WidgetBlock(
                widget.TextBox(
                    text="",
                    fontsize=36,
                ),
                widget.Memory(
                    measure_mem="G",
                    format="{MemUsed:.1f}{mm}",
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
                # widget.Image(
                #     filename=get_icon('volume-icons/volume_light_bold.png'),
                #     margin=5,
                #     scale=True,
                #     mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("pavucontrol")},
                # ),
                widget.TextBox(
                    text="",
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("pavucontrol")},
                    fontsize=32,
                ),
                widget.Volume(
                    padding=8,
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
                lambda: widget.KeyboardLayout(
                    configured_keyboards=['us', 'ru,us'],  # support xsecurelock layout switch
                    option='grp:alt_space_toggle',
                ),
            ),
            WidgetBlock(
                lambda: widget.Clock(format="%d %a %H:%M"),
                lambda: widget.Spacer(length=5),
            ),
        ]
    )
    widget_defaults = dict(
        font="DroidSansMNerdFontMono",
        center_aligned=True,            # center-aligned group box.
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
