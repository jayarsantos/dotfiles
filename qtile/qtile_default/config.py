# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import socket
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "st"
launcher1 = "rofi -modi run,drun,window -lines 12 -padding 18 -width 60 \
                -location 0 -show drun -sidebar-mode -columns 3"
launcher2 = "dmenu_run -fn 'Source Code Pro Regular-11' -i -l 10 \
        -p 'Run:' -nb '#2d2d2d' -nf '#cccccc' -sb '#ff033e' -sf '#38000d'"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(),
        desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(),
        desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),
        desc="Grow window up"),
    # for xmonad-tall
    Key([mod], "i", lazy.layout.grow(),
        desc="Grow in monad tall"),
    Key([mod], "u", lazy.layout.shrink(),
        desc="Shrink in monad tall"),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    Key([mod], "t", lazy.window.toggle_floating(),
        desc="Toggle floating on focused window"),
    Key([mod], "m", lazy.window.toggle_minimize(),
        desc="Toggle minimization on focused window"),
    Key([mod, "shift"], "m", lazy.group.unminimize_all(),
        desc="Unminimize all windows on current group"),
    Key([mod], "f", lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal),
            desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(),
            desc="Toggle between layouts"),
    Key([mod, "control"], "x", lazy.window.kill(),
            desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(),
            desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(),
            desc="Shutdown Qtile"),
    Key([mod], "p", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([mod], "y", lazy.spawn(launcher1),
        desc="launch application launcher"),
    Key([mod, "control"], "y", lazy.spawn(launcher2),
        desc="launch application launcher"),
    Key([mod], "F10", lazy.spawn("./.local/bin/volume_change.sh volup"),
        desc="Raise sound volume"
        ),
    Key([mod], "F9", lazy.spawn("./.local/bin/volume_change.sh voldown"),
        desc="Lower sound volume"
        ),
    Key(["control"], "F9", lazy.spawn("./.local/bin/volume_change.sh volmute"),
        desc="Mute sound volume"
        ),

    # App bindings
    KeyChord([mod], "l", [
        Key([], "g", lazy.spawn("google-chrome-stable")),
        Key([], "c", lazy.spawn("gnome-calculator")),
        Key([], "f", lazy.spawn("firefox")),
        Key([], "x", lazy.spawn("thunar")),
        Key([], "t", lazy.spawn("thunderbird"))
        ]),
]



