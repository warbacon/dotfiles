#!/usr/bin/env bash

declare -a OPTIONS=(
    "Luz nocturna"
    "Suspender"
    "Apagar"
    "Reiniciar"
    "Cerrar sesión"
)

STYLES="window { width: 500px; } listview { scrollbar: false; }"
selected="$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -i -p Comandos -l 5 -theme-str "$STYLES")"

case "$selected" in
    "Luz nocturna")
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
        hyprctl dispatch exit || pkill -KILL -u "$USER"
        ;;
    *)
        echo "Se ha liado."
        exit 1
        ;;
esac
