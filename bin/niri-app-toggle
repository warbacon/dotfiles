#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "You need to specify a program to run."
    exit 1
fi

if ! which "$1" >/dev/null 2>&1; then
    echo "$1 isn't an installed program."
    exit 1
fi

PROGRAM="$1"
ID="special-$PROGRAM"

niri msg windows | grep -q "App ID: \"$ID\""
app_exists=$?

if [ $app_exists -eq 1 ]; then
    case "$(xdg-terminal-exec --print-cmd)" in
        "kitty")
            kitty --class="$ID" -o confirm_os_window_close=0 -e "$PROGRAM"
            ;;
        "footclient")
            footclient --app-id="$ID" -e "$PROGRAM"
            ;;
        *)
            xdg-terminal-exec --app-id="$ID" -e "$PROGRAM"
            ;;
    esac
else
    niri msg focused-window | grep -q "App ID: \"$ID\""
    is_focused=$?

    if [ $is_focused -eq 0 ]; then
        niri msg action close-window
    else
        window_id="$(niri msg -j windows | jq -r ".[] | select(.app_id == \"$ID\") | .id" | head -1)"
        niri msg action focus-window --id "$window_id"
    fi
fi
