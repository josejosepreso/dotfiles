from libqtile import widget, bar
from libqtile.config import Screen
import subprocess

BAR_HEIGHT = 18

DEF_WIDGETS = [
    widget.GroupBox(
        disable_drag=True,
        scroll=False,
        use_mouse_wheel=False,
        highlight_method="line",
        toggle=True
    ),
    widget.Sep(padding=10),
    widget.WindowName(
        foreground="#8c8c8c",
        max_chars=60
    )
]

widget_defaults = dict(
    font="Fira Code Bold",
    fontsize=11,
    padding=3,
)

screens = [
    Screen(
        top=bar.Bar(
            DEF_WIDGETS +
            [
                widget.CPU(format="   CPU {freq_current}GHz {load_percent}%", update_interval=10, foreground="#c19898"),
                widget.Sep(padding=10),
                widget.Memory(format="   {MemUsed:.0f}{mm}/{MemTotal: .0f}{mm}", update_interval=10, foreground="#c19898"),
                widget.Sep(padding=10),
                widget.Clock(format="   %Y-%m-%d %a %I:%M %p", foreground="#c19898"),
                widget.Sep(padding=10),
                widget.Battery(format='{percent:2.0%} {char}', update_delay = 60, foreground="#c19898")
            ],
            BAR_HEIGHT,
        ),
    )
]

hdmi = subprocess.run(
    "xrandr -q | awk '/^HDMI2/ {print $2}'"
    , shell=True
    , stdout=subprocess.PIPE
).stdout.decode("utf-8").strip() == "connected"

if hdmi:
    screens.append(
        Screen(
            top=bar.Bar(
                DEF_WIDGETS,
                BAR_HEIGHT,
            ),
        )
    )
