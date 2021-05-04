from typing import List  # noqa: F401
from itertools import chain

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Match, Screen
from libqtile.config import EzKey as Key
from libqtile.config import Key as FullKey
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger

# For debugging at ~/.local/share/qtile/qtile.log
# qtile's INFO is a bit too spammy so we just use it as a WARNING
def debug(debug_str):
    logger.warning(f'\nDEBUG:{debug_str}\n')

mod = "mod4"
terminal = guess_terminal()

colors = {
    'background': '1f1e34',
    'highlight_background': '36345b',
    'contrast': '4c73c2',
    'highlight': 'a32bb6',
    'highlight_bright': 'c75ad8',
    'foreground': 'FFFFFF',
    'black': '000000',
}

# Note: Qtile needs this as a list.
#       Had to debug with `startx &; qtile start` as no log output was produced
groups = [Group(str(i)) for i in range(1, 10)]

def switch_group(group_name):
    """
    If the group is visible on another screen, switches screen to that screen.
    Otherwise it will switch the group displayed on the current screen using
    default functionality.
    """
    def callback(qtile):
        group = qtile.groups_map[group_name]
        current_screen = qtile.current_screen


        # Group has a screen and it's not the currently active one
        if group.screen is not None and group.screen != current_screen:
            qtile.cmd_to_screen(group.screen.index)
        else:
            current_screen.set_group(group)
        return

    return callback

def swap_to_other_screen():
    """
    Moves the current window to the other screen and vice versa.
    """

    def callback(qtile):
        next_screen_index = (qtile.current_screen.index + 1) % len(qtile.screens)
        next_screen = qtile.screens[next_screen_index]
        next_group = next_screen.group
        debug(next_group.name)
        return qtile.current_window.togroup(next_group.name)

    return callback

def cycle_visible(mode='forward'):
    """
    Cycles back or forward between currently visible windows.

    mode: 'foward' \ 'reverse'
        defaults to 'forward' if not explicitly 'reverse'
    """

    def callback(qtile):
        current_window = qtile.current_window
        current_group = qtile.current_group
        current_screen = qtile.current_screen

        visible_groups = [screen.group for screen in qtile.screens]

        windows = list(
            chain.from_iterable([group.windows for group in visible_groups]))

        modifier = -1 if mode == 'reverse' else 1
        next_window = windows[
            (windows.index(current_window) + modifier) % len(windows)
        ]
        next_group = next_window.group
        next_screen = next_group.screen

        if next_screen != current_screen:
            qtile.cmd_to_screen(next_screen.index)

        next_group.focus(next_window, warp=True)
        # cmd_focus had issues
        #next_window.cmd_focus(warp=True)


    return callback

def _keys():

    def keys_movement_between_windows():
        return [
            Key("M-h", lazy.layout.left(),
                desc="Move focus to left"),
            Key("M-l", lazy.layout.right(),
                desc="Move focus to right"),
            Key("M-j", lazy.layout.down(),
                desc="Move focus down"),
            Key("M-k", lazy.layout.up(),
                desc="Move focus up"),
            Key("M-<space>", lazy.layout.next(),
                desc="Move window focus to other window"),
            Key("M-<Tab>", lazy.function(cycle_visible(mode='forward'))),
            Key("M-S-<Tab>", lazy.function(cycle_visible(mode='reverse'))),
        ]

    def keys_movement_of_windows():
        return [
            Key("M-S-h", lazy.layout.shuffle_left(),
                desc="Move window to the left"),
            Key("M-S-l", lazy.layout.shuffle_right(),
                desc="Move window to the right"),
            Key("M-S-j", lazy.layout.shuffle_down(),
                desc="Move window down"),
            Key("M-S-k", lazy.layout.shuffle_up(),
                desc="Move window up"),
        ]

    def keys_modify_window_size():
        return [
            Key("M-C-h", lazy.layout.grow_left(),
                desc="Grow window to the left"),
            Key("M-C-l", lazy.layout.grow_right(),
                desc="Grow window to the right"),
            Key("M-C-j", lazy.layout.grow_down(),
                desc="Grow window down"),
            Key("M-C-k", lazy.layout.grow_up(),
                desc="Grow window up"),
            Key("M-n", lazy.layout.normalize(),
                desc="Reset all window sizes"),
        ]

    def keys_layouts():
        return [
            Key("M-z", lazy.next_layout(),
                desc="Toggle between Layouts"),
        ]

    def keys_apps():
        return [
            Key("M-<Return>", lazy.spawn(terminal),
                desc="Launch terminal"),
            Key("M-S-q", lazy.window.kill(),
                desc="Kill focused window"),
            Key("M-r", lazy.spawncmd(),
                desc="Spawn a command using a prompt widget"),
        ]

    def keys_qtile():
        return [
            Key("M-C-r", lazy.restart(), desc="Restart Qtile"),
            Key("M-C-p", lazy.shutdown(), desc="Shutdown Qtile"),
        ]

    def keys_screens():
        return [
            Key("M-o", lazy.next_screen()),
            Key("M-S-o", lazy.function(swap_to_other_screen()))
        ]

    def keys_workspace_groups():

        return [
            Key(f'M-{group.name}',
                lazy.function(switch_group(group.name)))
            for group in groups
        ] + [
            Key(f"M-S-{group.name}",
                lazy.window.togroup(group.name, switch_group=True))
            for group in groups
        ]

    def keys_rofi():
        rofi_theme = 'config'
        return [
            Key('M-d', lazy.spawn('rofi -show combi -theme {}'.format(rofi_theme)))
        ]

    def keys_test():
        """ Tests some functionality """
        return [
            Key('M-t', lazy.function(switch_group('9')))
        ]

    def keys_light():
        return [
            FullKey([], 'XF86MonBrightnessDown', lazy.spawn("light -U 10")),
            FullKey([], 'XF86MonBrightnessUp', lazy.spawn("light -A 10")),
        ]

    return [
        *keys_movement_between_windows(),
        *keys_movement_of_windows(),
        *keys_modify_window_size(),
        *keys_layouts(),
        *keys_apps(),
        *keys_qtile(),
        *keys_screens(),
        *keys_workspace_groups(),
        *keys_rofi(),
        *keys_test(),
        *keys_light(),
    ]

