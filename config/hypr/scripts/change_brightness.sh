#!/usr/bin/env bash

ID=1000
TIMEOUT=2000

get-brightness() {
    echo $(($(brightnessctl get) * 100 / $(brightnessctl max)))
}

main() {
    case "$1" in
        up)
            brightnessctl -e set +3%
            ;;
        down)
            brightnessctl -e set 3%-
            ;;
        *)
            dunstify "change_brightness.sh" "Argument \"$1\" is not valid." -u critical
            exit 1
            ;;
    esac

    dunstify "Brillo" -h int:value:"$(get-brightness)" -r $ID -t $TIMEOUT
}

main "$@"
