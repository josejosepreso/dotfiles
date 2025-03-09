from libqtile.config import Key
from libqtile import hook
from libqtile.lazy import lazy
from libqtile.log_utils import logger
import subprocess, re

mod = "mod4"
alt = "mod1"
terminal = "urxvt"

def toggle_screens(qtile):
    screens = qtile.get_screens()
    if len(list(screens)) < 2 or not list(qtile.windows()):
        return

    group = screens[0]["group"]

    if qtile.current_group.name == group:
        qtile.groups_map[screens[1]["group"]].toscreen()
        return
    qtile.groups_map[group].toscreen()

def toggle_groups_clients(qtile):
    screens = qtile.get_screens()
    
    if len(list(screens)) < 2 or not list(qtile.windows()):
        return
    
    def get_clients_ids(group):
        return list(
            map(lambda x: x["id"],
                list(filter(lambda x: x["group"] == group.name, qtile.windows()))
                )
        )

    group1 = qtile.groups_map[screens[0]["group"]]
    group2 = qtile.groups_map[screens[1]["group"]]

    clients1 = get_clients_ids(group1)
    clients2 = get_clients_ids(group2)

    for client in clients1 + clients2:
        if client in clients1:
            qtile.windows_map[client].togroup(group2.name)
            continue
        qtile.windows_map[client].togroup(group1.name)

def go_to_occupied(qtile, right):
    if not list(qtile.windows()):
        return
    
    groups, i = qtile.get_groups(), list(qtile.get_groups()).index(qtile.current_group.name)
    groups_list = list(groups)[(i + 1):] + list(groups)[:i]
    if not right:
        groups_list = reversed(groups_list)
    
    for group in groups_list:
        if groups[group]["windows"]:
            qtile.groups_map[group].toscreen()
            break
    
def is_running(process):
    s = subprocess.Popen(["ps", "axuw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x.decode("utf-8")):
            return True
    return False

def mpd(qtile):
    qtile.groups_map[str(list(qtile.get_groups())[6])].toscreen()
    if not is_running("ncmpcpp"):
        qtile.spawn("st -e ncmpcpp")
    
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

    Key([mod], "bracketleft", lazy.function(go_to_occupied, False)),
    Key([mod], "bracketright", lazy.function(go_to_occupied, True)),

    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "p", lazy.spawn("dmenu_run")),
    Key([mod], "c", lazy.function(mpd)),
    Key([mod], "v", lazy.spawn(terminal + " -e ranger")),
    Key([mod], "e", lazy.spawn("emacs")),
    Key([mod, "shift"], "m", lazy.spawn("bookmarks")),
    Key([], "Print", lazy.spawn("flameshot gui")),
    # Media
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +3%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 3%-")),
    Key([], "XF86AudioNext", lazy.spawn("mpc next")),
    Key([], "XF86AudioPrev", lazy.spawn("mpc prev")),
    Key([], "XF86AudioPlay", lazy.spawn("mpc toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("mpc volume -5")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("mpc volume +5")),

    Key([mod], "w", lazy.window.kill()),
    Key([mod], "m", lazy.window.toggle_fullscreen()),
    Key([mod], "s", lazy.window.toggle_floating()),
    Key([mod, "shift"], "comma", lazy.window.toscreen(0)),
    Key([mod, "shift"], "period", lazy.window.toscreen(1)),

    Key([mod, "shift"], "r", lazy.reload_config()),
    Key([mod, "shift"], "q", lazy.shutdown()),

    Key([mod], "tab", lazy.function(toggle_screens)),
    Key([alt], "tab", lazy.screen.toggle_group()),
]