def _layouts():
    def columns():
        return layout.Columns(border_focus_stack='#d75f5f', margin=5)

    def monadtall():
        return layout.MonadTall(margin=5,
                                border_normal=colors['black'],
                                border_focus=colors['highlight'],
                                border_width=4,
                                single_margin=5,
                                single_border_with=0)

    return [
        monadtall(),
        layout.Max(),
    ]

def _mouse():
    return [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
             start = lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
             start = lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
    ]

def _screens():
    def group_box():
        return widget.GroupBox(
            font='Ubuntu Bold',
            fontsize=10,
            hide_unused=True,
            highlight_method='line',
            active=colors['contrast'],
            #inactive=colors['contrast'],
            highlight_color=[#gradient
                colors['background'], colors['highlight_background']
            ],
            block_highlight_text_color=colors['highlight'],
            #this_screen_border=colors['highlight'],
            this_current_screen_border=colors['highlight'],
            other_screen_border=colors['background'],
            other_current_screen_border=colors['background']
        )

    def default_sep():
        return widget.Sep(
            linewidth=1,
            padding=10,
        )

    def window_name():
        return widget.WindowName(background=colors['background'])

    def battery():
        return widget.Battery(
            charge_char='\u2b06',
            discharge_char='\u2b07',
            show_short_text=False,
            low_foreground=colors['foreground'],
            low_percentage=0.3,
            background=colors['highlight'],
            format='\U0001F50B {percent:2.0%} {char}',
            fmt='{:9}'
        )

    def cpu():
        return widget.CPU(
            format='CPU {load_percent:>4}%',
            fmt='{:9}',
            padding=10,
            background=colors['contrast'],
            foreground=colors['foreground']

        )

    def net():
        # Workaround to get rid of decimals
        class Formatter:
            @staticmethod
            def format(interface, down, up):
                return ' '.join(['\U0001F4F6',
                                 '{:>3}'.format(down.strip()[:down.find('.')]),
                                 '↓↑',
                                 '{:>3}'.format(up.strip()[:up.find('.')]),
                                 'B'])

        return widget.Net(background=colors['highlight'], format=Formatter)

    def pomodoro():
        # A workaround their intended use of fmt,
        # using '|' to indicate where the hr 0's are to remove them
        class Formatter:
            @staticmethod
            def format(s):
                idx = s.find('|')
                if idx != -1:
                    return s[0:idx] + s[idx+3:]
                else:
                    return s

        return widget.Pomodoro(font='Ubuntu',
                               background=colors['background'],
                               color_active=colors['contrast'],
                               color_break=colors['highlight_bright'],
                               color_inactive=colors['foreground'],
                               fontsize=13,
                               prefix_active='\u23F1  - |',
                               prefix_inactive='\u23F1  - |0:25:00',
                               prefix_break='\u23F1 - |',
                               prefix_long_break='\u23F1 - |',
                               fmt=Formatter,
                               length_pomodori=25,
                               length_short_break=5,
                               length_long_break=15)

    def prompt():
        return widget.Prompt(background=colors['highlight_background'],
                             bell_style='visual')

    def clock():
        return widget.Clock(padding=0,
                            foreground=colors['foreground'],
                            background=colors['highlight_background'],
                            format='%A, %-I:%M%p (%Z) -- %d %m %-y',
                            fontsize=14,
                            font='Ubuntu mono')

    def wallpaper():
        return widget.Wallpaper(directory='~/.wallpapers/', label='')

    def shutdown():
        return widget.QuickExit(background=colors['contrast'], 
                                default_text='\u23FC',
                                fontsize=20)

    def widgets_primary():
        try:
            import psutil
        except:
            pass

        return [
            wallpaper(),
            group_box(),
            default_sep(),
            pomodoro(),
            default_sep(),
            prompt(),
            window_name(),
            net(),
            cpu(),
            battery(),
            widget.Sep(
                linewidth=1,
                padding=20,
                background=colors['highlight_background']
            ),
            clock(),
            widget.Systray(),
            widget.Sep(
                linewidth=1,
                padding=20,
                background=colors['highlight_background']
            ),
            shutdown(),
        ]

    def widgets_secondary():
        return [
            wallpaper(),
            group_box(),
            window_name(),
            battery()
        ]


    bars = { 'opacity': 1.0, 'size': 22, 'background': colors['background'] }
    return [
        Screen(top=bar.Bar(widgets_primary(), **bars)),
        Screen(top=bar.Bar(widgets_secondary(), **bars)),
    ]

def _floating_layout():
    return layout.Floating(float_rules = [
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ])

if __name__ in ["config", "__main__"]:
    widget_defaults = dict(
        font='Ubuntu Mono',
        fontsize=12,
        padding=5,
        background=colors['background']
    )
    extension_defaults = widget_defaults.copy()

    screens = _screens()
    keys = _keys()
    layouts = _layouts()
    mouse = _mouse()
    floating_layout = _floating_layout()

    # Default Options
    dgroups_key_binder=None
    dgroups_app_rules=[]  # type: List
    main=None  # WARNING: this is deprecated and will be removed soon
    follow_mouse_focus=True
    bring_front_click=False
    cursor_warp=False
    auto_fullscreen=True
    focus_on_window_activation="smart"
