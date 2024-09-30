#!/bin/env bash

ID=1000
TIMEOUT=2000

get-volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

main() {
    case "$1" in
        up)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
            notify-send "Aumentar Volumen" "$(get-volume)%" -h int:value:"$(get-volume)" -r $ID -t $TIMEOUT
            canberra-gtk-play -i audio-volume-change -d "changeVolume"
            ;;
        down)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            notify-send "Bajar volumen" "$(get-volume)%" -h int:value:"$(get-volume)" -r $ID -t $TIMEOUT
            canberra-gtk-play -i audio-volume-change -d "changeVolume"
            ;;
        *)
            notify-send "change_volume.sh" "Argument \"$1\" is not valid." -u critical
            ;;
    esac
}

main "$@"
