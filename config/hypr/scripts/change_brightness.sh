#!/bin/env bash

ID=1000
TIMEOUT=2000

get-brightness() {
    echo $(($(brightnessctl get) * 100 / $(brightnessctl max)))
}

main() {
    case "$1" in
        up)
            brightnessctl -e set +3%
            notify-send "Aumentar brillo" "$(get-brightness)%" -h int:value:"$(get-brightness)" -r $ID -t $TIMEOUT
            ;;
        down)
            brightnessctl -e set 3%-
            notify-send "Bajar brillo" "$(get-brightness)%" -h int:value:"$(get-brightness)" -r $ID -t $TIMEOUT
            ;;
        *)
            notify-send "change_brightness.sh" "Argument \"$1\" is not valid." -u critical
            ;;
    esac
}

main "$@"
