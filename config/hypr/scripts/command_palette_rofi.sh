#!/usr/bin/env bash

options=(
    "Conmutar luz nocturna"
    "Suspender"
    "Apagar"
    "Reiniciar"
    "Cerrar sesión"
)

if [ "$@" ]; then
    case "$1" in
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
else
    for msg in "${options[@]}"; do
        echo "$msg"
    done
fi
