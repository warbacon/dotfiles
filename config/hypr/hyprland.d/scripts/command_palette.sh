#!/usr/bin/env bash

options="Conmutar luz nocturna\nRecargar Hyprland\nSuspender\nSalir de Hyprland\nApagar\nReiniciar"

selected="$(echo -e "$options" | rofi -dmenu -i -p Opciones)"

case "$selected" in
    "Conmutar luz nocturna")
        if pgrep gammastep; then
            killall gammastep
        else
            gammastep -O 3500
        fi
        ;;
    "Recargar Hyprland")
        hyprctl reload
        ;;
    "Suspender")
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
