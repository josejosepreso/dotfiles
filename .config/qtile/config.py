from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from keys import keys, mod

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
        ]
    )

layouts = [
    layout.Columns(
        # border_focus_stack=["#d75f5f", "#8f3d3d"],
        border_focus= "ffffff",
        border_normal= "1D2330",
        border_width=1,
        margin=3
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="Iosevka",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    disable_drag=True,
                    scroll=False,
                ),
                widget.Sep(padding=10),
                widget.WindowName(
                    disable_drag=True,
                ),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Sep(padding=10),
                widget.Battery(
                    format='{percent:2.0%} {char}',
                    update_delay = 60
                )
            ],
            18,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Sep(padding=10),
                widget.WindowName(),
            ],
            18,
        ),
    )
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

import subprocess

@hook.subscribe.startup_once
def _():
    script = "/home/jose/.config/qtile/autostart.sh"
    subprocess.run([script])

@hook.subscribe.client_new
def _(client):
    if client.name == "LibreWolf" or client.name == "qutebrowser":
        client.togroup("9")
    elif client.name == "mpv":
        client.togroup("8")
