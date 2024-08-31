#!/bin/env bash

options=(
    "Conmutar luz nocturna"
    "Suspender"
    "Apagar"
    "Reiniciar"
)

selected="$(printf "%s\n" "${options[@]}" | rofi \
    -theme-str "listview { scrollbar: false; } window { width: 500px; }" \
    -dmenu -i -l 4 -p Opciones)"

case "$selected" in
    "Conmutar luz nocturna")
        pkill gammastep || gammastep -O 3500
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
    *)
        exit 1
        ;;
esac
