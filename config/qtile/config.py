# ============
# QTILE CONFIG
# ============

import os
import subprocess
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook

mod = "mod4"
terminal = "alacritty"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "control"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return",  lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Audio
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q sset Master 5%- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q sset Master 5%+ unmute")),
    # Backlight
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +5")),
    # Programs
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod], "r", lazy.spawn("rofi -show drun -show-icons"), desc="Launch Rofi"),
    Key([mod], "e", lazy.spawn("pcmanfm")),
    Key([], "Print", lazy.spawn("maim -s ~/Imágenes/$(date +%s).png"))
]

groups = [Group(i) for i in "12345"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(
        border_focus = "#9c9c9c",
        border_normal = "#595959",
        margin = 8,
        margin_on_single = 0
        ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.MonadTall(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font = 'Roboto',
    foreground = '#d1d1d1',
    fontsize = 15
)
extension_defaults = widget_defaults.copy()

separator = widget.TextBox(" ", padding=0)

screens = [
    Screen(
        wallpaper="/home/warbacon/Imágenes/layered-waves-haikei.png",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.TextBox("\uf303", fontsize=20, mouse_callbacks={'Button1': lazy.spawn("rofi -show drun -show-icons")}),
                widget.GroupBox(
                    rounded = False,
                    active = '#d1d1d1',
                    block_highlight_text_color='#d1d1d1',
                    this_current_screen_border='#333333',
                    inactive="#7c7b7b",
                    highlight_method="block",
                    borderwidth = 6
                    ),
                separator,
                widget.CurrentLayout(background = '#333333'),
                # widget.WindowName(max_chars=75),
                widget.TaskList(
                    highlight_method = 'block',
                    rounded = False,
                    border = '#333333',
                    title_width_method = 'uniform',
                    margin_y = 0,
                    margin_x = 8,
                    padding_y = 4,
                    icon_size = 0,
                    max_title_width=1920),
                widget.Battery(
                    notify_below = 0.15,
                    full_char = '',
                    show_short_text = False,
                    low_foreground = '#f7768e',
                    low_percentage = 0.15,
                    discharge_char='\uf57e',
                    charge_char='\uf0e7',
                    format='{char} {percent:2.0%}',
                    background='#333333'
                ),
                widget.Backlight(
                    backlight_name="amdgpu_bl0",
                    format='\ufaa7 {percent:2.0%}',
                    background='#333333',
                ),
                widget.Volume(
                    volume_app = 'pavucontrol',
                    limit_max_volume = True,
                    fmt='墳 {}',
                    background='#333333',
                ),
                widget.Wlan(
                    format='\uf1eb {essid}',
                    interface="wlp2s0",
                    disconnected_message='\uead0 Sin conexión',
                    background='#333333',
                ),
                separator,
                widget.Clock(format=" %A %d/%m/%Y", background='#333333'),
                separator,
                widget.Clock(format=" %-H:%M ", background='#333333'),
                                widget.Systray(
                    ),

            ],
            30,
            background="#141414",
            border_width=[6, 6, 6, 6],
            border_color=["141414", "141414", "141414", "141414"],
            # margin = 4
            ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(
    border_focus="#9c9c9c",border_normal="#333333", border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="huiontablet"),  # gitk
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="Ejecutar archivo"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])