group_names = [
    ("code", {"layout": "monadtall",
        "matches": [Match(wm_class=["Alacritty"])]}
        ),
    ("web", {"layout": "max",
        "matches": [Match(wm_class=["Google-chrome", "firefox"])]}
        ),
    ("email", {"layout": "max",
        "matches": [Match(wm_class=["Thunderbird"])]}
        ),
    ("files", {"layout": "max",
        "matches": [Match(wm_class=["Thunar"])]}
        ),
    ("movie", {"layout": "max",
        "matches": [Match(wm_class=["Io.github.celluloid_player.Celluloid"])]}
        ),
    ("music", {"layout": "max"}),
    ("tv", {"layout": "max"}),
    ("coffee", {"layout": "floating"}),
    ("bone", {"layout": "monadtall"}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

colors = [
    ["#1c2023", "#1c2023"],  # background 0
    ["#d8dee9", "#d8dee9"],  # foreground 1
    ["#3b4252", "#3b4252"],  # background lighter 2
    ["#bf616a", "#bf616a"],  # red 3
    ["#a3be8c", "#a3be8c"],  # green 4
    ["#ebcb8b", "#ebcb8b"],  # yellow 5
    ["#81a1c1", "#81a1c1"],  # blue 6
    ["#b48ead", "#b48ead"],  # magenta 7
    ["#88c0d0", "#88c0d0"],  # cyan 8 (inactive fonts)
    ["#e5e9f0", "#e5e9f0"],  # white 9
    ["#4c566a", "#4c566a"],  # grey 10
    ["#d08770", "#d08770"],  # orange 11
    ["#8fbcbb", "#8fbcbb"],  # super cyan 12
    ["#5e81ac", "#5e81ac"],  # super blue 13
    ["#242831", "#242831"],  # super dark background 14
]

layout_theme = {
    "border_width": 2,
    "margin": 9,
    "border_focus": colors[4],
    "border_normal": colors[8],
    "font": "FiraCode Nerd Font",
    "grow_amount": 2,
    "fullscreen_border_width": 2,
    "max_border_width": 2,
    "border_focus_stack": ['#d75f5f', '#8f3d3d'],
}

layouts = [
    layout.MonadTall(
        **layout_theme
        ),
    layout.MonadWide(
        **layout_theme
        ),
    layout.Columns(
        **layout_theme,
        ),
    layout.Max(
        **layout_theme
        ),
    layout.Floating(
        **layout_theme,
        ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font='FiraCode Nerd Font',
    fontsize=12,
    padding=3,
    background=colors[0]
)
extension_defaults = widget_defaults.copy()

group_box_settings = {
        "padding": 5,
        "borderwidth": 3,
        "active": colors[9],
        "inactive": colors[8],
        "disable_drag": True,
        "rounded": True,
        "margin_y": 3,
        "margin_x": 2,
        "padding_y": 5,
        "padding_x": 4,
        # hide_unused" :True,
        "highlight_color": colors[1],
        "highlight_method": "block",
        "this_current_screen_border": colors[3],
        "this_screen_border": colors[1],
        "other_current_screen_border": colors[1],
        "other_screen_border": colors[1],
        "foreground": colors[8],
        "background": colors[14],
        }

line_sep_settings = {
        "linewidth": 0,
        "padding": 10,
        "foreground": colors[1],
        }

screens = [
    Screen(
        wallpaper="~/Pictures/Wallpapers/solohouse.jpg",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.Sep(
                    **line_sep_settings,
                    ),
                widget.CurrentLayout(
                    foreground=colors[1],
                    ),
                widget.Sep(
                    **line_sep_settings,
                    ),
                widget.GroupBox(
                    **group_box_settings,
                    ),
                widget.Sep(
                    **line_sep_settings,
                    ),
                widget.Prompt(
                    prompt=prompt,
                    font="FiraCode Nerd Font",
                    padding=10,
                    foreground=colors[9],
                    background=colors[3]
                    ),
                widget.Sep(
                    **line_sep_settings,
                    ),
                widget.WindowName(
                    foreground=colors[8],
                    ),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Sep(
                    **line_sep_settings,
                    ),
                widget.CapsNumLockIndicator(
                    foreground=colors[4],
                    ),
                widget.Sep(
                    **line_sep_settings,
                    ),
                widget.Systray(
                    padding=5,
                    ),
                widget.Sep(
                    **line_sep_settings,
                    ),
                widget.Clock(
                    foreground=colors[8],
                    format = "%A, %B %d - %H:%M "
                    ),
                widget.Volume(
                    foreground=colors[8],
                    padding=5
                    ),
                widget.QuickExit(
                    foreground=colors[8],
                    ),
                widget.Sep(
                    **line_sep_settings,
                    ),
            ],
            24,
            margin=[10, 15, 5, 15],
        ),
        bottom=bar.Gap(18),
        left=bar.Gap(18),
        right=bar.Gap(18),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_type="utility"),
    Match(wm_type="notification"),
    Match(wm_type="toolbar"),
    Match(wm_type="splash"),
    Match(wm_type="dialog"),
    Match(wm_class="confirm"),
    Match(wm_class="dialog"),
    Match(wm_class="download"),
    Match(wm_class="error"),
    Match(wm_class="file_progress"),
    Match(wm_class="notification"),
    Match(wm_class="splash"),
    Match(wm_class="toolbar"),
    Match(wm_class="pomotroid"),
    Match(wm_class="cmatrixterm"),
    Match(title="Farge"),
    Match(wm_class="org.gnome.Nautilus"),
    Match(wm_class="feh"),
    Match(wm_class="gnome-calculator"),
    Match(wm_class="blueberry"),
    Match(wm_class="Transmission-gtk"),
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
