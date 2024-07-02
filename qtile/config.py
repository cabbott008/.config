# Copyright Notice at the bottom
import os
# import re
# import socket
import subprocess
# from libqtile import qtile
# from typing import List  # noqa: F401
from libqtile.config import Drag, Group, Key, Screen, Match  # Rule, Click
# from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
# from libqtile.widget import Spacer

# mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


# Most of our keybindings are in sxhkd file - except these
keys = [
    # SUPER + FUNCTION KEYS
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    # SUPER + SHIFT KEYS
    Key([mod, "shift"], "r", lazy.restart()),
    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),
    # CHANGE FOCUS
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    # RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),
    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    # MOVE FOCUS TO THE OTHER SCREEN
    Key([mod], "semicolon", lazy.next_screen()),
    ]


def window_to_small_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen is True:
            qtile.cmd_to_screen(i - 1)


def window_to_big_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen is True:
            qtile.cmd_to_screen(i + 1)


# MOVE WINDOW TO NEXT SCREEN
keys.extend([
    Key([mod, "shift"], "comma", lazy.function(window_to_small_screen,
        switch_screen=True)),
    Key([mod, "shift"], "period", lazy.function(window_to_big_screen,
        switch_screen=True)),
])

# GROUPS
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒"]
group_layouts = ["monadtall",
                 "monadtall",
                 "monadtall",
                 "monadtall",
                 "monadtall",
                 "monadtall",
                 "monadtall",
                 "monadtall",
                 "monadtall",
                 ]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([
        # CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
        # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
        Key(["mod1", "shift"], i.name, lazy.window.togroup(i.name)),
        # MOVE WINDOW TO SELECTED WORKSPACE 1-10, FOLLOW WINDOW TO WORKSPACE
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            lazy.group[i.name].toscreen()),
    ])


def init_layout_theme():

    return {"margin": 15,
            "border_width": 8,
            "change_ratio": 0.02,
            "border_focus": "#fba922",
            "border_normal": "#4c566a"
            }


layout_theme = init_layout_theme()

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.MonadThreeCol(**layout_theme),
    layout.Max(**layout_theme),
]


# COLORS FOR THE BAR
def init_colors():

    return [["#000000", "#000000"],  # color 0
            ["#2F343F", "#2F343F"],  # color 1
            ["#c0c5ce", "#c0c5ce"],  # color 2
            ["#fba922", "#fba922"],  # color 3
            ["#3384d0", "#3384d0"],  # color 4
            ["#f3f4f5", "#f3f4f5"],  # color 5
            ["#cd1f3f", "#cd1f3f"],  # color 6
            ["#62FF00", "#62FF00"],  # color 7
            ["#6790eb", "#6790eb"],  # color 8
            ["#a9a9a9", "#a9a9a9"]]  # color 9


colors = init_colors()


# WIDGETS FOR THE BAR
def init_widgets_defaults():

    return dict(font="Noto Sans",
                fontsize=46,
                padding=6,
                background=colors[1])


widget_defaults = init_widgets_defaults()


def init_widgets_list():
    #   prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        widget.GroupBox(
            font="FontAwesome",
            fontsize=40,
            margin_y=3,
            margin_x=2,
            padding_y=3,
            padding_x=2,
            borderwidth=8,
            disable_drag=True,
            active=colors[3],
            inactive=colors[5],
            rounded=False,
            highlight_color=colors[0],
            highlight_method="line",
            this_screen_border=colors[4],
            this_current_screen_border=colors[3],
            other_screen_border=colors[5],
            other_current_screen_border=colors[6],
            urgent_alert_method="border",
            urgent_border=colors[6],
            foreground=colors[2],
            background=colors[1]
            ),
        widget.Sep(
            linewidth=5,
            padding=12,
            foreground=colors[3],
            background=colors[1]
            ),
        widget.CurrentLayout(
            font="Noto Sans Bold",
            fontsize=32,
            foreground=colors[5],
            background=colors[1]
            ),
        widget.Sep(
            linewidth=5,
            padding=12,
            foreground=colors[3],
            background=colors[1]
            ),
        widget.WindowName(
            font="Noto Sans",
            fontsize=36,
            foreground=colors[5],
            background=colors[1],
            ),
        widget.Sep(
            linewidth=5,
            padding=12,
            foreground=colors[3],
            background=colors[1]
            ),
        widget.Clock(
            foreground=colors[5],
            background=colors[1],
            fontsize=46,
            format="%H:%M:%S"
            ),
        widget.Sep(
            linewidth=5,
            padding=12,
            foreground=colors[3],
            background=colors[1]
            ),
        widget.Clock(
            foreground=colors[5],
            background=colors[1],
            fontsize=46,
            format="%Y-%m-%d"
            ),
        widget.Sep(
            linewidth=5,
            padding=12,
            foreground=colors[3],
            background=colors[1]
            ),
        widget.Battery(
            font="Noto Sans",
            foreground=colors[5],
            background=colors[1],
            charge_char='➚',
            discharge_char='➘',
            fontsize=46,
            update_interval=20,
            format='{percent:2.0%} {char} {min:02}m'
            ),
        widget.Sep(
            linewidth=5,
            padding=12,
            foreground=colors[3],
            background=colors[1]
            ),
        widget.Systray(
            foreground=colors[5],
            background=colors[1],
            padding=5,
            fontsize=42,
            ),
        ]
    return widgets_list


# Screens
def init_widgets_screen2():

    widgets_screen2 = init_widgets_list()
    return widgets_screen2


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    widgets_screen1.pop()
    return widgets_screen1


def init_screens():
    return [Screen(bottom=bar.Bar(widgets=init_widgets_screen1(),
                                  size=48,
                                  opacity=0.8),
                   wallpaper='~/.config/qtile/1-Monitor.jpg',
                   wallpaper_mode='fill'
                   ),
            Screen(bottom=bar.Bar(widgets=init_widgets_screen2(),
                                  size=48,
                                  opacity=0.8),
                   wallpaper='~/.config/qtile/2-Main.jpg',
                   wallpaper_mode='fill'
                   ),
            ]

screens = init_screens()
widgets_list = init_widgets_list()
widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()

# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

main = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/autostart.sh'])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='confirm'),
    Match(wm_class='Zoom Workplace'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Arandr'),
    Match(wm_class='feh'),
    Match(wm_class='Galculator'),
    Match(wm_class='archlinux-logout'),
    Match(wm_class='xfce4-terminal'),

],  fullscreen_border_width=0, border_width=0)

# Qtile defaults to left_ptr, this allows custom
from libqtile import hook
@hook.subscribe.startup
def runner():
    import subprocess
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

auto_fullscreen = True
focus_on_window_activation = "smart"  # or focus
reconfigure_screens = True

wmname = "Qtile"
