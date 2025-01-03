#!/usr/bin/env bash

options=(
    "Conmutar luz nocturna"
    "Suspender"
    "Apagar"
    "Reiniciar"
    "Cerrar sesión"
)

selected="$(printf "%s\n" "${options[@]}" | rofi \
    -dmenu -i -p Opciones)"

case "$selected" in
    "Conmutar luz nocturna")
        pkill hyprsunset || hyprsunset -t 3500
        ;;
    "Suspender")
        systemctl suspend
        ;;
    "Apagar")
        systemctl poweroff
        ;;
    "Reiniciar")
        systemctl reboot
        ;;
    "Cerrar sesión")
        if pgrep Hyprland; then
            hyprctl dispatch exit
        else
            pkill -KILL -u "$USER"
        fi
        ;;
    *)
        exit 1
        ;;
esac
