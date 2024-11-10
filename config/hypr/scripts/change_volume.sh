#!/bin/bash

ID=1000
TIMEOUT=2000

get-volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

main() {
    case "$1" in
        up)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0
            dunstify "Volumen" -h int:value:"$(get-volume)" -r $ID -t $TIMEOUT
            canberra-gtk-play -i audio-volume-change -d "changeVolume"
            ;;
        down)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            dunstify "Volumen" -h int:value:"$(get-volume)" -r $ID -t $TIMEOUT
            canberra-gtk-play -i audio-volume-change -d "changeVolume"
            ;;
        muteaudio)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            IS_AUDIO_MUTED="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo true || echo false)"
            dunstify "Audio $([[ $IS_AUDIO_MUTED = true ]] && echo desactivado || echo activado)" -r $ID -t $TIMEOUT
            ;;
        mutemic)
            wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
            IS_MIC_MUTED="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo true || echo false)"
            dunstify "Micrófono $([[ $IS_MIC_MUTED = true ]] && echo desactivado || echo activado)" -r $ID -t $TIMEOUT
            ;;
        *)
            dunstify "change_volume.sh" "Argument \"$1\" is not valid." -u critical
            exit 1
            ;;
    esac
}

main "$@"
