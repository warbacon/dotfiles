#!/usr/bin/env bash
set -euo pipefail

# Verify that a mode is provided
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <fullscreen|select>" >&2
    exit 1
fi

MODE="$1"
FILENAME="$(date +'%Y-%m-%d-%H%M%S.png')"
OUTPUT="/tmp/$FILENAME"

case "$MODE" in
    fullscreen)
        # Capture full screen: grim writes to stdout, redirected to the file
        grim - > "$OUTPUT"
        ;;
    select)
        # Capture a selected area: get geometry with slurp
        grim -g "$(slurp -b 00000077 -w 0)" - > "$OUTPUT"
        ;;
    *)
        # Handle unknown mode
        echo "Unknown mode: $MODE" >&2
        exit 1
        ;;
esac

# If the screenshot was successfully saved, notify and copy to clipboard
if [[ -f "$OUTPUT" ]]; then
    wl-copy < "$OUTPUT"
    ACTION=$(dunstify "Captura de pantalla realizada" "Copiada y guardada en $OUTPUT." -i "$OUTPUT" -A "open,Abrir imagen")
    if [[ "$ACTION" == "open" ]]; then
        # Open the image if user selects "open"
        xdg-open "$OUTPUT"
    fi
fi

