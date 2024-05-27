#!/bin/sh

reload() {
    pgrep "$1" && killall "$1"
    "$@" &
}

run() {
    pgrep "$1" || "$@" &
}

run swww-daemon
reload waybar
run wl-clip-persist --clipboard regular
reload hypridle
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
