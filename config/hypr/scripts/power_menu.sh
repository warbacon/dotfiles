#!/usr/bin/env bash

options="Conmutar luz nocturna\nSuspender\nSalir de Hyprland\nApagar\nReiniciar"

selected="$(echo -e "$options" | rofi -dmenu -i -l 5 -p Opciones -no-show-icons)"

case "$selected" in
    "Conmutar luz nocturna")
        if pgrep gammastep; then
            killall gammastep
        else
            gammastep -O 3500
        fi
        ;;
    "Suspender")
        swaylock &
        systemctl suspend
        ;;
    "Salir de Hyprland")
        hyprctl dispatcher exit
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
