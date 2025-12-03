#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    app2unit
    loupe
    nautilus
    niri
    papers
    swww
    waybar
    wl-clipboard
    xdg-desktop-portal-gnome
)

install "${packages[@]}"
