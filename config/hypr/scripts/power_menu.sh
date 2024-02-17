#!/usr/bin/env bash

options="Salir de Hyprland\nSuspender\nApagar\nReiniciar"

selected="$(echo -e "$options" | fuzzel --dmenu)"

case "$selected" in
    "Salir de Hyprland")
        hyprctl dispatcher exit
        ;;
    "Suspender")
        swaylock &
        systemctl suspend
        ;;
    "Apagar")
        systemctl poweroff
        ;;
    "Reiniciar")
        systemctl reboot
        ;;
    *)
        echo "Error."
        ;;
esac
