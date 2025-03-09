from libqtile import layout, qtile, hook
from libqtile.config import Click, Drag, Group, Key
from libqtile.lazy import lazy
from keys import keys, mod
from screens import screens

groups = [Group(i) for i in [
    "", "", "󰈙", "4", "5", "6", "", "", ""
]]

for i, group in enumerate(groups):
    n = str(i+1)
    keys.extend(
        [
            Key([mod], n, lazy.group[group.name].toscreen()),
            Key([mod, "shift"], n, lazy.window.togroup(group.name))
        ]
    )

layouts = [
    layout.Columns(
        border_focus= "ffffff",
        border_normal= "1D2330",
        border_width=1,
        margin=3
    )
]

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
        client.togroup("")
    elif client.name == "mpv":
        client.togroup("")
