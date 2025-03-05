from libqtile.config import Key
from libqtile.lazy import lazy

mod = "mod4"
terminal = "urxvt"

keys = [
    Key([mod], "k", lazy.layout.right()),
    Key([mod], "j", lazy.layout.left()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod], "h", lazy.layout.grow_left()),
    Key([mod], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),

    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "p", lazy.spawn("dmenu_run")),
    Key([mod], "c", lazy.spawn("st -e ncmpcpp")),
    Key([mod], "v", lazy.spawn(terminal + " -e ranger")),
    Key([mod], "e", lazy.spawn("emacs")),
    Key([mod, "shift"], "m", lazy.spawn("bookmarks")),

    Key([mod], "w", lazy.window.kill()),
    Key([mod], "m", lazy.window.toggle_fullscreen()),
    Key([mod], "s", lazy.window.toggle_floating()),
    Key([mod, "shift"], "r", lazy.reload_config()),
    Key([mod, "shift"], "q", lazy.shutdown()),
]
