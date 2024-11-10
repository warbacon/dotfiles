#!/bin/bash

current="$(brightnessctl get)"

if [[ "$current" -gt 10 ]]; then
    brightnessctl -s set 10
else
    brightnessctl -s set "$current"
fi
