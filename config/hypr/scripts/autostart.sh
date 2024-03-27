#!/bin/sh

reload() {
    pgrep "$1" && killall "$1"
    "$@" &
}

run() {
    pgrep "$1" || "$@" &
}

reload hyprpaper
reload waybar
reload hypridle
run nm-applet
run blueman-applet
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run wl-clip-persist --clipboard regular
